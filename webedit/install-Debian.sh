#!/bin/bash

set -e

OPENSOURCE="false";
UPDATE="false";

while [ "$1" != "" ]; do
	case $1 in

		-os | --opensource )
			if [ "$2" != "" ]; then
				OPENSOURCE=$2
				shift
			fi
		;;

		-u | --update )
			if [ "$2" != "" ]; then
				UPDATE=$2
				shift
			fi
		;;

		-? | -h | --help )
			echo "  Usage $0 [PARAMETER] [[PARAMETER], ...]"
			echo "    Parameters:"
			echo "      -os, --opensource                 install opensource version (true|false)"
			echo "      -u, --update                      use to update existing components (true|false)"
			echo "      -?, -h, --help                    this help"
			echo
			exit 0
		;;

	esac
	shift
done


log_debug () {
	echo "onlyoffice: [debug] $1"
}

log_info () {
	echo "onlyoffice: [info] $1"
}

make_swap () {
	DISK_REQUIREMENTS=6144; #6Gb free space
	MEMORY_REQUIREMENTS=5500; #RAM ~6Gb

	AVAILABLE_DISK_SPACE=$(sudo df -m /  | tail -1 | awk '{ print $4 }');
	TOTAL_MEMORY=$(free -m | grep -oP '\d+' | head -n 1);
	EXIST=$(sudo swapon -s | awk '{ print $1 }' | { grep -x '/onlyoffice_swapfile' || true; });

	if [[ -z $EXIST ]] && [ ${TOTAL_MEMORY} -lt ${MEMORY_REQUIREMENTS} ] && [ ${AVAILABLE_DISK_SPACE} -gt ${DISK_REQUIREMENTS} ]; then
		sudo fallocate -l 6G /onlyoffice_swapfile
		sudo chmod 600 /onlyoffice_swapfile
		sudo mkswap /onlyoffice_swapfile
		sudo swapon /onlyoffice_swapfile
		sudo echo "/onlyoffice_swapfile none swap sw 0 0" >> /etc/fstab
	fi
}

command_exists () {
	type "$1" &> /dev/null;
}

if ! dpkg -l | grep -q "sudo"; then
	apt-get install -yq sudo
fi

if ! dpkg -l | grep -q "net-tools"; then
	apt-get install -yq net-tools
fi

#######################################
#  MAKE UPDATE
#######################################

if [ "$UPDATE" == "true" ]; then
	apt-get -y update

	curl -sL https://deb.nodesource.com/setup_8.x | bash -
	apt-get install -yq nodejs
	
	apt-get install -y --only-upgrade onlyoffice-controlpanel
	apt-get install -y --only-upgrade onlyoffice-documentserver-ie
	apt-get install -y --only-upgrade onlyoffice-communityserver
	exit;
fi

#######################################
#  END
#######################################


#######################################
#  CHECK PORTS
#######################################

if dpkg -l | grep -q "onlyoffice-communityserver"; then
	echo "ONLYOFFICE COMMUNITY SERVER already install"
elif sudo netstat -lnp | awk '{print $4}' | grep -qE ":80$|:443$|:5222$|:5280$|:9865$|:9888$|:9866$|:9871$|:9882$|:25$"; then
	echo "ONLYOFFICE COMMUNITY SERVER uses ports: 80, 443, 5222, 5280, 9865, 9888, 9866, 9871, 9882, 25";
	echo "please, make sure that the ports are free."
	exit
fi


if dpkg -l | grep -q "onlyoffice-documentserver"; then
	echo "ONLYOFFICE DOCUMENT SERVER already install"
elif sudo netstat -lnp | awk '{print $4}' | grep -qE ":8083$|:5432$|:5672$|:6379$|:8000$|:8080$"; then
	echo "ONLYOFFICE DOCUMENT SERVER uses ports: 8083, 5432, 5672, 6379, 8000, 8080";
	echo "please, make sure that the ports are free."
	exit
fi


if [ "$INSTALL_CONTROLPANEL" == "true" ]; then
	if dpkg -l | grep -q "onlyoffice-controlpanel"; then
		echo "ONLYOFFICE CONTROL PANEL already install"
	elif sudo netstat -lnp | awk '{print $4}' | grep -qE ":8082$|:9833$|:9834$"; then
		echo "ONLYOFFICE CONTROL PANEL uses ports: 8082, 9833, 9834";
		echo "please, make sure that the ports are free."
		exit
	fi
fi

#######################################
#  END
#######################################

MYSQL_SERVER_HOST=${MYSQL_SERVER_HOST:-"localhost"}
MYSQL_SERVER_DB_NAME=${MYSQL_SERVER_DB_NAME:-"onlyoffice"}
MYSQL_SERVER_USER=${MYSQL_SERVER_USER:-"root"}
MYSQL_SERVER_PASS=${MYSQL_SERVER_PASS:-"oNlYoFfIcE2017!"}

REV=`cat /etc/debian_version`
DIST='Debian'
if [ -f /etc/lsb-release ] ; then
	DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
	REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
	DISTRIB_CODENAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
elif [ -f /etc/lsb_release ] || [ -f /usr/bin/lsb_release ] ; then
	DIST=`lsb_release -a 2>&1 | grep 'Distributor ID:' | awk -F ":" '{print $2 }'`
	REV=`lsb_release -a 2>&1 | grep 'Release:' | awk -F ":" '{print $2 }'`
	DISTRIB_CODENAME=`lsb_release -a 2>&1 | grep 'Codename:' | awk -F ":" '{print $2 }'`
elif [ -f /etc/os-release ] ; then
        DISTRIB_CODENAME=$(grep "VERSION=" /etc/os-release |awk -F= {' print $2'}|sed s/\"//g |sed s/[0-9]//g | sed s/\)$//g |sed s/\(//g | tr -d '[:space:]')
fi

DIST=`echo "$DIST" | tr '[:upper:]' '[:lower:]' | xargs`;
DISTRIB_CODENAME=`echo "$DISTRIB_CODENAME" | tr '[:upper:]' '[:lower:]' | xargs`;

#######################################
#  INSTALL PREREQUISITES
#######################################

rm -f /etc/apt/sources.list.d/builds-ubuntu-sphinxsearch-rel22-bionic.list
rm -f /etc/apt/sources.list.d/certbot-ubuntu-certbot-bionic.list
rm -f /etc/apt/sources.list.d/mono-official.list

if [ "$DIST" = "debian" ] && [ $(apt-cache search ttf-mscorefonts-installer | wc -l) -eq 0 ]; then
		echo "deb http://ftp.uk.debian.org/debian/ $DISTRIB_CODENAME main contrib" >> /etc/apt/sources.list
		echo "deb-src http://ftp.uk.debian.org/debian/ $DISTRIB_CODENAME main contrib" >> /etc/apt/sources.list
fi

apt-get -y update

if ! dpkg -l | grep -q "locales"; then
	apt-get install -yq locales
fi

declare -x LANG="en_US.UTF-8"
declare -x LANGUAGE="en_US:en"
declare -x LC_ALL="en_US.UTF-8"

locale-gen en_US.UTF-8

if ! dpkg -l | grep -q "dirmngr"; then
	sudo apt-get install -yq dirmngr
fi

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install -yq curl;
fi

# add onlyoffice repo
echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5

# add mono repo
echo "deb http://download.mono-project.com/repo/$DIST stable-$DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/mono-official.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# add nodejs repo
curl -sL https://deb.nodesource.com/setup_8.x | bash -

# add nginx repo
#wget http://nginx.org/keys/nginx_signing.key
#apt-key add nginx_signing.key
#echo "deb http://nginx.org/packages/mainline/ubuntu/ $DISTRIB_CODENAME nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
#echo "deb-src http://nginx.org/packages/mainline/ubuntu/ $DISTRIB_CODENAME nginx" >> /etc/apt/sources.list.d/nginx.list


if ! dpkg -l | grep -q "add-apt-repository"; then
	apt-get install -yq software-properties-common
fi

# setup msttcorefonts
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

# setup mysql 5.7 package
curl -OL http://dev.mysql.com/get/mysql-apt-config_0.8.6-1_all.deb
echo "mysql-apt-config mysql-apt-config/select-server  select  mysql-5.7" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.6-1_all.deb
rm -f mysql-apt-config_0.8.6-1_all.deb

echo mysql-community-server mysql-community-server/root-pass password ${MYSQL_SERVER_PASS} | debconf-set-selections
echo mysql-community-server mysql-community-server/re-root-pass password ${MYSQL_SERVER_PASS} | debconf-set-selections
echo mysql-server-5.7 mysql-server/root_password password ${MYSQL_SERVER_PASS} | debconf-set-selections
echo mysql-server-5.7 mysql-server/root_password_again password ${MYSQL_SERVER_PASS} | debconf-set-selections

apt-get -y update


#install libevent

UBUNTU_ARCHIVE="http://archive.ubuntu.com/ubuntu/pool/main/libe/libevent"
ARCH="$(uname -m)"
LIBV="-2.0-5_2.0.21-stable-2"

install_dpkg () {
	if [ "$ARCH" = "x86_64" ]; then
			lib_name="$1"$2"_amd64.deb";
	else
			lib_name="$1"$2"_i386.deb";
	fi

	curl -OL "$3/$lib_name"
	dpkg -i $lib_name
	rm -f $lib_name
}

if [ "$DIST" = "ubuntu" ]; then
	install_dpkg libevent $LIBV $UBUNTU_ARCHIVE;
	install_dpkg libevent-core  $LIBV $UBUNTU_ARCHIVE;
	install_dpkg libevent-pthreads  $LIBV $UBUNTU_ARCHIVE;
fi

# install
apt-get install  -yq            wget \
				cron \
				rsyslog \
				mono-webserver-hyperfastcgi \
				ruby-dev \
				ruby-god \
				mono-complete \
				ca-certificates-mono \
				nodejs \
				mysql-server \
				mysql-client \
				htop \
				nano \
				dnsutils \
				postgresql \
				redis-server \
				rabbitmq-server


# add certbot repo
if [ "$DIST" = "ubuntu" ]; then
	add-apt-repository -y ppa:certbot/certbot
	
	if [ "$DISTRIB_CODENAME" != "bionic" ]; then
		add-apt-repository -y ppa:builds/sphinxsearch-rel22
	fi
	
	apt-get -y update
	
	sudo apt-get install -yq sphinxsearch
	sudo apt-get install -yq certbot
elif [ "$DIST" = "debian" ] && [ "$DISTRIB_CODENAME" = "stretch" ]; then
	sudo apt-get install -yq certbot
elif [ "$DIST" = "debian" ] && [ "$DISTRIB_CODENAME" = "jessie" ]; then
	echo "deb http://ftp.debian.org/debian jessie-backports main" | sudo tee /etc/apt/sources.list.d/jessie_backports.list
	apt-get -y update
	sudo apt-get install -yq certbot -t jessie-backports

	wget http://ftp.br.debian.org/debian/pool/main/m/mysql-5.5/libmysqlclient18_5.5.60-0+deb8u1_amd64.deb
	dpkg -i libmysqlclient18_5.5.60-0+deb8u1_amd64.deb

	sudo apt-get install -yq unixodbc libpq5
	curl -OL http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb
	dpkg -i sphinxsearch_2.2.11-release-1~jessie_amd64.deb
	rm -f sphinxsearch_2.2.11-release-1~jessie_amd64.deb
	rm -f libmysqlclient18_5.5.60-0+deb8u1_amd64.deb
elif [ "$DIST" = "debian" ] && [ "$DISTRIB_CODENAME" = "wheezy" ]; then
	sudo apt-get install -yq unixodbc libpq5
	curl -OL http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~wheezy_amd64.deb
	dpkg -i sphinxsearch_2.2.11-release-1~wheezy_amd64.deb
	rm -f sphinxsearch_2.2.11-release-1~wheezy_amd64.deb
fi


if [ $? -eq 0 ]
then
  echo "Successfully install prerequisites packages"
else
  echo "Error install prerequisites packages"

  exit;
fi

# disable apparmor for mysql
if which apparmor_parser && [ ! -f /etc/apparmor.d/disable/usr.sbin.mysqld ]; then
	ln -sf /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/;
	apparmor_parser -R /etc/apparmor.d/usr.sbin.mysqld;
fi

#######################################
#  END
#######################################


#######################################
#  INSTALL ONLYOFFICE DOCUMENT SERVER
#######################################

ONLYOFFICE_DOCUMENT_SERVER_PORT=${ONLYOFFICE_DOCUMENT_SERVER_PORT:-8083};
ONLYOFFICE_DOCUMENT_SERVER_PWD=${ONLYOFFICE_DOCUMENT_SERVER_PWD:-onlyoffice};

if ! sudo -i -u postgres psql -lqt | cut -d \| -f 1 | grep -q onlyoffice; then
	sudo -i -u postgres psql -c "CREATE DATABASE onlyoffice;"
	sudo -i -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';"
	sudo -i -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"
fi

if [ "$OPENSOURCE" == "true" ]; then
	# setup default port
	echo onlyoffice-documentserver onlyoffice/ds-port select $ONLYOFFICE_DOCUMENT_SERVER_PORT | sudo debconf-set-selections
	echo onlyoffice-documentserver onlyoffice/db-pwd select $ONLYOFFICE_DOCUMENT_SERVER_PWD | sudo debconf-set-selections
	
        apt-get install -yq onlyoffice-documentserver
else
	ONLYOFFICE_DOCUMENT_SERVER_JWT_ENABLED=${ONLYOFFICE_DOCUMENT_SERVER_JWT_ENABLED:-true};
	ONLYOFFICE_DOCUMENT_SERVER_JWT_SECRET="$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)";
	ONLYOFFICE_DOCUMENT_SERVER_JWT_HEADER="AuthorizationJwt";

	# setup default port
	echo onlyoffice-documentserver-ie onlyoffice/ds-port select $ONLYOFFICE_DOCUMENT_SERVER_PORT | sudo debconf-set-selections
	echo onlyoffice-documentserver-ie onlyoffice/db-pwd select $ONLYOFFICE_DOCUMENT_SERVER_PWD | sudo debconf-set-selections
	echo onlyoffice-documentserver-ie onlyoffice/jwt-enabled select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_ENABLED} | sudo debconf-set-selections
	echo onlyoffice-documentserver-ie onlyoffice/jwt-secret select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_SECRET} | sudo debconf-set-selections
	echo onlyoffice-documentserver-ie onlyoffice/jwt-header select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_HEADER} | sudo debconf-set-selections
	
        apt-get install -yq onlyoffice-documentserver-ie
fi

#######################################
#  END
#######################################


#######################################
#  INSTALL ONLYOFFICE CONTROL PANEL
#######################################

if [ "$OPENSOURCE" != "true" ]; then
	ONLYOFFICE_CONTROL_PANEL_PORT=${ONLYOFFICE_CONTROL_PANEL_PORT:-8082};

	# setup default port
	echo onlyoffice-controlpanel onlyoffice-controlpanel/port select $ONLYOFFICE_CONTROL_PANEL_PORT | sudo debconf-set-selections

	apt-get install -yq onlyoffice-controlpanel
fi

#######################################
#  END
#######################################


#######################################
#  INSTALL ONLYOFFICE COMMUNITY SERVER
#######################################

echo "Start=No" >> /etc/init.d/sphinxsearch

if [ "$OPENSOURCE" != "true" ]; then

echo onlyoffice onlyoffice-communityserver/ds-jwt-enabled select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_ENABLED} | sudo debconf-set-selections
echo onlyoffice onlyoffice-communityserver/ds-jwt-secret select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_SECRET} | sudo debconf-set-selections
echo onlyoffice onlyoffice-communityserver/ds-jwt-secret-header select ${ONLYOFFICE_DOCUMENT_SERVER_JWT_HEADER} | sudo debconf-set-selections

fi

echo onlyoffice onlyoffice-communityserver/db-host select ${MYSQL_SERVER_HOST} | sudo debconf-set-selections
echo onlyoffice onlyoffice-communityserver/db-user select ${MYSQL_SERVER_USER} | sudo debconf-set-selections
echo onlyoffice onlyoffice-communityserver/db-pwd select ${MYSQL_SERVER_PASS} | sudo debconf-set-selections
echo onlyoffice onlyoffice-communityserver/db-name select ${MYSQL_SERVER_DB_NAME} | sudo debconf-set-selections

apt-get install -yq onlyoffice-communityserver

#######################################
#  END
#######################################


make_swap

echo ""
echo "Thank you for installing ONLYOFFICE."

if [ "$OPENSOURCE" != "true" ]; then
	echo "You can now configure your portal using the Control Panel"
fi

echo "In case you have any questions contact us via http://support.onlyoffice.com or visit our forum at http://dev.onlyoffice.org"
echo ""
