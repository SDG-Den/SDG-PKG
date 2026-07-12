#!/bin/bash

CACHE_DIR=/home/$(whoami)/.cache/SDG-PKG
CONF_DIR=/home/$(whoami)/.config/SDG-PKG
OLD_DIR=/home/$(whoami)/.cache/SDG-PKG-OLD
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

runfile() {
	local FILENAME=$1
	echo "running file $FILENAME"
	cat $CACHE_DIR/$ARG/$FILENAME
	read -p "Do you wish to proceed? (y/N)" -n 1 CHOICE > /dev/tty
	echo ""
	if [ "$CHOICE" != "y" ]; then
		exit 0
	else
		bash -c "$CACHE_DIR/$ARG/$FILENAME"
	fi
}

pullpkg() {
	if [ -e $CACHE_DIR/$ARG ];then
		git -C $CACHE_DIR/$ARG pull
	else
		git -C $CACHE_DIR clone $PKGURL $ARG
	fi
}


case $SUBCMD in
	install)
		for REPO in $REPOS; do
			PACKAGE=$(curl -s $REPO | grep -e "$ARG")
			if [ "$PACKAGE" != "" ]; then
				PKGURL=$(echo $PACKAGE | cut -d"|" -f2)
				pullpkg
				
			fi
			runfile install.sh
			exit 0
		done
		;;
	update)
		echo "updating git repo"
		pullpkg
		runfile update.sh
			 
		;;
	upgrade)
		INSTALLED=$(ls -1 $CACHE_DIR)
		for ARG in $INSTALLED; do
			pullpkg
			runfile update.sh
		done
		;;
	uninstall)
		runfile uninstall.sh
		mv $CACHE_DIR/$ARG $OLD_DIR/$ARG-$RANDOM
		
		;;
	list)
		ls -1 $CACHE_DIR
		;;
	version)
		echo "version: 0.2"
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
	sync)
		for REPO in $REPOS; do
			PACKAGE=$(curl -s $REPO | grep -e "$ARG")
			if [ "$PACKAGE" != "" ]; then
				PKGURL=$(echo $PACKAGE | cut -d"|" -f2)
				pullpkg
			fi
			exit 0
		done
		;;
	remove)
		mv $CACHE_DIR/$ARG $OLD_DIR/$ARG-$RANDOM
		;;
	changelog)
	for REPO in $REPOS; do
			PACKAGE=$(curl -s $REPO | grep -e "$ARG")
			if [ "$PACKAGE" != "" ]; then
				PKGURL=$(echo $PACKAGE | cut -d"|" -f3)
				curl -s $(echo $PKGURL | sed 's/info.md/CHANGELOG.md/') | head -n 40
			fi
		done
		;;
	branch)
		subcomm=$1
		shift 1
		ARG=("$@")
		case $subcomm in
			list)
			echo $(git -C $CACHE_DIR/$ARG branch -l)
			;;
			switch)
			module=$1
			branch=$2
			git -C $CACHE_DIR/$module switch -f --progress $branch 
			;;
			*)
			echo "[ sdgpkg help ]"
			echo ""
			echo "branch subcommands"
			echo "sdgpkg branch list <packagename> - lists branches for a package"
			echo "sdgpkg branch switch <packagename> <branch> - switches the local cached repository to a specified branch"
			echo ""
		esac


		;;
		
	
	*)
		echo ""
		echo "[ sdgpkg help ]"
		echo ""
		echo "commands:"
		echo "sdgpkg help - shows this menu"
		echo "sdgpkg fetch - lists available packages"
		echo "sdgpkg list - lists installed packages"
		echo "sdgpkg upgradable - lists upgradable packages"
		echo "sdgpkg version - shows sdgpkg version"
		echo ""
		echo "sdgpkg install <packagename> - installs the package"
		echo "sdgpkg update <packagename> - updates the package"
		echo "sdgpkg uninstall <packagename> - uninstalls the package"
		echo "sdgpkg upgrade - updates all installed packages"
		echo "sdgpkg info <packagename> - fetches info about a package"
		echo ""
		echo "sdgpkg remove <packagename> - removes the repository without removing the binaries"
		echo "sdgpkg sync <packagename> - clones or pulls the repository without installing"
		echo "sdgpkg branch <subcommand> <packagename> <branch>" - lists and switches git branches
		echo ""
		echo "example:"
		echo ""
		echo "sdgpkg install sdgos-meta - installs the package \"sdgos-meta\""
		echo "sdgpkg update unipkg - updates unipkg"
		echo "sdgpkg info sdg-pkg - shows info for sdg-pkg"
		echo "sdgpkg branch switch sdg-vox dev - switches the sdg-vox repo to the dev branch" 
		;;
esac

	
