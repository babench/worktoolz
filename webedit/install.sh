#!/bin/bash

# (c) Copyright Ascensio System Limited 2010-2016
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
# You can contact Ascensio System SIA by email at sales@onlyoffice.com

DISK_REQUIREMENTS=0;
MEMORY_REQUIREMENTS=0;
CORE_REQUIREMENTS=0;

COMMUNITY_CONTAINER_NAME="onlyoffice-community-server";
DOCUMENT_CONTAINER_NAME="onlyoffice-document-server";
MAIL_CONTAINER_NAME="onlyoffice-mail-server";
CONTROLPANEL_CONTAINER_NAME="onlyoffice-control-panel";
MYSQL_CONTAINER_NAME="onlyoffice-mysql-server";

COMMUNITY_IMAGE_NAME="onlyoffice4enterprise/communityserver-ee";
DOCUMENT_IMAGE_NAME="onlyoffice4enterprise/documentserver-ee";
MAIL_IMAGE_NAME="onlyoffice/mailserver";
CONTROLPANEL_IMAGE_NAME="onlyoffice4enterprise/controlpanel-ee";
MYSQL_IMAGE_NAME="mysql";

COMMUNITY_VERSION="";
DOCUMENT_VERSION="";
MAIL_VERSION="";
CONTROLPANEL_VERSION="";
MYSQL_VERSION="5.5";

DOCUMENT_SERVER_HOST="";

MAIL_SERVER_API_HOST="";
MAIL_SERVER_DB_HOST="";

MAIL_DOMAIN_NAME="";

DIST="";
REV="";
KERNEL="";

UPDATE="false";

USERNAME="";
PASSWORD="";

INSTALL_COMMUNITY_SERVER="true";
INSTALL_DOCUMENT_SERVER="true";
INSTALL_MAIL_SERVER="true";
INSTALL_CONTROLPANEL="true";

PULL_COMMUNITY_SERVER="false";
PULL_DOCUMENT_SERVER="false";
PULL_MAIL_SERVER="false";
PULL_CONTROLPANEL="false";

USE_AS_EXTERNAL_SERVER="false";

PARTNER_DATA_FILE="";

OPENSOURCE="false";
EDUCATION="false";

MAKESWAP="false";

RESTART_COMMUNITY_SERVER="false";
MOVE_COMMUNITY_SERVER_DATABASE="false";

MYSQL_PORT="3306";
MYSQL_DATABASE="onlyoffice";
MYSQL_MAIL_DATABASE="onlyoffice_mailserver";
MYSQL_MAIL_ROOT_PASSWORD="Isadmin123";
MYSQL_MAIL_USER="mail_admin";
MYSQL_ROOT_USER="root";
MYSQL_ROOT_PASSWORD="my-secret-pw";
MYSQL_USER="onlyoffice_user";
MYSQL_PASSWORD="onlyoffice_pass";
MYSQL_HOST="";

HELP_TARGET="install.sh";

JWT_SECRET="";
CORE_MACHINEKEY="";

SKIP_VERSION_CHECK="false";
SKIP_DOMAIN_CHECK="false";

while [ "$1" != "" ]; do
	case $1 in

		-cc | --communitycontainer )
			if [ "$2" != "" ]; then
				COMMUNITY_CONTAINER_NAME=$2
				shift
			fi
		;;

		-dc | --documentcontainer )
			if [ "$2" != "" ]; then
				DOCUMENT_CONTAINER_NAME=$2
				shift
			fi
		;;

		-mc | --mailcontainer )
			if [ "$2" != "" ]; then
				MAIL_CONTAINER_NAME=$2
				shift
			fi
		;;

		-cpc | --controlpanelcontainer )
			if [ "$2" != "" ]; then
				CONTROLPANEL_CONTAINER_NAME=$2
				shift
			fi
		;;

		-ci | --communityimage )
			if [ "$2" != "" ]; then
				COMMUNITY_IMAGE_NAME=$2
				shift
			fi
		;;

		-di | --documentimage )
			if [ "$2" != "" ]; then
				DOCUMENT_IMAGE_NAME=$2
				shift
			fi
		;;

		-mi | --mailimage )
			if [ "$2" != "" ]; then
				MAIL_IMAGE_NAME=$2
				shift
			fi
		;;

		-cpi | --controlpanelimage )
			if [ "$2" != "" ]; then
				CONTROLPANEL_IMAGE_NAME=$2
				shift
			fi
		;;

		-dip | --documentserverip  )
			if [ "$2" != "" ]; then
				DOCUMENT_SERVER_HOST=$2
				shift
			fi
		;;

		-mip | --mailserverip  )
			if [ "$2" != "" ]; then
				MAIL_SERVER_API_HOST=$2
				shift
			fi
		;;

		-mdbip | --mailserverdbip  )
			if [ "$2" != "" ]; then
				MAIL_SERVER_DB_HOST=$2
				shift
			fi
		;;

		-cv | --communityversion )
			if [ "$2" != "" ]; then
				COMMUNITY_VERSION=$2
				shift
			fi
		;;

		-dv | --documentversion )
			if [ "$2" != "" ]; then
				DOCUMENT_VERSION=$2
				shift
			fi
		;;

		-mv | --mailversion )
			if [ "$2" != "" ]; then
				MAIL_VERSION=$2
				shift
			fi
		;;

		-cpv | --controlpanelversion )
			if [ "$2" != "" ]; then
				CONTROLPANEL_VERSION=$2
				shift
			fi
		;;

		-md | --maildomain )
			if [ "$2" != "" ]; then
				MAIL_DOMAIN_NAME=$2
				shift
			fi
		;;

		-u | --update )
			if [ "$2" != "" ]; then
				UPDATE=$2
				shift
			fi
		;;

		-un | --username )
			if [ "$2" != "" ]; then
				USERNAME=$2
				shift
			fi
		;;

		-p | --password )
			if [ "$2" != "" ]; then
				PASSWORD=$2
				shift
			fi
		;;

		-ics | --installcommunityserver )
			if [ "$2" != "" ]; then
				INSTALL_COMMUNITY_SERVER=$2
				shift
			fi
		;;

		-ids | --installdocumentserver )
			if [ "$2" != "" ]; then
				INSTALL_DOCUMENT_SERVER=$2
				shift
			fi
		;;

		-ims | --installmailserver )
			if [ "$2" != "" ]; then
				INSTALL_MAIL_SERVER=$2
				shift
			fi
		;;

		-icp | --installcontrolpanel )
			if [ "$2" != "" ]; then
				INSTALL_CONTROLPANEL=$2
				shift
			fi
		;;

		-pcs | --pullcommunityserver )
			if [ "$2" != "" ]; then
				PULL_COMMUNITY_SERVER=$2
				shift
			fi
		;;

		-pds | --pulldocumentserver )
			if [ "$2" != "" ]; then
				PULL_DOCUMENT_SERVER=$2
				shift
			fi
		;;

		-pms | --pullmailserver )
			if [ "$2" != "" ]; then
				PULL_MAIL_SERVER=$2
				shift
			fi
		;;

		-pcp | --pullcontrolpanel )
			if [ "$2" != "" ]; then
				PULL_CONTROLPANEL=$2
				shift
			fi
		;;

		-es | --useasexternalserver )
			if [ "$2" != "" ]; then
				USE_AS_EXTERNAL_SERVER=$2
				shift
			fi
		;;

		-pdf | --partnerdatafile )
			if [ "$2" != "" ]; then
				PARTNER_DATA_FILE=$2
				shift
			fi
		;;

		-os | --opensource )
			if [ "$2" != "" ]; then
				OPENSOURCE=$2
				shift
			fi
		;;

		-ed | --education )
			if [ "$2" != "" ]; then
				EDUCATION=$2
				shift
			fi
		;;

		-ms | --makeswap )
			if [ "$2" != "" ]; then
				MAKESWAP=$2
				shift
			fi
		;;

		-ht | --helptarget )
			if [ "$2" != "" ]; then
				HELP_TARGET=$2
				shift
			fi
		;;

		-mysqlprt | --mysqlport )
			if [ "$2" != "" ]; then
				MYSQL_PORT=$2
				shift
			fi
		;;

		-mysqld | --mysqldatabase )
			if [ "$2" != "" ]; then
				MYSQL_DATABASE=$2
				shift
			fi
		;;

		-mysqlmd | --mysqlmaildatabase )
			if [ "$2" != "" ]; then
				MYSQL_MAIL_DATABASE=$2
				shift
			fi
		;;

		-mysqlmp | --mysqlmailpassword )
			if [ "$2" != "" ]; then
				MYSQL_MAIL_ROOT_PASSWORD=$2
				shift
			fi
		;;

		-mysqlmu | --mysqlmailuser )
			if [ "$2" != "" ]; then
				MYSQL_MAIL_USER=$2
				shift
			fi
		;;

		-mysqlru | --mysqlrootuser )
			if [ "$2" != "" ]; then
				MYSQL_ROOT_USER=$2
				shift
			fi
		;;

		-mysqlrp | --mysqlrootpassword )
			if [ "$2" != "" ]; then
				MYSQL_ROOT_PASSWORD=$2
				shift
			fi
		;;

		-mysqlu | --mysqluser )
			if [ "$2" != "" ]; then
				MYSQL_USER=$2
				shift
			fi
		;;

		-mysqlp | --mysqlpassword )
			if [ "$2" != "" ]; then
				MYSQL_PASSWORD=$2
				shift
			fi
		;;

		-mysqlh | --mysqlhost )
			if [ "$2" != "" ]; then
				MYSQL_HOST=$2
				shift
			fi
		;;

		-skipvc | --skipversioncheck )
			if [ "$2" != "" ]; then
				SKIP_VERSION_CHECK=$2
				shift
			fi
		;;

		-skipdc | --skipdomaincheck )
			if [ "$2" != "" ]; then
				SKIP_DOMAIN_CHECK=$2
				shift
			fi
		;;

		-? | -h | --help )
			echo "  Usage $HELP_TARGET [PARAMETER] [[PARAMETER], ...]"
			echo "    Parameters:"
			echo "      -cc, --communitycontainer         community container name"
			echo "      -dc, --documentcontainer          document container name"
			echo "      -mc, --mailcontainer              mail container name"
			echo "      -cpc, --controlpanelcontainer     control panel container name"
			echo "      -ci, --communityimage             community image name or .tar.gz file path"
			echo "      -di, --documentimage              document image name or .tar.gz file path"
			echo "      -mi, --mailimage                  mail image name or .tar.gz file path"
			echo "      -cpi, --controlpanelimage         control panel image name or .tar.gz file path"
			echo "      -cv, --communityversion           community version"
			echo "      -dv, --documentversion            document version"
			echo "      -dip, --documentserverip          document server ip"
			echo "      -mv, --mailversion                mail version"
			echo "      -mip, --mailserverip              mail server ip"
			echo "      -mdbip, --mailserverdbip          mail server db ip"
			echo "      -cpv, --controlpanelversion       control panel version"
			echo "      -md, --maildomain                 mail domail name"
			echo "      -u, --update                      use to update existing components (true|false)"
			echo "      -un, --username                   dockerhub username"
			echo "      -p, --password                    dockerhub password"
			echo "      -ics, --installcommunityserver    install or update community server (true|false|pull)"
			echo "      -ids, --installdocumentserver     install or update document server (true|false|pull)"
			echo "      -ims, --installmailserver         install or update mail server (true|false|pull)"
			echo "      -icp, --installcontrolpanel       install or update control panel (true|false|pull)"
			echo "      -pcs, --pullcommunityserver       pull community server (true|false). parameter is obsolete (use -ics pull)"
			echo "      -pds, --pulldocumentserver        pull document server (true|false). parameter is obsolete (use -ids pull)"
			echo "      -pms, --pullmailserver            pull mail server (true|false). parameter is obsolete (use -ims pull)"
			echo "      -pcp, --pullcontrolpanel          pull control panel (true|false). parameter is obsolete (use -icp pull)"
			echo "      -es, --useasexternalserver        use as external server (true|false)"
			echo "      -pdf, --partnerdatafile           partner data file"
			echo "      -svc, --servicecount              number of services"
			echo "      -os, --opensource                 install opensource version (true|false)"
			echo "      -ed, --education                  install education version (true|false)"
			echo "      -ms, --makeswap                   make swap file (true|false)"
			echo "      -mysqlh, --mysqlhost              mysql server host"
			echo "      -mysqlprt, --mysqlport            mysql server port"
			echo "      -mysqlru, --mysqlrootuser         mysql server root user"
			echo "      -mysqlrp, --mysqlrootpassword     mysql server root password"
			echo "      -mysqld, --mysqldatabase          community server database name"
			echo "      -mysqlu, --mysqluser              community server database user"
			echo "      -mysqlp, --mysqlpassword          community server database password"
			echo "      -mysqlmd, --mysqlmaildatabase     mail server database name"
			echo "      -mysqlmu, --mysqlmailuser         mail server database user"
			echo "      -mysqlmp, --mysqlmailpassword     mail server database password"
			echo "      -skipvc, --skipversioncheck       skip version check while update (true|false)"
			echo "      -skipdc, --skipdomaincheck        skip domain check when installing mail server (true|false)"
			echo "      -?, -h, --help                    this help"
			echo
			echo "  Examples"
			echo "    Install all the solution components:"
			echo "      bash $HELP_TARGET -md yourdomain.com"
			echo
			echo "    Install all the components without Mail Server:"
			echo "      bash $HELP_TARGET -ims false"
			echo
			echo "    Install Document Server only. Skip the installation of Mail Server, Community Server and Control Panel:"
			echo "      bash $HELP_TARGET -ics false -ids true -icp false -ims false -es true"
			echo
			echo "    Install Mail Server only. Skip the installation of Document Server, Community Server and Control Panel:"
			echo "      bash $HELP_TARGET -ics false -ids false -icp false -ims true -md yourdomain.com -es true"
			echo
			echo "    Install Community Server with Control Panel and connect it with Document Server installed on a different machine which has the 192.168.3.202 IP address:"
			echo "      bash $HELP_TARGET -ics true -icp true -ids false -ims false -dip 192.168.3.202"
			echo
			echo "    Update all installed components. Stop the containers that need to be updated, remove them and run the latest versions of the corresponding components. The portal data should be picked up automatically:"
			echo "      bash $HELP_TARGET -u true"
			echo
			echo "    Update Document Server only to version 4.4.2.20 and skip the update for all other components:"
			echo "      bash $HELP_TARGET -u true -dv 4.4.2.20 -ics false -icp false -ims false"
			echo
			echo "    Update Community Server only to version 9.1.0.393 and skip the update for all other components:"
			echo "      bash $HELP_TARGET -u true -cv 9.1.0.393 -ids false -icp false -ims false"
			echo
			echo "    Update Mail Server only to version 1.6.27 and skip the update for all other components:"
			echo "      bash $HELP_TARGET -u true -mv 1.6.27 -ics false -ids false -icp false"
			echo
			echo "    Update Control Panel only to version 2.1.0.93 and skip the update for all other components:"
			echo "      bash $HELP_TARGET -u true -cpv 2.1.0.93 -ics false -ids false -ims false"
			echo
			exit 0
		;;

		* )
			echo "Unknown parameter $1" 1>&2
			exit 1
		;;
	esac
	shift
done



root_checking () {
	if [ ! $( id -u ) -eq 0 ]; then
		echo "To perform this action you must be logged in with root rights"
		exit 1;
	fi
}

command_exists () {
    type "$1" &> /dev/null;
}

file_exists () {
	if [ -z "$1" ]; then
		echo "file path is empty"
		exit 1;
	fi

	if [ -f "$1" ]; then
		return 0; #true
	else
		return 1; #false
	fi
}

install_sudo () {
	if command_exists apt-get; then
		apt-get install sudo
	elif command_exists yum; then
		yum install sudo
	fi

	if ! command_exists sudo; then
		echo "command sudo not found"
		exit 1;
	fi
}

install_curl () {
	if command_exists apt-get; then
		sudo apt-get -y update
		sudo apt-get -y -q install curl
	elif command_exists yum; then
		sudo yum -y install curl
	fi

	if ! command_exists curl; then
		echo "command curl not found"
		exit 1;
	fi
}

to_lowercase () {
	echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

get_os_info () {
	OS=`to_lowercase \`uname\``

	if [ "${OS}" == "windowsnt" ]; then
		echo "Not supported OS";
		exit 1;
	elif [ "${OS}" == "darwin" ]; then
		echo "Not supported OS";
		exit 1;
	else
		OS=`uname`

		if [ "${OS}" == "SunOS" ] ; then
			echo "Not supported OS";
			exit 1;
		elif [ "${OS}" == "AIX" ] ; then
			echo "Not supported OS";
			exit 1;
		elif [ "${OS}" == "Linux" ] ; then
			MACH=`uname -m`

			if [ "${MACH}" != "x86_64" ]; then
				echo "Currently only supports 64bit OS's";
				exit 1;
			fi

			KERNEL=`uname -r`

			if [ -f /etc/redhat-release ] ; then
				DIST=`cat /etc/redhat-release |sed s/\ release.*//`
				REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/SuSE-release ] ; then
				REV=`cat /etc/os-release  | grep '^VERSION_ID' | awk -F=  '{ print $2 }' |  sed -e 's/^"//'  -e 's/"$//'`
				DIST='SuSe'
			elif [ -f /etc/debian_version ] ; then
				REV=`cat /etc/debian_version`
				DIST='Debian'
				if [ -f /etc/lsb-release ] ; then
					DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
					REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
				elif [[ -f /etc/lsb_release ]]; then
					DIST=`lsb_release -a 2>&1 | grep 'Distributor ID:' | awk -F ":" '{print $2 }'`
					REV=`lsb_release -a 2>&1 | grep 'Release:' | awk -F ":" '{print $2 }'`
				fi
			elif [ -f /etc/os-release ] ; then
				DIST=`cat /etc/os-release | grep -sw 'ID' | awk -F=  '{ print $2 }' | sed -e 's/^"//' -e 's/"$//'`
				REV=`cat /etc/os-release | grep -sw 'VERSION_ID' | awk -F=  '{ print $2 }' | sed -e 's/^"//' -e 's/"$//'`
			fi
		fi
	fi
}

check_os_info () {
	if [[ -z ${KERNEL} || -z ${DIST} || -z ${REV} ]]; then
		echo "$KERNEL, $DIST, $REV";
		echo "Not supported OS";
		exit 1;
	fi
}

check_kernel () {
	MIN_NUM_ARR=(3 10 0);
	CUR_NUM_ARR=();

	CUR_STR_ARR=$(echo $KERNEL | grep -Po "[0-9]+\.[0-9]+\.[0-9]+" | tr "." " ");
	for CUR_STR_ITEM in $CUR_STR_ARR
	do
		CUR_NUM_ARR=(${CUR_NUM_ARR[@]} $CUR_STR_ITEM)
	done

	INDEX=0;

	while [[ $INDEX -lt 3 ]]; do
		if [ ${CUR_NUM_ARR[INDEX]} -lt ${MIN_NUM_ARR[INDEX]} ]; then
			echo "Not supported OS Kernel"
			exit 1;
		elif [ ${CUR_NUM_ARR[INDEX]} -gt ${MIN_NUM_ARR[INDEX]} ]; then
			INDEX=3
		fi
		(( INDEX++ ))
	done
}

check_hardware () {
	AVAILABLE_DISK_SPACE=$(sudo df -m /  | tail -1 | awk '{ print $4 }');

	if [ ${AVAILABLE_DISK_SPACE} -lt ${DISK_REQUIREMENTS} ]; then
		echo "Minimal requirements are not met: need at least $DISK_REQUIREMENTS MB of free HDD space"
		exit 1;
	fi

	TOTAL_MEMORY=$(free -m | grep -oP '\d+' | head -n 1);

	if [ ${TOTAL_MEMORY} -lt ${MEMORY_REQUIREMENTS} ]; then
		echo "Minimal requirements are not met: need at least $MEMORY_REQUIREMENTS MB of RAM"
		exit 1;
	fi

	CPU_CORES_NUMBER=$(cat /proc/cpuinfo | grep processor | wc -l);

	if [ ${CPU_CORES_NUMBER} -lt ${CORE_REQUIREMENTS} ]; then
		echo "The system does not meet the minimal hardware requirements. CPU with at least $CORE_REQUIREMENTS cores is required"
		exit 1;
	fi
}

make_swap () {
	EXIST=$(sudo swapon -s | awk '{ print $1 }' | { grep -x '/onlyoffice_swapfile' || true; });

	if [[ -z $EXIST ]]; then
		sudo fallocate -l 6G /onlyoffice_swapfile
		sudo chmod 600 /onlyoffice_swapfile
		sudo mkswap /onlyoffice_swapfile
		sudo swapon /onlyoffice_swapfile
		sudo echo "/onlyoffice_swapfile none swap sw 0 0" >> /etc/fstab
	fi
}

check_ports () {
	ARRAY_PORTS=();

	if [ "$INSTALL_COMMUNITY_SERVER" == "true" ]; then
		ARRAY_PORTS=(${ARRAY_PORTS[@]} "80" "443" "5222");
	elif [ "$INSTALL_DOCUMENT_SERVER" == "true" ]; then
		if [ "${USE_AS_EXTERNAL_SERVER}" == "true" ]; then
			ARRAY_PORTS=(${ARRAY_PORTS[@]} "80" "443");
		fi
	fi

	if [ "$INSTALL_MAIL_SERVER" == "true" ]; then
		ARRAY_PORTS=(${ARRAY_PORTS[@]} "25" "143" "587");

		if [ "${USE_AS_EXTERNAL_SERVER}" == "true" ]; then
			ARRAY_PORTS=(${ARRAY_PORTS[@]} "8081");

			if [[ -z ${MYSQL_HOST} ]]; then
				ARRAY_PORTS=(${ARRAY_PORTS[@]} "3306");
			fi
		fi
	fi

	for PORT in "${ARRAY_PORTS[@]}"
	do
		REGEXP=":$PORT$"
		CHECK_RESULT=$(sudo netstat -lnp | awk '{print $4}' | { grep $REGEXP || true; })

		if [[ $CHECK_RESULT != "" ]]; then
			echo "The following ports must be open: $PORT"
			exit 1;
		fi
	done
}

check_docker_version () {
	CUR_FULL_VERSION=$(sudo docker -v | cut -d ' ' -f3 | cut -d ',' -f1);
	CUR_VERSION=$(echo $CUR_FULL_VERSION | cut -d '-' -f1);
	CUR_EDITION=$(echo $CUR_FULL_VERSION | cut -d '-' -f2);

	if [ "${CUR_EDITION}" == "ce" ] || [ "${CUR_EDITION}" == "ee" ]; then
		return 0;
	fi

	if [ "${CUR_VERSION}" != "${CUR_EDITION}" ]; then
		echo "Unspecific docker version"
		exit 1;
	fi

	MIN_NUM_ARR=(1 10 0);
	CUR_NUM_ARR=();

	CUR_STR_ARR=$(echo $CUR_VERSION | grep -Po "[0-9]+\.[0-9]+\.[0-9]+" | tr "." " ");

	for CUR_STR_ITEM in $CUR_STR_ARR
	do
		CUR_NUM_ARR=(${CUR_NUM_ARR[@]} $CUR_STR_ITEM)
	done

	INDEX=0;

	while [[ $INDEX -lt 3 ]]; do
		if [ ${CUR_NUM_ARR[INDEX]} -lt ${MIN_NUM_ARR[INDEX]} ]; then
			echo "The outdated Docker version has been found. Please update to the latest version."
			exit 1;
		elif [ ${CUR_NUM_ARR[INDEX]} -gt ${MIN_NUM_ARR[INDEX]} ]; then
			return 0;
		fi
		(( INDEX++ ))
	done
}

install_docker () {

	if [ "${DIST}" == "Ubuntu" ]; then

		sudo apt-get -y update
		sudo apt-get -y -q install curl

		sudo apt-get -y -q install \
			apt-transport-https \
			ca-certificates \
			curl \
			software-properties-common

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -	

		sudo add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) \
			stable"

		sudo apt-get -y update
		sudo apt-get -y -q install docker-ce

	elif [ "${DIST}" == "Debian" ]; then

		sudo apt-get -y update
		sudo apt-get -y -q install curl

		IS_JESSIE_OR_STRETCH=$(lsb_release -c | { grep -i "jessie\|stretch" || true; });

		if [[ -n ${IS_JESSIE_OR_STRETCH} ]]; then
			sudo apt-get -y -q install \
				apt-transport-https \
				ca-certificates \
				curl \
				gnupg2 \
				software-properties-common
		else
			sudo apt-get -y -q install \
				apt-transport-https \
				ca-certificates \
				curl \
				python-software-properties
		fi

		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

		sudo add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/debian \
			$(lsb_release -cs) \
			stable"

		sudo apt-get -y update
		sudo apt-get -y -q install docker-ce

	elif [[ "${DIST}" == CentOS* ]]; then

		sudo yum install -y yum-utils

		sudo yum-config-manager \
			--add-repo \
			https://download.docker.com/linux/centos/docker-ce.repo

		sudo yum makecache fast

		sudo yum install -y docker-ce

		sudo systemctl start docker

	elif [ "${DIST}" == "Red Hat Enterprise Linux Server" ]; then

		echo ""
		echo "Your operating system does not allow Docker CE installation."
		echo "You can install Docker EE using the manual here - https://docs.docker.com/engine/installation/linux/rhel/"
		echo ""
		exit 1;

	elif [ "${DIST}" == "SuSe" ]; then

		echo ""
		echo "Your operating system does not allow Docker CE installation."
		echo "You can install Docker EE using the manual here - https://docs.docker.com/engine/installation/linux/suse/"
		echo ""
		exit 1;

	elif [ "${DIST}" == "Fedora" ]; then

		sudo dnf -y update

		sudo dnf -y install dnf-plugins-core

		sudo dnf config-manager \
			--add-repo \
			https://download.docker.com/linux/fedora/docker-ce.repo

		sudo dnf makecache fast

		sudo dnf install -y docker-ce

	sudo systemctl start docker

	else

		echo ""
		echo "Docker could not be installed automatically."
		echo "Please use this official instruction https://docs.docker.com/engine/installation/linux/other/ for its manual installation."
		echo ""
		exit 1;

	fi

	if ! command_exists docker ; then
		echo "error while installing docker"
		exit 1;
	fi
}

docker_login () {
	if [[ -n ${USERNAME} && -n ${PASSWORD}  ]]; then
		sudo docker login -u ${USERNAME} -p ${PASSWORD}
	fi
}

make_directories () {
	sudo mkdir -p "/app/onlyoffice/setup";

	sudo mkdir -p "/app/onlyoffice/DocumentServer/data";
	sudo mkdir -p "/app/onlyoffice/DocumentServer/logs";
	sudo mkdir -p "/app/onlyoffice/DocumentServer/fonts";
	sudo mkdir -p "/app/onlyoffice/DocumentServer/forgotten";

	sudo mkdir -p "/app/onlyoffice/MailServer/data/certs";
	sudo mkdir -p "/app/onlyoffice/MailServer/logs";

	sudo mkdir -p "/app/onlyoffice/CommunityServer/data";
	sudo mkdir -p "/app/onlyoffice/CommunityServer/data/certs";
	sudo mkdir -p "/app/onlyoffice/CommunityServer/data/certs/tmp";
	sudo mkdir -p "/app/onlyoffice/CommunityServer/logs";

	sudo mkdir -p "/app/onlyoffice/ControlPanel/data";
	sudo mkdir -p "/app/onlyoffice/ControlPanel/logs";

	sudo mkdir -p "/app/onlyoffice/mysql/conf.d";
	sudo mkdir -p "/app/onlyoffice/mysql/data";
	sudo mkdir -p "/app/onlyoffice/mysql/initdb";
	sudo mkdir -p "/app/onlyoffice/mysql/logs";
}

get_available_version () {
	if [[ -z "$1" ]]; then
		echo "image name is empty";
		exit 1;
	fi

	if ! command_exists curl ; then
		install_curl;
	fi

	CREDENTIALS="";
	AUTH_HEADER="";

	if [[ -n ${USERNAME} && -n ${PASSWORD} ]]; then
		CREDENTIALS="{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\"}";
	fi

	if [[ -n ${CREDENTIALS} ]]; then
		LOGIN_RESP=$(curl -s -H "Content-Type: application/json" -X POST -d "$CREDENTIALS" https://hub.docker.com/v2/users/login/)
		TOKEN=$(echo $LOGIN_RESP | sed 's/"token"//g' | tr -d '{}:" ')
		AUTH_HEADER="Authorization: JWT $TOKEN"
	fi

	TAGS_RESP=$(curl -s -H "$AUTH_HEADER" -X GET https://hub.docker.com/v2/repositories/$1/tags/);
	TAGS_RESP=$(echo $TAGS_RESP | tr -d '[]{},:"')

	VERSION_REGEX_1="[0-9]+\.[0-9]+\.[0-9]+"
	VERSION_REGEX_2="[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
	TAG_LIST=""

	for item in $TAGS_RESP
	do
		if [[ $item =~ $VERSION_REGEX_1 ]] || [[ $item =~ $VERSION_REGEX_2 ]]; then
			TAG_LIST="$item,$TAG_LIST"
		fi
	done

	LATEST_TAG=$(echo $TAG_LIST | tr ',' '\n' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | awk '/./{line=$0} END{print line}');

	echo "$LATEST_TAG"
}

get_current_image_name () {
	if [[ -z "$1" ]]; then
		echo "container name is empty";
		exit 1;
	fi

	CONTAINER_NAME=$(sudo docker inspect --format='{{.Config.Image}}' $1)

	CONTAINER_VERSION=($(echo $CONTAINER_NAME | tr ":" "\n"))

	echo ${CONTAINER_VERSION[0]}
}

get_current_image_version () {
	if [[ -z "$1" ]]; then
		echo "container name is empty";
		exit 1;
	fi

	CONTAINER_NAME=$(sudo docker inspect --format='{{.Config.Image}}' $1)

	CONTAINER_VERSION=($(echo $CONTAINER_NAME | tr ":" "\n"))

	if [ "$CONTAINER_VERSION" != "latest" ]; then
		echo ${CONTAINER_VERSION[1]}
	else
		CONTAINER_NAME=${CONTAINER_VERSION[0]}
		CONTAINER_NAME=${CN//onlyoffice}
		CONTAINER_NAME=${CN//-}

		echo $(sudo docker inspect -f '{{index .Config.Labels "onlyoffice.$CONTAINER_NAME.version"}}' $1)
	fi
}

check_bindings () {
	if [[ -z "$1" ]]; then
		echo "container id is empty";
		exit 1;
	fi

	binds=$(sudo docker inspect --format='{{range $p,$conf:=.HostConfig.Binds}}{{$conf}};{{end}}' $1)
	volumes=$(sudo docker inspect --format='{{range $p,$conf:=.Config.Volumes}}{{$p}};{{end}}' $1)
	arrBinds=$(echo $binds | tr ";" "\n")
	arrVolumes=$(echo $volumes | tr ";" "\n")
	bindsCorrect=1

	if [[ -n "$2" ]]; then
		exceptions=$(echo $2 | tr "," "\n")
		for ex in ${exceptions[@]}
		do
			arrVolumes=(${arrVolumes[@]/$ex})
		done
	fi

	for volume in $arrVolumes
	do
		bindExist=0
		for bind in $arrBinds
		do
			bind=($(echo $bind | tr ":" " "))
			if [ "${bind[1]}" == "${volume}" ]; then
				bindExist=1
			fi
		done
		if [ "$bindExist" == "0" ]; then
			bindsCorrect=0
			echo "${volume} not binded"
		fi
	done

	if [ "$bindsCorrect" == "0" ]; then
		exit 1;
	fi
}

change_mysql_credentials () {
	while ! docker exec -it ${MYSQL_CONTAINER_NAME} mysqladmin ping --silent; do
		echo "wait for $MYSQL_CONTAINER_NAME"
		sleep 5
	done

	docker exec -it ${MYSQL_CONTAINER_NAME} mysqladmin password "$MYSQL_ROOT_PASSWORD"

	docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} < /app/onlyoffice/mysql/initdb/setup.sql
}

install_mysql_server () {
	MYSQL_SERVER_ID=$(get_container_id "$MYSQL_CONTAINER_NAME");

	RUN_MYSQL_SERVER="true";

	if [[ -n ${MYSQL_SERVER_ID} ]]; then
		RUN_MYSQL_SERVER="false";
		echo "ONLYOFFICE MYSQL SERVER is already installed."
		sudo docker start ${MYSQL_SERVER_ID};
	fi

	if [ "$RUN_MYSQL_SERVER" == "true" ]; then

		if ! file_exists /app/onlyoffice/mysql/conf.d/onlyoffice.cnf; then
			echo "[mysqld]
sql_mode = 'NO_ENGINE_SUBSTITUTION'
max_connections = 1000
max_allowed_packet = 1048576000
group_concat_max_len = 2048
log-error = /var/log/mysql/error.log" > /app/onlyoffice/mysql/conf.d/onlyoffice.cnf
			sudo chmod 0644 /app/onlyoffice/mysql/conf.d/onlyoffice.cnf
		fi

		if ! file_exists /app/onlyoffice/mysql/initdb/setup.sql; then
			echo "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE USER '$MYSQL_MAIL_USER'@'localhost' IDENTIFIED BY '$MYSQL_MAIL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_MAIL_USER'@'%' IDENTIFIED BY '$MYSQL_MAIL_ROOT_PASSWORD';
FLUSH PRIVILEGES;" > /app/onlyoffice/mysql/initdb/setup.sql
		fi

		if [ "$UPDATE" == "true" ]; then
			echo "copying $MYSQL_DATABASE database mysql files"
			cp -rf /app/onlyoffice/CommunityServer/mysql/. /app/onlyoffice/mysql/data
			MOVE_COMMUNITY_SERVER_DATABASE="true";
		fi

		args=();
		args+=(--name "$MYSQL_CONTAINER_NAME");

		if [ "${USE_AS_EXTERNAL_SERVER}" == "true" ]; then
			args+=(-p 3306:3306);
		fi

		args+=(-v "/app/onlyoffice/mysql/conf.d:/etc/mysql/conf.d");
		args+=(-v "/app/onlyoffice/mysql/data:/var/lib/mysql");
		args+=(-v "/app/onlyoffice/mysql/initdb:/docker-entrypoint-initdb.d");
		args+=(-e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD");
		args+=(-e "MYSQL_DATABASE=$MYSQL_DATABASE");
		args+=("$MYSQL_IMAGE_NAME:$MYSQL_VERSION");

		sudo docker run --net onlyoffice -i -t -d --restart=always "${args[@]}";

		MYSQL_SERVER_ID=$(get_container_id "$MYSQL_CONTAINER_NAME");

		if [[ -z ${MYSQL_SERVER_ID} ]]; then
			echo "ONLYOFFICE MYSQL SERVER not installed."
			exit 1;
		fi

		if [ "$UPDATE" == "true" ]; then
			change_mysql_credentials
		fi
	fi
}

install_document_server () {
	DOCUMENT_SERVER_ID=$(get_container_id "$DOCUMENT_CONTAINER_NAME");

	RUN_DOCUMENT_SERVER="true";

	if [[ -n ${DOCUMENT_SERVER_ID} ]]; then
		if [ "$UPDATE" == "true" ]; then
			CURRENT_IMAGE_NAME=$(get_current_image_name "$DOCUMENT_CONTAINER_NAME");
			CURRENT_IMAGE_VERSION=$(get_current_image_version "$DOCUMENT_CONTAINER_NAME");

			if [ "$CURRENT_IMAGE_NAME" != "$DOCUMENT_IMAGE_NAME" ] || ([ "$CURRENT_IMAGE_VERSION" != "$DOCUMENT_VERSION" ] || [ "$SKIP_VERSION_CHECK" == "true" ]); then
				check_bindings $DOCUMENT_SERVER_ID "/etc/onlyoffice,/var/lib/onlyoffice,/var/lib/postgresql,/usr/share/fonts/truetype/custom";
				sudo docker exec ${DOCUMENT_CONTAINER_NAME} bash /usr/bin/documentserver-prepare4shutdown.sh
				remove_container ${DOCUMENT_CONTAINER_NAME}
			else
				RUN_DOCUMENT_SERVER="false";
				echo "The latest version of ONLYOFFICE DOCUMENT SERVER is already installed."
				sudo docker start ${DOCUMENT_SERVER_ID};
			fi
		else
			RUN_DOCUMENT_SERVER="false";
			echo "ONLYOFFICE DOCUMENT SERVER is already installed."
			sudo docker start ${DOCUMENT_SERVER_ID};
		fi
	else
		RESTART_COMMUNITY_SERVER="true";
	fi

	if [ "$RUN_DOCUMENT_SERVER" == "true" ]; then
		args=();
		args+=(--name "$DOCUMENT_CONTAINER_NAME");

		if [ "${USE_AS_EXTERNAL_SERVER}" == "true" ]; then
			args+=(-p 80:80);
			args+=(-p 443:443);
		fi

		if [[ -n ${JWT_SECRET} ]]; then
			args+=(-e "JWT_ENABLED=true");
			args+=(-e "JWT_HEADER=AuthorizationJwt");
			args+=(-e "JWT_SECRET=$JWT_SECRET");
		fi

		args+=(-v "/app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data");
		args+=(-v "/app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice");
		args+=(-v "/app/onlyoffice/DocumentServer/fonts:/usr/share/fonts/truetype/custom");
		args+=(-v "/app/onlyoffice/DocumentServer/forgotten:/var/lib/onlyoffice/documentserver/App_Data/cache/files/forgotten");
		args+=("$DOCUMENT_IMAGE_NAME:$DOCUMENT_VERSION");

		sudo docker run --net onlyoffice -i -t -d --restart=always "${args[@]}";

		DOCUMENT_SERVER_ID=$(get_container_id "$DOCUMENT_CONTAINER_NAME");
		if [[ -z ${DOCUMENT_SERVER_ID} ]]; then
			echo "ONLYOFFICE DOCUMENT SERVER not installed."
			exit 1;
		else
			COMMUNITY_SERVER_ID=$(get_container_id "$COMMUNITY_CONTAINER_NAME");

			if [[ -n ${COMMUNITY_SERVER_ID} ]]; then
				sudo docker exec ${COMMUNITY_CONTAINER_NAME} chown -R onlyoffice:onlyoffice /var/www/onlyoffice/DocumentServerData
			fi
		fi
	fi
}

install_mail_server () {
	MAIL_SERVER_ID=$(get_container_id "$MAIL_CONTAINER_NAME");
	MYSQL_SERVER_ID=$(get_container_id "$MYSQL_CONTAINER_NAME");

	RUN_MAIL_SERVER="true";

	if [[ -n ${MAIL_SERVER_ID} ]]; then
		if [ "$UPDATE" == "true" ]; then
			CURRENT_IMAGE_NAME=$(get_current_image_name "$MAIL_CONTAINER_NAME");
			CURRENT_IMAGE_VERSION=$(get_current_image_version "$MAIL_CONTAINER_NAME");

			MOVE_DATABASE="false";
			if [[ -z ${MYSQL_HOST} ]] && [[ -n ${MYSQL_SERVER_ID} ]]; then
				EXIST_DATABASE=$(docker exec -i ${MYSQL_CONTAINER_NAME} ls /var/lib/mysql/ | { grep -sw ${MYSQL_MAIL_DATABASE} || true; });
				if [[ -z ${EXIST_DATABASE} ]]; then
					MOVE_DATABASE="true";
				fi
			fi

			if [ "$CURRENT_IMAGE_NAME" != "$MAIL_IMAGE_NAME" ] || ([ "$CURRENT_IMAGE_VERSION" != "$MAIL_VERSION" ] || [ "$SKIP_VERSION_CHECK" == "true" ]) || [ "$MOVE_DATABASE" == "true" ]; then
				check_bindings $MAIL_SERVER_ID "/var/lib/mysql";
				MAIL_DOMAIN_NAME=$(sudo docker exec $MAIL_SERVER_ID hostname -f);

				if [ "$MOVE_DATABASE" == "true" ]; then
					move_mail_server_database
				fi

				stop_mail_server_mysql
				remove_container ${MAIL_CONTAINER_NAME}
			else
				RUN_MAIL_SERVER="false";
				echo "The latest version of ONLYOFFICE MAIL SERVER is already installed."
				sudo docker start ${MAIL_SERVER_ID};
			fi
		else
			RUN_MAIL_SERVER="false";
			echo "ONLYOFFICE MAIL SERVER is already installed."
			sudo docker start ${MAIL_SERVER_ID};
		fi
	else
		RESTART_COMMUNITY_SERVER="true";
	fi

	if [ "$RUN_MAIL_SERVER" == "true" ]; then
		if [[ -n ${MAIL_DOMAIN_NAME} ]]; then
			args=();
			args+=(--name "$MAIL_CONTAINER_NAME");
			args+=(-p 25:25);
			args+=(-p 143:143);
			args+=(-p 587:587);

			MAIL_SERVER_ADDITIONAL_PORTS="";

			if [ "${USE_AS_EXTERNAL_SERVER}" == "true" ]; then
				args+=(-p 8081:8081);

				if [[ -z ${MYSQL_SERVER_ID} ]]; then
					args+=(-p 3306:3306);
				fi
			fi

			MYSQL_SERVER="";

			if [[ -n ${MYSQL_SERVER_ID} ]]; then
				MYSQL_SERVER="$MYSQL_CONTAINER_NAME";
			elif [[ -n ${MYSQL_HOST} ]]; then
				MYSQL_SERVER="$MYSQL_HOST";
			fi

			if [[ -n ${MYSQL_SERVER} ]]; then
				args+=(-e "MYSQL_SERVER=$MYSQL_SERVER");
				args+=(-e "MYSQL_SERVER_PORT=$MYSQL_PORT");
				args+=(-e "MYSQL_ROOT_USER=$MYSQL_ROOT_USER");
				args+=(-e "MYSQL_ROOT_PASSWD=$MYSQL_ROOT_PASSWORD");
				args+=(-e "MYSQL_SERVER_DB_NAME=$MYSQL_MAIL_DATABASE");
			fi

			args+=(-v "/app/onlyoffice/MailServer/data:/var/vmail");
			args+=(-v "/app/onlyoffice/MailServer/data/certs:/etc/pki/tls/mailserver");
			args+=(-v "/app/onlyoffice/MailServer/logs:/var/log");
			args+=(-h "$MAIL_DOMAIN_NAME");
			args+=("$MAIL_IMAGE_NAME:$MAIL_VERSION");

			MAJOR_DOCKER_VERSION=$(sudo docker -v | cut -d ' ' -f3 | cut -d ',' -f1 | cut -d '-' -f1 | cut -d '.' -f1);

			if [ ${MAJOR_DOCKER_VERSION} -ge 17 ]; then
				sudo docker run --init --net onlyoffice --privileged -i -t -d --restart=always "${args[@]}";
			else
				sudo docker run --net onlyoffice --privileged -i -t -d --restart=always "${args[@]}";
			fi

			MAIL_SERVER_ID=$(get_container_id "$MAIL_CONTAINER_NAME");

			if [[ -z ${MAIL_SERVER_ID} ]]; then
				echo "ONLYOFFICE MAIL SERVER not installed."
				exit 1;
			fi
		else
			echo "mail domain is not specified."
		fi
	fi
}

install_controlpanel () {
	CONTROL_PANEL_ID=$(get_container_id "$CONTROLPANEL_CONTAINER_NAME");

	RUN_CONTROL_PANEL="true";

	if [[ -n ${CONTROL_PANEL_ID} ]]; then
		if [ "$UPDATE" == "true" ]; then
			CURRENT_IMAGE_NAME=$(get_current_image_name "$CONTROLPANEL_CONTAINER_NAME");
			CURRENT_IMAGE_VERSION=$(get_current_image_version "$CONTROLPANEL_CONTAINER_NAME");

			if [ "$CURRENT_IMAGE_NAME" != "$CONTROLPANEL_IMAGE_NAME" ] || ([ "$CURRENT_IMAGE_VERSION" != "$CONTROLPANEL_VERSION" ] || [ "$SKIP_VERSION_CHECK" == "true" ]); then
				check_bindings $CONTROL_PANEL_ID "/var/lib/mysql";
				remove_container ${CONTROLPANEL_CONTAINER_NAME}
			else
				RUN_CONTROL_PANEL="false";
				echo "The latest version of ONLYOFFICE CONTROL PANEL is already installed."
				sudo docker start ${CONTROL_PANEL_ID};
			fi
		else
			RUN_CONTROL_PANEL="false";
			echo "ONLYOFFICE CONTROL PANEL is already installed."
			sudo docker start ${CONTROL_PANEL_ID};
		fi
	else
		RESTART_COMMUNITY_SERVER="true";
	fi

	if [ "$RUN_CONTROL_PANEL" == "true" ]; then
		args=();
		args+=(--name "$CONTROLPANEL_CONTAINER_NAME");

		if [[ -n ${MAIL_SERVER_API_HOST} ]]; then
			args+=(-e "MAIL_SERVER_EXTERNAL=true");
		fi

		if [[ -n ${DOCUMENT_SERVER_HOST} ]]; then
			args+=(-e "DOCUMENT_SERVER_EXTERNAL=true");
		fi

		if [[ -n ${COMMUNITY_SERVER_HOST} ]]; then
			args+=(-e "COMMUNITY_SERVER_EXTERNAL=true");
		fi

		if [[ -n ${CORE_MACHINEKEY} ]]; then
			args+=(-e "ONLYOFFICE_CORE_MACHINEKEY=$CORE_MACHINEKEY");
		fi

		args+=(-v "/var/run/docker.sock:/var/run/docker.sock");
		args+=(-v "/app/onlyoffice/CommunityServer/data:/app/onlyoffice/CommunityServer/data");
		args+=(-v "/app/onlyoffice/ControlPanel/data:/var/www/onlyoffice/Data");
		args+=(-v "/app/onlyoffice/ControlPanel/logs:/var/log/onlyoffice");
		args+=("$CONTROLPANEL_IMAGE_NAME:$CONTROLPANEL_VERSION");

		sudo docker run --net onlyoffice -i -t -d --restart=always "${args[@]}";

		CONTROL_PANEL_ID=$(get_container_id "$CONTROLPANEL_CONTAINER_NAME");

		if [[ -z ${CONTROL_PANEL_ID} ]]; then
			echo "ONLYOFFICE CONTROL PANEL not installed."
			exit 1;
		fi
	fi
}

install_community_server () {
	COMMUNITY_PORT=80
	COMMUNITY_SERVER_ID=$(get_container_id "$COMMUNITY_CONTAINER_NAME");
	DOCUMENT_SERVER_ID=$(get_container_id "$DOCUMENT_CONTAINER_NAME");
	MAIL_SERVER_ID=$(get_container_id "$MAIL_CONTAINER_NAME");
	CONTROL_PANEL_ID=$(get_container_id "$CONTROLPANEL_CONTAINER_NAME");
	MYSQL_SERVER_ID=$(get_container_id "$MYSQL_CONTAINER_NAME");

	RUN_COMMUNITY_SERVER="true";

	if [[ -n ${COMMUNITY_SERVER_ID} ]]; then
		if [ "$UPDATE" == "true" ]; then
			CURRENT_IMAGE_NAME=$(get_current_image_name "$COMMUNITY_CONTAINER_NAME");
			CURRENT_IMAGE_VERSION=$(get_current_image_version "$COMMUNITY_CONTAINER_NAME");

			if [ "$CURRENT_IMAGE_NAME" != "$COMMUNITY_IMAGE_NAME" ] || ([ "$CURRENT_IMAGE_VERSION" != "$COMMUNITY_VERSION" ] || [ "$SKIP_VERSION_CHECK" == "true" ]) || [ "$MOVE_COMMUNITY_SERVER_DATABASE" == "true" ]; then
				check_bindings $COMMUNITY_SERVER_ID "/var/lib/mysql";
				COMMUNITY_PORT=$(sudo docker port $COMMUNITY_SERVER_ID 80 | sed 's/.*://')
				stop_community_server_mysql
				remove_container ${COMMUNITY_CONTAINER_NAME}
			else
				RUN_COMMUNITY_SERVER="false";
				echo "The latest version of ONLYOFFICE COMMUNITY SERVER is already installed."
				sudo docker start ${COMMUNITY_SERVER_ID};
			fi
		else
			if [ "$RESTART_COMMUNITY_SERVER" == "true" ]; then
				check_bindings $COMMUNITY_SERVER_ID "/var/lib/mysql";
				COMMUNITY_PORT=$(sudo docker port $COMMUNITY_SERVER_ID 80 | sed 's/.*://')
				stop_community_server_mysql
				remove_container ${COMMUNITY_CONTAINER_NAME}
			else
				RUN_COMMUNITY_SERVER="false";
				echo "ONLYOFFICE COMMUNITY SERVER is already installed."
				sudo docker start ${COMMUNITY_SERVER_ID};
			fi
		fi
	fi

	if [ "$RUN_COMMUNITY_SERVER" == "true" ]; then
		args=();
		args+=(--name "$COMMUNITY_CONTAINER_NAME");
		args+=(-p "$COMMUNITY_PORT:80");
		args+=(-p 443:443);
		args+=(-p 5222:5222);

		if [[ -n ${MAIL_SERVER_API_HOST} ]]; then
			args+=(-e "MAIL_SERVER_API_HOST=$MAIL_SERVER_API_HOST");

			if [[ -n ${MAIL_SERVER_DB_HOST} ]]; then
				args+=(-e "MAIL_SERVER_DB_HOST=$MAIL_SERVER_DB_HOST");
			else
				args+=(-e "MAIL_SERVER_DB_HOST=$MAIL_SERVER_API_HOST");
			fi
		fi

		if [[ -n ${DOCUMENT_SERVER_HOST} ]]; then
			args+=(-e "DOCUMENT_SERVER_HOST=$DOCUMENT_SERVER_HOST");
		fi

		if [[ -n ${DOCUMENT_SERVER_ID} ]]; then
			args+=(-e "DOCUMENT_SERVER_PORT_80_TCP_ADDR=$DOCUMENT_CONTAINER_NAME");
		fi

		MYSQL_SERVER="";

		if [[ -n ${MYSQL_SERVER_ID} ]]; then
			MYSQL_SERVER="$MYSQL_CONTAINER_NAME";
		elif [[ -n ${MYSQL_HOST} ]]; then
			MYSQL_SERVER="$MYSQL_HOST";
		fi

		if [[ -n ${MYSQL_SERVER} ]]; then
			args+=(-e "MYSQL_SERVER_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD");
			args+=(-e "MYSQL_SERVER_DB_NAME=$MYSQL_DATABASE");
			args+=(-e "MYSQL_SERVER_HOST=$MYSQL_SERVER");
			args+=(-e "MYSQL_SERVER_USER=$MYSQL_USER");
			args+=(-e "MYSQL_SERVER_PASS=$MYSQL_PASSWORD");
		fi

		if [[ -n ${MAIL_SERVER_ID} ]]; then
			args+=(-e "MAIL_SERVER_API_HOST=$MAIL_CONTAINER_NAME");

			if [[ -n ${MYSQL_SERVER} ]]; then
				args+=(-e "MAIL_SERVER_DB_HOST=$MYSQL_SERVER");
				args+=(-e "MAIL_SERVER_DB_NAME=$MYSQL_MAIL_DATABASE");
				args+=(-e "MAIL_SERVER_DB_PORT=$MYSQL_PORT");
				args+=(-e "MAIL_SERVER_DB_USER=$MYSQL_ROOT_USER");
				args+=(-e "MAIL_SERVER_DB_PASS=$MYSQL_ROOT_PASSWORD");
			else
				args+=(-e "MAIL_SERVER_DB_HOST=$MAIL_CONTAINER_NAME");
			fi
		fi

		if [[ -n ${CONTROL_PANEL_ID} ]]; then
			args+=(-e "CONTROL_PANEL_PORT_80_TCP=80");
			args+=(-e "CONTROL_PANEL_PORT_80_TCP_ADDR=$CONTROLPANEL_CONTAINER_NAME");
		fi

		if [[ -n ${JWT_SECRET} ]]; then
			args+=(-e "DOCUMENT_SERVER_JWT_ENABLED=true");
			args+=(-e "DOCUMENT_SERVER_JWT_HEADER=AuthorizationJwt");
			args+=(-e "DOCUMENT_SERVER_JWT_SECRET=$JWT_SECRET");
		fi

		if [[ -n ${CORE_MACHINEKEY} ]]; then
			args+=(-e "ONLYOFFICE_CORE_MACHINEKEY=$CORE_MACHINEKEY");
		fi

		args+=(-v "/app/onlyoffice/CommunityServer/data:/var/www/onlyoffice/Data");
		args+=(-v "/app/onlyoffice/CommunityServer/logs:/var/log/onlyoffice");
		args+=(-v "/app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/DocumentServerData");
		args+=("$COMMUNITY_IMAGE_NAME:$COMMUNITY_VERSION");

		sudo docker run --net onlyoffice -i -t -d --restart=always "${args[@]}";

		COMMUNITY_SERVER_ID=$(get_container_id "$COMMUNITY_CONTAINER_NAME");

		if [[ -z ${COMMUNITY_SERVER_ID} ]]; then
			echo "ONLYOFFICE COMMUNITY SERVER not installed."
			exit 1;
		fi
	fi
}

get_container_id () {
	CONTAINER_NAME=$1;

	if [[ -z ${CONTAINER_NAME} ]]; then
		echo "Empty container name"
		exit 1;
	fi

	CONTAINER_ID="";

	CONTAINER_EXIST=$(sudo docker ps -aqf "name=$CONTAINER_NAME");

	if [[ -n ${CONTAINER_EXIST} ]]; then
		CONTAINER_ID=$(sudo docker inspect --format='{{.Id}}' ${CONTAINER_NAME});
	fi

	echo "$CONTAINER_ID"
}

get_container_ip () {
	CONTAINER_NAME=$1;

	if [[ -z ${CONTAINER_NAME} ]]; then
		echo "Empty container name"
		exit 1;
	fi

	CONTAINER_IP="";

	CONTAINER_EXIST=$(sudo docker ps -aqf "name=$CONTAINER_NAME");

	if [[ -n ${CONTAINER_EXIST} ]]; then
		CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINER_NAME});
	fi

	echo "$CONTAINER_IP"
}

get_random_str () {
	LENGTH=$1;

	if [[ -z ${LENGTH} ]]; then
		LENGTH=12;
	fi

	VALUE=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c ${LENGTH});
	echo "$VALUE"
}

set_jwt_secret () {
	CURRENT_JWT_SECRET="";

	if [[ -z ${JWT_SECRET} ]]; then
		CURRENT_JWT_SECRET=$(get_container_env_parameter "$DOCUMENT_CONTAINER_NAME" "JWT_SECRET");

		if [[ -n ${CURRENT_JWT_SECRET} ]]; then
			JWT_SECRET="$CURRENT_JWT_SECRET";
		fi
	fi

	if [[ -z ${JWT_SECRET} ]]; then
		CURRENT_JWT_SECRET=$(get_container_env_parameter "$COMMUNITY_CONTAINER_NAME" "DOCUMENT_SERVER_JWT_SECRET");

		if [[ -n ${CURRENT_JWT_SECRET} ]]; then
			JWT_SECRET="$CURRENT_JWT_SECRET";
		fi
	fi

	if [[ -z ${JWT_SECRET} ]] && [[ "$UPDATE" != "true" ]] && [[ "$USE_AS_EXTERNAL_SERVER" != "true" ]]; then
		JWT_SECRET=$(get_random_str 12);
	fi
}

set_core_machinekey () {
	CURRENT_CORE_MACHINEKEY="";

	if [[ -z ${CORE_MACHINEKEY} ]]; then
		if file_exists /app/onlyoffice/CommunityServer/data/.private/machinekey; then
			CURRENT_CORE_MACHINEKEY=$(cat /app/onlyoffice/CommunityServer/data/.private/machinekey);

			if [[ -n ${CURRENT_CORE_MACHINEKEY} ]]; then
				CORE_MACHINEKEY="$CURRENT_CORE_MACHINEKEY";
			fi
		fi
	fi

	if [[ -z ${CORE_MACHINEKEY} ]]; then
		CURRENT_CORE_MACHINEKEY=$(get_container_env_parameter "$CONTROLPANEL_CONTAINER_NAME" "ONLYOFFICE_CORE_MACHINEKEY");

		if [[ -n ${CURRENT_CORE_MACHINEKEY} ]]; then
			CORE_MACHINEKEY="$CURRENT_CORE_MACHINEKEY";
		fi
	fi

	if [[ -z ${CORE_MACHINEKEY} ]]; then
		CURRENT_CORE_MACHINEKEY=$(get_container_env_parameter "$COMMUNITY_CONTAINER_NAME" "ONLYOFFICE_CORE_MACHINEKEY");

		if [[ -n ${CURRENT_CORE_MACHINEKEY} ]]; then
			CORE_MACHINEKEY="$CURRENT_CORE_MACHINEKEY";
		fi
	fi

	if [[ -z ${CORE_MACHINEKEY} ]] && [[ "$UPDATE" != "true" ]] && [[ "$USE_AS_EXTERNAL_SERVER" != "true" ]]; then
		CORE_MACHINEKEY=$(get_random_str 12);
	fi
}

get_container_env_parameter () {
	CONTAINER_NAME=$1;
	PARAMETER_NAME=$2;
	VALUE="";

	if [[ -z ${CONTAINER_NAME} ]]; then
		echo "Empty container name"
		exit 1;
	fi

	if [[ -z ${PARAMETER_NAME} ]]; then
		echo "Empty parameter name"
		exit 1;
	fi

	if command_exists docker ; then
		CONTAINER_EXIST=$(sudo docker ps -aqf "name=$CONTAINER_NAME");

		if [[ -n ${CONTAINER_EXIST} ]]; then
			VALUE=$(docker inspect --format='{{range .Config.Env}}{{println .}}{{end}}' ${CONTAINER_NAME} | grep ${PARAMETER_NAME} | sed 's/^.*=//');
		fi
	fi

	echo "$VALUE"
}

move_mail_server_database () {
	EXIST_DATABASE=$(docker exec -i ${MYSQL_CONTAINER_NAME} ls /var/lib/mysql/ | { grep -sw ${MYSQL_MAIL_DATABASE} || true; });
	if [[ -n ${EXIST_DATABASE} ]]; then
		echo "$MYSQL_MAIL_DATABASE database already exist in $MYSQL_CONTAINER_NAME"
	else
		if ! docker exec -itd ${MAIL_CONTAINER_NAME} mysqladmin -u${MYSQL_ROOT_USER} -p${MYSQL_MAIL_ROOT_PASSWORD} status; then
			echo "$MAIL_CONTAINER_NAME mysqld service not available."
			exit 1;
		fi
		echo "creating $MYSQL_MAIL_DATABASE database dump file"
		if ! docker exec -it ${MAIL_CONTAINER_NAME} mysqldump -u${MYSQL_ROOT_USER} -p${MYSQL_MAIL_ROOT_PASSWORD} ${MYSQL_MAIL_DATABASE} > dump.sql; then
			echo "$MAIL_CONTAINER_NAME could not create $MYSQL_MAIL_DATABASE database dump file"
			exit 1;
		fi
		if ! docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $MYSQL_MAIL_DATABASE"; then
			echo "$MYSQL_CONTAINER_NAME could not create $MYSQL_MAIL_DATABASE database"
			exit 1;
		fi
		echo "restoring $MYSQL_MAIL_DATABASE database dump file"
		if ! docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} ${MYSQL_MAIL_DATABASE} < dump.sql; then
			echo "$MYSQL_CONTAINER_NAME could not restore $MYSQL_MAIL_DATABASE database dump file"
			exit 1;
		fi

		rm -f dump.sql
	fi
}

stop_mail_server_mysql () {
	if ! docker exec -it ${MAIL_CONTAINER_NAME} service mysqld stop; then
		echo "$MAIL_CONTAINER_NAME mysqld service could not be stopped correctly."
	fi
}

stop_community_server_mysql () {
	if ! docker exec -it ${COMMUNITY_CONTAINER_NAME} service god stop; then
			echo "$COMMUNITY_CONTAINER_NAME god service could not be stopped correctly."
	fi
	if ! docker exec -it ${COMMUNITY_CONTAINER_NAME} service mysql stop; then
		echo "$COMMUNITY_CONTAINER_NAME mysql service could not be stopped correctly."
	fi
}

remove_container () {
	CONTAINER_NAME=$1;

	if [[ -z ${CONTAINER_NAME} ]]; then
		echo "Empty container name"
		exit 1;
	fi

	echo "stop container:"
	sudo docker stop ${CONTAINER_NAME};
	echo "remove container:"
	sudo docker rm -f ${CONTAINER_NAME};

	sleep 10 #Hack for SuSe: exception "Error response from daemon: devmapper: Unknown device xxx"

	echo "check removed container: $CONTAINER_NAME"
	CONTAINER_ID=$(get_container_id "$CONTAINER_NAME");

	if [[ -n ${CONTAINER_ID} ]]; then
		echo "try again remove ${CONTAINER_NAME}"
		remove_container ${CONTAINER_NAME}
	fi
}

pull_mysql_server () {
	if file_exists "${MYSQL_IMAGE_NAME}"; then
		sudo docker load -i ${MYSQL_IMAGE_NAME}

		FILE_NAME=$(basename $MYSQL_IMAGE_NAME)
		TMP_STRING=${FILE_NAME//.tar.gz/ }
		TMP_ARRAY=(${TMP_STRING//_/ })
		MYSQL_IMAGE_NAME=${TMP_ARRAY[0]/-//}
		MYSQL_VERSION="${TMP_ARRAY[1]}"
	else
		if [[ -z ${MYSQL_VERSION} ]]; then
			MYSQL_VERSION=$(get_available_version "$MYSQL_IMAGE_NAME");
		fi

		pull_image ${MYSQL_IMAGE_NAME} ${MYSQL_VERSION}
	fi
}

pull_document_server () {
	if file_exists "${DOCUMENT_IMAGE_NAME}"; then
		sudo docker load -i ${DOCUMENT_IMAGE_NAME}

		FILE_NAME=$(basename $DOCUMENT_IMAGE_NAME)
		TMP_STRING=${FILE_NAME//.tar.gz/ }
		TMP_ARRAY=(${TMP_STRING//-/ })
		DOCUMENT_IMAGE_NAME="${TMP_ARRAY[0]}/${TMP_ARRAY[1]}"
		DOCUMENT_VERSION="${TMP_ARRAY[2]}"
	else
		if [[ -z ${DOCUMENT_VERSION} ]]; then
			DOCUMENT_VERSION=$(get_available_version "$DOCUMENT_IMAGE_NAME");
		fi

		pull_image ${DOCUMENT_IMAGE_NAME} ${DOCUMENT_VERSION}
	fi
}

pull_mail_server () {
	if file_exists "${MAIL_IMAGE_NAME}"; then
		sudo docker load -i ${MAIL_IMAGE_NAME}

		FILE_NAME=$(basename $MAIL_IMAGE_NAME)
		TMP_STRING=${FILE_NAME//.tar.gz/ }
		TMP_ARRAY=(${TMP_STRING//-/ })
		MAIL_IMAGE_NAME="${TMP_ARRAY[0]}/${TMP_ARRAY[1]}"
		MAIL_VERSION="${TMP_ARRAY[2]}"
	else
		if [[ -z ${MAIL_VERSION} ]]; then
			MAIL_VERSION=$(get_available_version "$MAIL_IMAGE_NAME");
		fi

		pull_image ${MAIL_IMAGE_NAME} ${MAIL_VERSION}
	fi
}

pull_controlpanel () {
	if file_exists "${CONTROLPANEL_IMAGE_NAME}"; then
		sudo docker load -i ${CONTROLPANEL_IMAGE_NAME}

		FILE_NAME=$(basename $CONTROLPANEL_IMAGE_NAME)
		TMP_STRING=${FILE_NAME//.tar.gz/ }
		TMP_ARRAY=(${TMP_STRING//-/ })
		CONTROLPANEL_IMAGE_NAME="${TMP_ARRAY[0]}/${TMP_ARRAY[1]}"
		CONTROLPANEL_VERSION="${TMP_ARRAY[2]}"
	else
		if [[ -z ${CONTROLPANEL_VERSION} ]]; then
			CONTROLPANEL_VERSION=$(get_available_version "$CONTROLPANEL_IMAGE_NAME");
		fi

		pull_image ${CONTROLPANEL_IMAGE_NAME} ${CONTROLPANEL_VERSION}
	fi
}

pull_community_server () {
	if file_exists "${COMMUNITY_IMAGE_NAME}"; then
		sudo docker load -i ${COMMUNITY_IMAGE_NAME}

		FILE_NAME=$(basename $COMMUNITY_IMAGE_NAME)
		TMP_STRING=${FILE_NAME//.tar.gz/ }
		TMP_ARRAY=(${TMP_STRING//_/ })
		COMMUNITY_IMAGE_NAME=${TMP_ARRAY[0]/-//}
		COMMUNITY_VERSION="${TMP_ARRAY[1]}"
	else
		if [[ -z ${COMMUNITY_VERSION} ]]; then
			COMMUNITY_VERSION=$(get_available_version "$COMMUNITY_IMAGE_NAME");
		fi

		pull_image ${COMMUNITY_IMAGE_NAME} ${COMMUNITY_VERSION}
	fi
}

pull_image () {
	IMAGE_NAME=$1;
	IMAGE_VERSION=$2;

	if [[ -z ${IMAGE_NAME} || -z ${IMAGE_VERSION} ]]; then
		echo "Docker pull argument exception: repository=$IMAGE_NAME, tag=$IMAGE_VERSION"
		exit 1;
	fi

	EXIST=$(sudo docker images | grep "$IMAGE_NAME" | awk '{print $2;}' | { grep -x "$IMAGE_VERSION" || true; });
	COUNT=1;

	while [[ -z $EXIST && $COUNT -le 3 ]]; do
		sudo docker pull ${IMAGE_NAME}:${IMAGE_VERSION}
		EXIST=$(sudo docker images | grep "$IMAGE_NAME" | awk '{print $2;}' | { grep -x "$IMAGE_VERSION" || true; });
		(( COUNT++ ))
	done

	if [[ -z $EXIST ]]; then
		echo "Docker image $IMAGE_NAME:$IMAGE_VERSION not found"
		exit 1;
	fi
}

set_partner_data () {
	if [[ -n ${PARTNER_DATA_FILE} ]]; then
		sudo curl -o /app/onlyoffice/CommunityServer/data/json-data.txt ${PARTNER_DATA_FILE}
	fi
}

create_network () {
	EXIST=$(sudo docker network ls | awk '{print $2;}' | { grep -x onlyoffice || true; });

	if [[ -z $EXIST ]]; then
		sudo docker network create --driver bridge onlyoffice
	fi
}

set_opensource_data () {
	COMMUNITY_IMAGE_NAME="onlyoffice/communityserver";
	DOCUMENT_IMAGE_NAME="onlyoffice/documentserver";
	MAIL_IMAGE_NAME="onlyoffice/mailserver";

	USERNAME="";
	PASSWORD="";

	INSTALL_CONTROLPANEL="false";

	PARTNER_ID="";
}

set_education_data () {
	COMMUNITY_IMAGE_NAME="onlyoffice4education/communityserver-ee";
	DOCUMENT_IMAGE_NAME="onlyoffice4education/documentserver-ee";
	CONTROLPANEL_IMAGE_NAME="onlyoffice4education/controlpanel-ee";

	USERNAME="";
	PASSWORD="";

	PARTNER_ID="";
}

ping_host_port() {
	HOST=$1
	PORT=$2

	if [ -z "$HOST" ] || [ -z "$PORT" ]; then
		echo "mysql host or port is empty"
		exit 1;
	fi

	if command_exists nc ; then
		RESULT=`nc -z -v -w5 $HOST $PORT &> /dev/null; echo $?`
		if [ $RESULT != 0 ]; then
			echo "Error ping $HOST:$PORT"
			exit 1;
		fi
	fi
}

check_domain() {
	if ! command_exists dig ; then
		if command_exists apt-get; then
			apt-get install -y dnsutils
		elif command_exists yum; then
			yum install bind-utils
		fi

		if ! command_exists dig; then
			echo "command dig not found"
			exit 1;
		fi

		if ! command_exists host; then
			echo "command host not found"
			exit 1;
		fi
	fi

	IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
	RESULT=$(host $MAIL_DOMAIN_NAME | { grep $IP || true; })

	if [[ -z $IP ]]; then
		echo "Could not determine the external ip of the current server";
		RESULT=true;
	elif [[ -z ${RESULT} ]]; then
		echo "$MAIL_DOMAIN_NAME is not linked to the $IP address. Please check your A-record."
		exit 1;
	fi
}

start_installation () {
	root_checking

	if ! command_exists sudo ; then
		install_sudo;
	fi

	if [ "$OPENSOURCE" == "true" ]; then
		set_opensource_data
	elif [ "$EDUCATION" == "true" ]; then
		set_education_data
	else
		set_jwt_secret
	fi

	set_core_machinekey

	get_os_info

	check_os_info

	check_kernel

	check_hardware

	if [ "$MAKESWAP" == "true" ]; then
		make_swap
	fi

	if [ "$UPDATE" != "true" ]; then
		check_ports
		MYSQL_VERSION="5.7.24";

		if [ "$INSTALL_MAIL_SERVER" == "true" ]; then
			if [[ -z ${MAIL_DOMAIN_NAME} ]]; then

				INSTALL_MAIL_SERVER_TEMP="";

				while [ "$INSTALL_MAIL_SERVER_TEMP" != "Y" ] && [ "$INSTALL_MAIL_SERVER_TEMP" != "N" ]; do
					read -p "Install ONLYOFFICE Mail Server [Y/N]?:" INSTALL_MAIL_SERVER_TEMP
					INSTALL_MAIL_SERVER_TEMP="$(echo $INSTALL_MAIL_SERVER_TEMP | tr '[:lower:]' '[:upper:]')";
				done

				if [ "$INSTALL_MAIL_SERVER_TEMP" = "Y" ]; then
					while [ -z "$MAIL_DOMAIN_NAME" ]; do
						read -p "Enter mail domain for ONLYOFFICE Mail Server: " MAIL_DOMAIN_NAME
					done
				fi
			fi

			if [[ -z ${MAIL_DOMAIN_NAME} ]]; then
				INSTALL_MAIL_SERVER="false";
			elif [ "$SKIP_DOMAIN_CHECK" != "true" ]; then
				check_domain
			fi
		fi
	fi

	if command_exists docker ; then
		check_docker_version
		sudo service docker start
	else
		install_docker
	fi

	docker_login

	make_directories

	set_partner_data

	create_network

	if [[ -z ${MYSQL_HOST} ]]; then
		if [ "$INSTALL_MAIL_SERVER" == "true" ] || [ "$INSTALL_COMMUNITY_SERVER" == "true" ]; then
			MYSQL_SERVER_ID=$(get_container_id "$MYSQL_CONTAINER_NAME");
			if [[ -z ${MYSQL_SERVER_ID} ]]; then
				pull_mysql_server
				install_mysql_server
			fi
		fi
	else
		ping_host_port "$MYSQL_HOST" "$MYSQL_PORT"
	fi

	if [ "$INSTALL_DOCUMENT_SERVER" == "true" ]; then
		pull_document_server
		install_document_server
	elif [ "$INSTALL_DOCUMENT_SERVER" == "pull" ] || [ "$PULL_DOCUMENT_SERVER" == "true" ]; then
		pull_document_server
	fi

	if [ "$INSTALL_MAIL_SERVER" == "true" ]; then
		pull_mail_server
		install_mail_server
	elif [ "$INSTALL_MAIL_SERVER" == "pull" ] || [ "$PULL_MAIL_SERVER" == "true" ]; then
		pull_mail_server
	fi

	if [ "$INSTALL_CONTROLPANEL" == "true" ]; then
		pull_controlpanel
		install_controlpanel
	elif [ "$INSTALL_CONTROLPANEL" == "pull" ] || [ "$PULL_CONTROLPANEL" == "true" ]; then
		pull_controlpanel
	fi

	if [ "$INSTALL_COMMUNITY_SERVER" == "true" ]; then
		pull_community_server
		install_community_server
	elif [ "$INSTALL_COMMUNITY_SERVER" == "pull" ] || [ "$PULL_COMMUNITY_SERVER" == "true" ]; then
		pull_community_server
	fi

	echo ""
	echo "Thank you for installing ONLYOFFICE."

	if [ "$OPENSOURCE" != "true" ]; then
		echo "You can now configure your portal and add Mail Server to your installation (in case you skipped it earlier) using the Control Panel"
	fi

	echo "In case you have any questions contact us via http://support.onlyoffice.com or visit our forum at http://dev.onlyoffice.org"
	echo ""

	exit 0;
}

start_installation
