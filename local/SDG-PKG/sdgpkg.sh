#!/bin/bash

CACHE_DIR=/home/$(whoami)/.cache/SDG-PKG
CONF_DIR=/home/$(whoami)/.config/SDG-PKG
OLD_DIR=/home/$(whoami)/.cache/SDG-PKG/old
SUBCMD=$1
shift 1
ARG=("$@")


# todo: add verification for unipkg, git and other build dependencies


# ensure dirs
mkdir -p $CACHE_DIR
mkdir -p $CONF_DIR
mkdir -p $OLD_DIR

# enumerate repo's
REPOFILES=$(ls -1 $CONF_DIR)
REPOS=""

for FILE in $REPOFILES; do
	#echo "checking $FILE"
	REPOS="$REPOS
	$(cat $CONF_DIR/$FILE)"
	#echo "updated repo string: $REPOS"
done



case $SUBCMD in
	install)
		# todo: dont allow install if program is already installed. 
		for REPO in $REPOS; do
			PACKAGE=$(curl -s $REPO | grep -e "$ARG")
			if [ "$PACKAGE" != "" ]; then
				PKGURL=$(echo $PACKAGE | cut -d"|" -f2)
				if [ -e $CACHE_DIR/$ARG ];then
					echo "module $ARG already installed"
					exit 0
				fi
				git -C $CACHE_DIR clone $PKGURL $ARG
				echo "running install file $CACHE_DIR/$ARG/install.sh, please confirm content."
				cat $CACHE_DIR/$ARG/install.sh
				read -p "Do you want to proceed with installation? (y/N)" -n 1 CHOICE
				if [ "$CHOICE" != "y" ]; then
					exit 0
				else
					bash -c "$CACHE_DIR/$ARG/install.sh"
					echo "$ARG installed"
					exit 0
				fi
			fi
		done
		;;
	update)
		echo "updating git repo"
		git -C $CACHE_DIR/$ARG pull
		echo "running update file $CACHE_DIR/$ARG/update.sh, please confirm"
		cat $CACHE_DIR/$ARG/update.sh
		read -n 1 -p "Do you want to proceed with the update? (y/N)" CHOICE
		if [ "$CHOICE" != "y" ]; then
			exit 0
		else
			bash -c "$CACHE_DIR/$ARG/update.sh"
		fi
			 
		;;
	upgrade)
		INSTALLED=$(ls -1 $CACHE_DIR)
		for REPO in $INSTALLED; do
			git -C $CACHE_DIR/$REPO pull
			echo "running update file $CACHE_DIR/$REPO/update.sh, please confirm"
			cat $CACHE_DIR/$REPO/update.sh
			read -n 1 -p "do you want to proceed with the update? (y/N)" CHOICE
			if [ "$CHOICE" != "y" ]; then
				echo "full upgrade aborted"
				exit 0
			else
				bash -c "$CACHE_DIR/$REPO/update.sh"
			fi
		done
		;;
	uninstall)
		echo "running uninstall $CACHE_DIR/$ARG/uninstall.sh, please confirm"
		cat $CACHE_DIR/$ARG/uninstall.sh
		read -n 1 -p "do you want to proceed with the uninstall? (y/N)" CHOICE
		if [ "$CHOICE" != "y" ]; then
			exit 0
		else
			bash -c "$CACHE_DIR/$ARG/uninstall.sh"
			mv $CACHE_DIR/$ARG $OLD_DIR/$ARG
			echo "$ARG uninstalled and repo moved to $OLD_DIR, feel free to clean this directory."
		fi
		
		;;
	list)
		ls -1 $CACHE_DIR
		;;
	version)
		echo "version: 0.1"
		;;
	info)
		for REPO in $REPOS; do
			PACKAGE=$(curl -s $REPO | grep -e "$ARG")
			if [ "$PACKAGE" != "" ]; then
				PKGURL=$(echo $PACKAGE | cut -d"|" -f3)
				curl $PKGURL
			fi
		done
		;;
	fetch)
		for REPO in $REPOS; do
			echo "packages available in repository $REPO"
			curl -s $REPO | cut -d"|" -f1
			echo ""
		done
		;;
	upgradable)
		LOCAL=$(ls -1 $CACHE_DIR)
		UPGRADABLE=""
		for PACKAGE in $LOCAL; do
			git -C $CACHE_DIR/$PACKAGE fetch > /dev/null
			STATE=$(git -C $CACHE_DIR/$PACKAGE rev-list --count HEAD..@{u})
			#echo "$PACKAGE state: $STATE"
			if [ $STATE != 0 ]; then
				#echo "$PACKAGE" is behind.
				UPGRADABLE=$(echo "$UPGRADABLE
				$PACKAGE")
			fi
		done
		echo "upgradable modules:"
		echo $UPGRADABLE
		;;
	test)
		echo "repo files are:"
		echo "$REPOFILES"
		;;
	*)
		echo "help command"
		;;
esac

	
