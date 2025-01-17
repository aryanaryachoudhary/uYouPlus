#!/bin/bash
# Thanks Al4ise for his support

cd "$(dirname "$0")"

# Check uYou
	if [[ ! -f Tweaks/uYou/com.miro.uyou_2.1_iphoneos-arm.deb ]]
then
    	echo -e "==> \033[1muYou v2.1 is not found. Downloading uYou (v2.1)...\033[0m"
	(set -x ; curl https://miro92.com/repo/debs/com.miro.uyou_2.1_iphoneos-arm.deb --output Tweaks/uYou/com.miro.uyou_2.1_iphoneos-arm.deb)
else
    	echo -e "==> \033[1mFounded uYou (v2.1)!\033[0m"
	fi

# Extract uYou
	echo -e "==> \033[1mExtracting uYou...\033[0m"
	if (cd Tweaks/uYou && tar -xf com.miro.uyou_2.1_iphoneos-arm.deb && tar -xf data.tar.*)
then
	echo -e "\033[1m> Extracted uYou\033[0m"
else
	echo "> \033[1mCouldn't extract uYou\033[0m"
	fi

# Makefile
	read -e -p "==> Path to the decrypted YouTube IPA: " PATHTOIPA
	sed -i '' "14s#.*#uYouPlus_IPA = $PATHTOIPA#g" ./Makefile
	make clean package
	open ./packages

# Clean up	
	tput setaf 1 && echo -e "==> \033[1mCleaning up...\033[0m"
	find Tweaks/uYou -mindepth 1 -name com.miro.uyou_2.1_iphoneos-arm.deb -prune -o -exec rm -rf {} +
	rm -rf Resources
	rm -rf .theos/_/Payload