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

PARAMETERS="";
DOCKER="";
HELP="false";

while [ "$1" != "" ]; do

	if [ "$1" == "-?" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
		HELP="true";
		DOCKER="true";
		PARAMETERS="$PARAMETERS -ht enterprise-install.sh";
	fi

	PARAMETERS="$PARAMETERS ${1}";
	shift
done

PARAMETERS="$PARAMETERS -os false -ed false";

command_exists () {
	type "$1" &> /dev/null;
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

read_installation_method () {
	echo "Select 'Y' to install ONLYOFFICE using Docker (recommended). Select 'N' to install it using RPM/DEB packages.";
	echo "Please note, that in case you select RPM/DEB installation, 'HTTPS' and 'Update' sections will be absent from the Control Panel.";
	echo "You will also need to manually install Mail Server and connect it to your ONLYOFFICE installation.";
	echo "See instructions in our Help Center: http://helpcenter.onlyoffice.com/server/docker/mail/connect-mail-server-to-community-server-via-portal-settings.aspx";
	read -p "Install with Docker [Y/N/C]? " choice
	case "$choice" in
		y|Y )
			DOCKER="true";
		;;

		n|N )
			DOCKER="false";
		;;

		c|C )
			exit 0;
		;;

		* )
			echo "Please, enter Y, N or C to cancel";
		;;
	esac

	if [ "$DOCKER" == "" ]; then
		read_installation_method;
	fi
}

if ! command_exists sudo ; then
	install_sudo;
fi

if ! command_exists curl ; then
	install_curl;
fi

if [ "$HELP" == "false" ]; then
	read_installation_method;
fi

if [ "$DOCKER" == "true" ]; then
	[ -f install.sh ] || sudo curl -s -O http://download.onlyoffice.com/install/install.sh
	sudo bash install.sh ${PARAMETERS}
#	sudo rm install.sh
else
	if [ -f /etc/redhat-release ] ; then
		DIST=$(cat /etc/redhat-release |sed s/\ release.*//);
		REV=$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//);

		REV_PARTS=(${REV//\./ });
		REV=${REV_PARTS[0]};

		if [[ "${DIST}" == CentOS* ]] && [ ${REV} -lt 7 ]; then
			echo "CentOS 7 or later is required";
			exit 1;
		fi

		sudo curl -s -O http://download.onlyoffice.com/install/install-RedHat.sh
		sudo bash install-RedHat.sh ${PARAMETERS}
		sudo rm install-RedHat.sh
	elif [ -f /etc/debian_version ] ; then
		[ -f install-Debian.sh ] || sudo curl -s -O http://download.onlyoffice.com/install/install-Debian.sh
		sudo bash install-Debian.sh ${PARAMETERS}
		sudo rm install-Debian.sh
	else
		echo "Not supported OS";
		exit 1;
	fi
fi
