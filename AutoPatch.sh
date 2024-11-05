#!/bin/bash

#
# AutoPatch.sh - Intel Gerrit Patch Automation Script
#
# Copyright (C) 2012 Intel Corporation
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Learnings
# ssh -p 29418 android.intel.com gerrit query --current-patch-set is:starred	- TO LIST is:starred items

VERSION_STRING="0.95"
GERRIT_SERVER="android.intel.com"
GERRIT_GIT_URL="git://$GERRIT_SERVER"
GERRIT_USER=""

PATCH_SAVE_PATH="$HOME/Downloads"
PATCH_LIST=""
PATCH_FILE_NAME="$1"
PATCH_REMOVE_URL_PART="$GERRIT_SERVER:29418"
PATCH_NUMBER_STRING_LEN=16
PATCH_URL_REMOVAL_LIST="$GERRIT_SERVER|mcg-pri-gcr.jf.intel.com"
PATCH_BRCM_URL_REMOVAL_LIST="mcg-pri-gcr.jf.intel.com"
PATCH_DIR_QUICK_START_NAME="platform/"

LINE_STRING="--------------------------------------------------------------------------------"

#PROGRAM FLOW
PATCH_MODE=1
REPO_ROOT=""
ISBRCM=0
CLEAN_PATCH_LIST=""
PROGRAM_RUN_CHECK="FALSE"

#CONSTANTS
START_PATH=$PWD

LogMe ()
{
	LOGME_FLAG=$1
	LOGME_MESSAGE=$2
	case $LOGME_FLAG in
		"INFO")
			printf "%-100s : [\033[1;37m%s\033[0m]\n" "$LOGME_MESSAGE" " INFO "
			;;
		"WARN")
			printf "%-100s : [\033[1;33m%s\033[0m]\n" "$LOGME_MESSAGE" " WARN "
			;;
		"PASS")
			printf "%-100s : [\033[1;32m%s\033[0m]\n" "$LOGME_MESSAGE" " PASS "
			;;
		"FAIL")
			printf "%-100s : [\033[1;31m%s\033[0m]\n" "$LOGME_MESSAGE" " FAIL "
			# UnSet_ENV_Variables
			exit 1
			;;
		*)
			printf "%-100s\n" "$LOGME_FLAG"
			;;
	esac
}

TRIM_String() {
	TRIM_STRING_VALUE=""
    TRIM_STRING_VALUE="$1"
    TRIM_STRING_VALUE="${TRIM_STRING_VALUE#"${TRIM_STRING_VALUE%%[![:space:]]*}"}"   # remove leading whitespace characters
    TRIM_STRING_VALUE="${TRIM_STRING_VALUE%"${TRIM_STRING_VALUE##*[![:space:]]}"}"   # remove trailing whitespace characters
}

CheckCommandExit ()
{
	if [ $? -eq 0 ]
	then
		LogMe "PASS" "$1"
	else
		LogMe "FAIL" "$1"
	fi	
}

Cherry_Pick_Patch ()
{
	PatchProject="$1"
	PatchNumber="$2"
	repo download -c "$PatchProject" "$PatchNumber"
	doSync
	
	#LogMe "INFO" "Start Cherry Pick Patches.."
	#while read PatchLine
	#do
		#if [ "$PatchLine" != "" ]
		#then
			#PatchLine=${PatchLine#*"$PATCH_REMOVE_URL_PART"}
			#PatchProject=${PatchLine%% *}
			#PatchNumber=${PatchLine#* } # GET THE PATCH NUMBER STRING
			#PatchNumber=${PatchNumber%% *} # REMOVE  "&& git cherry-pick FETCH_HEAD"
			#PatchNumber=${PatchNumber:$PATCH_NUMBER_STRING_LEN} # REMOVE ONLY THE PATCH NUMBER AND PATCHSET NUMBER
			#repo download -c "$PatchProject" "$PatchNumber"
			#CheckCommandExit "Apply Patch $PatchNumber -> $PatchProject"
			##printf "repo download -c %s %s\n" "$PatchProject" "$PatchNumber"
		#fi
	#done < "$PATCH_FILE_NAME"
}

SET_BRCM()
{
	ISBRCM=1
	GERRIT_GIT_URL="ssh://""$USER""@$PATCH_BRCM_URL_REMOVAL_LIST"
	GERRIT_SERVER="$PATCH_BRCM_URL_REMOVAL_LIST"
}

SET_INTEL()
{
	ISBRCM=0
	if [ "$GERRIT_USER" == "" ]
	then
		GERRIT_GIT_URL="git://""$GERRIT_SERVER"
	else
		GERRIT_GIT_URL="ssh://$GERRIT_USER@""$PATCH_REMOVE_URL_PART"
	fi
	GERRIT_SERVER="$GERRIT_SERVER"
}

Clean_Argument()
{
	CLEAN_PATCH_LIST=""
	Clean_Argument_String="$1"
	TRIM_String "$Clean_Argument_String"
	Clean_Argument_String="$TRIM_STRING_VALUE"
	if [ "${Clean_Argument_String:0:1}" != "#" -a "$Clean_Argument_String" != "" ]
	then
		ISDIRTY=`echo "$Clean_Argument_String" | egrep "$PATCH_URL_REMOVAL_LIST"`
		if [ ! -z $ISDIRTY ]; then
			# CHECK IF / IS PRESENT AT THE END OF THE PATCH STRING.. IF NOT ADD IT
			if [[ "$ISDIRTY" != *"/" ]]
			then
				ISDIRTY="$ISDIRTY""/"
			fi
			
			# Extract GERRIT number.
			CLEAN_PATCH_LIST=`echo "$ISDIRTY" | awk '
			BEGIN{FS="/"}
			{
				i = NF -1
				print $i
			}'`

			ISBRCM=`echo "$Clean_Argument_String" | egrep "$PATCH_BRCM_URL_REMOVAL_LIST"`
			if [ ! -z $ISBRCM ]; then
				SET_BRCM
			else
				SET_INTEL
			fi

		else
			CLEAN_PATCH_LIST="$Clean_Argument_String"
		fi
	fi
}

Sanity_Check()
{
	if [ ! -e ".repo" ]; then
		if [ $PATCH_MODE -lt 5 ]; then
			LogMe "FAIL" "Plaese RUN this Script from REPO root.."
		fi
	fi
	REPO_ROOT="$PWD"
}

Clean_VARS()
{
	PATCH_NUMBER=0
	LAST_TWO=0
	PATCH_INFO=0
	LATEST_PATCHSET=0
	PROJECT=0
	PROJEC_DIR=0
	ISPRESENT=0
	ISDIROK=0
	SUBJECT=0
	RAWDATA=0
}

FIX_DIR_QUIRK()
{
	# SOME SPECIAL QUIRK FOR WPA_SUPPLICANT & PREBUILT DIRECTORY
	if [ "$PROJECT_DIR" = "platform/external/wpa_supplicant_8/" ]; then
		PROJECT_DIR="hardware/intel/PRIVATE/wpa_supplicant_8/"
	fi
	if [[ "$PROJECT_DIR" == "device/intel/PREBUILT/xfstk-stitcher/" ]]
	then
		PROJECT_DIR="device/intel/PRIVATE/xfstk-stitcher/"
	fi
	if [[ "$PROJECT_DIR" == "hardware/intel/PRIVATE/pn544_fw/" ]]
	then
		PROJECT_DIR="device/intel/fw/nfc/pn544/"
	fi
	if [[ "$PROJECT_DIR" == "hardware/intel/PRIVATE/libintelprov/" ]]
	then
		PROJECT_DIR="hardware/intel/libintelprov/"
	fi	
	if [[ "$PROJECT_DIR" == "hardware/intel/PRIVATE/libcamera2/" ]]
	then
		PROJECT_DIR="hardware/intel/libcamera2/"
	fi
        if [[ "$PROJECT_DIR" == "hardware/intel/linux-2.6/" ]]
        then
                PROJECT_DIR="kernel/"
        fi
		
	# SOME PROJECTS PATCH ARE NOT THE SAME AS PROJECT GIT.		
	if [[ "$PROJECT_DIR" == "$PATCH_DIR_QUICK_START_NAME"* ]]
	then
		PROJECT_DIR="${PROJECT_DIR:${#PATCH_DIR_QUICK_START_NAME}}"
	fi
	
}

IS_DIR_OK()
{
	cd $REPO_ROOT
	if [ -e "$PROJECT_DIR" ]; then
		ISDIROK=1
	else
		ISDIROK=0
	fi	
}

IS_PATCH_Present()
{
	RAW_GIT_LOG=""
	RAW_PATCH_INFO_FROM_GERRIT=""
	cd $PROJECT_DIR
	RAW_GIT_LOG=`git log HEAD~1000..HEAD 2>/dev/null`

	HASDATA=`echo "$RAW_GIT_LOG"`
	if [ -z "$HASDATA" ]; then
		RAW_GIT_LOG=`git log`
	fi

	# FIND THE CHANGE IF ON THE GIT LOG.
	ISPRESENT=`echo "$RAW_GIT_LOG" | grep $CHANGEID`	

	if [ -z "$ISPRESENT" ]; then
		ISPRESENT=0
	else
		ISPRESENT=1
	fi
	cd $REPO_ROOT
}

GET_Patch_Data()
{
	Clean_VARS;
	PATCH_NUMBER=$1
	RAW_PATCH_INFO_FROM_GERRIT=""

	# GET THE LAST TWO DIGITS OF THE PATCH
	LAST_TWO=`echo $PATCH_NUMBER| awk '{ print substr( $PATCH_NUMBER, length($PATCH_NUMBER) - 1, length($PATCH_NUMBER) ) }'`

	# GO TO SOME GIT DIR, TO BE ABLE TO TALK TO GERRIT
	if [ "$PATCH_MODE" != "5" ]; then
		cd build
	fi

	RAW_PATCH_INFO_FROM_GERRIT=`ssh -p 29418 $GERRIT_SERVER gerrit query --current-patch-set $PATCH_NUMBER`
	# printf "%s\n" "$CURRENT_PATCHSET_FROM_GERRIT"
	
	if [ "$RAW_PATCH_INFO_FROM_GERRIT" != "" ]
	then
		# PARSE THE INFO
		PATCH_INFO="$RAW_PATCH_INFO_FROM_GERRIT"
		LATEST_PATCHSET=`echo "$RAW_PATCH_INFO_FROM_GERRIT" | grep number | tail -1 | awk '{print $2}'`
		# CHECK IF THE PATCH REALLY EXISTS
		if [ "$LATEST_PATCHSET" == "" ]
		then
			LogMe "FAIL" "Cannot get Patch Information for PATCH #$PATCH_NUMBER from Gerrit.."
		fi		
		PROJECT=`echo "$RAW_PATCH_INFO_FROM_GERRIT" | grep project: | tail -1 | awk '{print $2}'`
		RAWDATA="$RAW_PATCH_INFO_FROM_GERRIT"
		PROJECT_DIR=`echo $PROJECT|awk 'BEGIN{FS="/"}{
				for (i=3;i<=NF;i++){
					printf  $i "/"
				}
			}'`
		CHANGEID=`echo "$RAW_PATCH_INFO_FROM_GERRIT" | grep change | grep -v : | awk '{print $2}'`
		CURR_PATCHSET_ID=`echo "$RAW_PATCH_INFO_FROM_GERRIT" | grep revision: | tail -1 | awk '{print $2}'`
		SUBJECT=`echo "$RAW_PATCH_INFO_FROM_GERRIT" | grep subject | awk 'BEGIN{FS="subject:"}{print $1 $2}'`

		# CHECK IF THE PATCH REALLY EXISTS - PARANOID CHECK
		if [ "$CHANGEID" == "" ]
		then
			LogMe "FAIL" "Cannot get Patch Information for PATCH #$PATCH_NUMBER from Gerrit.."
		fi
		
		FIX_DIR_QUIRK;

		cd $REPO_ROOT

		IS_DIR_OK;
		if [ $ISDIROK -eq 1 ]; then	
			IS_PATCH_Present;
		fi

		#printf "%s\n" "$LINE_STRING"
		#printf "PATCH       = %s\n" "$PATCH_NUMBER"
		#printf "PROJECT     = %s\n" "$PROJECT"
		#printf "PATCHSET    = %s\n" "$LATEST_PATCHSET"
		#printf "PROJECT DIR = %s\n" "$PROJECT_DIR"
		#printf "ISDIROK     = %s\n" "$ISDIROK"
		#printf "CHANGE ID   = %s\n" "$CHANGEID"
		#printf "ISPRESENT   = %s\n" "$ISPRESENT"
		#printf "%s\n" "$LINE_STRING"

		#LogMe "PASS" "Get Patch Data DONE Successfully.."
	fi
}

Run_Action()
{
	Sanity_Check;
	Clean_Argument "$1";
	
	if [ "$CLEAN_PATCH_LIST" != "" ]
	then
		PROGRAM_RUN_CHECK="TRUE"
		GET_Patch_Data $CLEAN_PATCH_LIST;
		
		case $PATCH_MODE in
			0)Patch_Report;;
			1)Patch_Report_Short;;
			2)Apply_Patch;;
			3)Revert_Patch;;
			4)SAVE_Patch_LOCAL;;
			5)Abandon_Patch;;
			*)LogMe "WARN" "UNKNOWN MODE $MODE" ;;
		esac
	fi
}

List_Starred() 
{
	# ssh -p 29418 android.intel.com gerrit query --format=JSON --patch-sets is:starred | grep -Po '"url":.*?[^\\]"'
	ssh -p 29418 $GERRIT_SERVER gerrit query --format=JSON --patch-sets is:starred | grep -Po '"url":.*?[^\\]"'
}

Apply_Patch()
{
	APPLY_PATCH_INFO=""
	cd $PROJECT_DIR

	if [ $ISPRESENT -eq 0 ]; then
		printf "%s\n" "$LINE_STRING"
		LogMe "INFO" "Applying PATCH $PATCH_NUMBER -> $PROJECT"
		printf "%s\n" "$LINE_STRING"
		# Cherry_Pick_Patch "$PROJECT" "$PATCH_NUMBER/$LATEST_PATCHSET"
		# echo "git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git cherry-pick FETCH_HEAD"
		git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git cherry-pick FETCH_HEAD
		printf "%s\n" "$LINE_STRING"
		
		doSync
		# CHECK IF PATCH APPLY WORKED.
		APPLY_PATCH_INFO=`git show`
		APPLY_PATCH_SUCCESS_CHECK=`echo "$APPLY_PATCH_INFO" | grep $CHANGEID`
		if [ -z "$APPLY_PATCH_SUCCESS_CHECK" ]; then
			printf "\n%s\n" "$LINE_STRING"
			LogMe "INFO" "Applying Patch# $PATCH_NUMBER FAILED, Resetting the current GIT to HEAD.."
			git reset --hard
			printf "%s\n" "$LINE_STRING"
					
			LogMe "FAIL" "ERROR APPLYING PATCH!!! ***$PATCH_NUMBER***"
		else
			LogMe "PASS" "PATCH $PATCH_NUMBER APPLIED SUCCESSFULLY to $PROJECT"
			printf "%s\n" "$LINE_STRING"
		fi
	else
		TRIM_String "$SUBJECT"
		LogMe "PASS" "[FOUND] $PATCH_NUMBER - $TRIM_STRING_VALUE"
	fi

	cd $REPO_ROOT
}

Abandon_Patch()
{
	ABANDON_PATCH_INFO=""
#	cd $PROJECT_DIR

#	if [ $ISPRESENT -eq 0 ]; then
		printf "%s\n" "$LINE_STRING"
		LogMe "INFO" "Abandoning PATCH $PATCH_NUMBER -> $PROJECT"
		printf "%s\n" "$LINE_STRING"
		
		if [ "$CURR_PATCHSET_ID" != "" ]; then
			ssh -p 29418 $GERRIT_SERVER gerrit review --abandon $CURR_PATCHSET_ID
			CheckCommandExit "Abandonded Patch #$PATCH_NUMBER"
		else
			LogMe "FAIL" "PatchSet ChangeID information is NOT found to Abandon the Patch"
		fi
		
		# Cherry_Pick_Patch "$PROJECT" "$PATCH_NUMBER/$LATEST_PATCHSET"
		# echo "git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git cherry-pick FETCH_HEAD"
		#git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git cherry-pick FETCH_HEAD
		#printf "%s\n" "$LINE_STRING"
		
		#doSync
		# CHECK IF PATCH APPLY WORKED.
		#APPLY_PATCH_INFO=`git show`
		#APPLY_PATCH_SUCCESS_CHECK=`echo "$APPLY_PATCH_INFO" | grep $CHANGEID`
		#if [ -z "$APPLY_PATCH_SUCCESS_CHECK" ]; then
		#	printf "\n%s\n" "$LINE_STRING"
		#	LogMe "INFO" "Applying Patch# $PATCH_NUMBER FAILED, Resetting the current GIT to HEAD.."
		#	git reset --hard
		#	printf "%s\n" "$LINE_STRING"
		#			
		#	LogMe "FAIL" "ERROR APPLYING PATCH!!! ***$PATCH_NUMBER***"
		#else
		#	LogMe "PASS" "PATCH $PATCH_NUMBER APPLIED SUCCESSFULLY to $PROJECT"
		#	printf "%s\n" "$LINE_STRING"
		#fi
#	else
#		TRIM_String "$SUBJECT"
#		LogMe "PASS" "[FOUND] $PATCH_NUMBER - $TRIM_STRING_VALUE"
#	fi

#	cd $REPO_ROOT
}

Revert_Patch()
{
	LogMe "INFO" "REVERT NOT IMPLEMENTED YET."
}

doSync ()
{
	sync
}

SAVE_Patch_LOCAL()
{
	cd $REPO_ROOT/$PROJECT_DIR
	LogMe "INFO" "Getting Patch ... $PATCH_NUMBER"
	#echo "get_patch git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git format-patch -1 --stdout FETCH_HEAD > $REPO_ROOT/$PATCH_NUMBER.patch"
	git fetch $GERRIT_GIT_URL/$PROJECT refs/changes/$LAST_TWO/$PATCH_NUMBER/$LATEST_PATCHSET && git format-patch -1 --stdout FETCH_HEAD > $REPO_ROOT/$PATCH_NUMBER.patch
	CheckCommandExit "Get Patch $PATCH_NUMBER -> $REPO_ROOT/$PATCH_NUMBER.patch"
	cd $REPO_ROOT
}

Patch_Report()
{
	printf "%s\n" "$LINE_STRING"
	printf "PATCH       = %s\n" "$PATCH_NUMBER"
	printf "PROJECT     = %s\n" "$PROJECT"
	printf "PATCHSET    = %s\n" "$LATEST_PATCHSET"
	printf "PROJECT DIR = %s\n" "$PROJECT_DIR"
	printf "ISDIROK     = %s\n" "$ISDIROK"
	printf "CHANGE ID   = %s\n" "$CHANGEID"
	printf "ISPRESENT   = %s\n" "$ISPRESENT"
	printf "%s\n" "$LINE_STRING"
}

Patch_Report_Short()
{
	if [ $ISPRESENT -eq 1 ]; then
		LogMe "WARN" "$PATCH_NUMBER - IS PRESENT - $SUBJECT"
	else
		LogMe "INFO" "$PATCH_NUMBER - IS NOT PRESENT - $SUBJECT"
	fi
}

Read_From_File()
{
	PATCH_FILE_NAME="$1"
	PATCH_LIST=""
	
	if [ -s "$PATCH_FILE_NAME" ]
	then
		PROGRAM_RUN_CHECK="TRUE"
		while read Patch_Line
		do
			if [ "${Patch_Line:0:1}" != "#" ]
			then
				PATCH_LIST+=" "$Patch_Line
			fi
		done < $PATCH_FILE_NAME

		# Call MAIN Function to Run list of Patches..
		main $PATCH_LIST
	else
		LogMe "FAIL" "Patch List File Name: $PATCH_FILE_NAME NOT Found.."
	fi
}

Usage_Help()
{
	printf "Gerrit Patch Automation Script Rev %s\n\n" $VERSION_STRING
	echo "Usage is:
	AutoPatch <OPTION> <PATCH_LIST> <OPTION> <PATCH_LIST> ...

	AutoPatch tries to administer gerrit patches on your
	local repo. it should always run from the root dir 
	of the repo. 

	-<OPTIONS> will apply to all patches that follow it. 
	-OPTIONS are:
		-f <file>  - Get the Patch List from a file
			     Patch File can contain # infront of the Line to discard Parsing
		-prv       - Print verbose patch info
		-prs       - Print short patch info
		-apply     - Try to apply patch
		-abandon   - Abandond the Patch
		-revert    - Try to revert patch
		-brcm      - Patches are from brcm gerrit.
		-gp        - Get Patch - get .patch file
		-lstarred  - List Starred Patch Numbers

	-<PATCH_LIST> is a gerrit link or gerrit patch number.
	-PATCH_LIST should contian gerrit number and can be in format of:
		http://android.intel.com:8080/#/c/67880/ 
		67880
		https://mcg-pri-gcr.jf.intel.com:8080/#/c/103/

	-example:
		AutoPatch.sh -prv 67871 https://mcg-pri-gcr.jf.intel.com:8080/#/c/103/ brcm 200
		AutoPatch.sh -prs 67871 67873 67874 70852
		AutoPatch.sh -apply http://android.intel.com:8080/#/c/70006/
		AutoPatch.sh -apply -f Patches.txt
	"
	exit 0;
}

SET_User()
{
	GERRIT_USER=$1
}

# MAIN State Machine
main ()
{
	while [ ! -z "$1" ]; do
		case $1 in
			-prv)
				PATCH_MODE=0
				;;
			-prs)
				PATCH_MODE=1
				;;
			-clean)
				REPO_BRANCH_NAME=$(date +%Y%m%d_%H%M%S)
				repo start --all $REPO_BRANCH_NAME
				CheckCommandExit "CREATING NEW REPO Branch: $REPO_BRANCH_NAME"
				doSync
				repo forall -c "git clean -d -f -x"
				CheckCommandExit "CLEAN NEW REPO Branch: $REPO_BRANCH_NAME"
				doSync
				repo forall -c "git reset --hard HEAD"
				CheckCommandExit "RESET NEW REPO Branch: $REPO_BRANCH_NAME"
				doSync
				repo sync -c -j24
				CheckCommandExit "SYNC NEW REPO Branch: $REPO_BRANCH_NAME"
				doSync
				;;
			-apply)
				PATCH_MODE=2
				;;
			-revert)
				PATCH_MODE=3
				;;
			-brcm)
				set_brcm
				;;
			-gp)
				PATCH_MODE=4
				;;
			-abandon)
				PATCH_MODE=5
				;;
			-lstarred)
				List_Starred
				exit 0
				;;
			-f)
				Read_From_File $2
				exit 0
				;;
			-DEBUG)
				DEBUG=1
				;;
			-user)
				SET_User $2; shift
				;;
			-help)
				Usage_Help
				exit 0
				;;
			--help)
				Usage_Help
				exit 0
				;;
			*)
				Run_Action $1
				;;
		esac
		shift
	done
	
	if [ "$PROGRAM_RUN_CHECK" == "FALSE" ]
	then
		Usage_Help
	else
		printf "\n%s\n" "$LINE_STRING"
		LogMe "PASS" "AutoPatch Exited Successfully by Parsing ALL the Patches..."
		printf "%s\n" "$LINE_STRING"
	fi
}

# CLEAR THE SCREEN
clear

# PRINT THE VERSION STRING INFORMATION
printf "%s\n" "$LINE_STRING"
printf "PATCH Automation Script Rev %s\n" $VERSION_STRING
printf "%s\n\n" "$LINE_STRING"

# CALL THE MAIN FUNCTION TO CHERRY PICK THE PATCHES
main "$@";
