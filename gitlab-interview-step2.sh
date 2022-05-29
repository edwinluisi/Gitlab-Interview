#!/bin/bash

#######################################
# Second script for Gitlab Support Engineer interview process
#
# 1 - Takes the output of your first script and converts it to an MD5 hash.
#
# 2 - On its first run stores the MD5 checksum into the /var/log/current_users file.
#
# 3 - On subsequent runs, if the MD5 checksum changes, the script should add a line
# in the /var/log/user_changes file with the message, DATE TIME changes occurred, replacing DATE
# and TIME with appropriate values, and replaces the old MD5 checksum in /var/log/current_users file
# with the new MD5 checksum.
#
# Author: Edwin Luisi
# Date: May 29, 2022
#######################################

FIRST_SCRPT_OUT=/tmp/gitlab-interview-step1.out
FILE_CHKSUM_HASH=/var/log/current_users
FILE_CHKSUM_HASH_CMP=/tmp/current_users_cmp.md5
FILE_USER_CHNGS=/var/log/user_changes

if [ ! -f "$FILE_CHKSUM_HASH" ]; then
    echo "The $FILE_CHKSUM_HASH file does not exist and will be created."

    # Creating the MD5 hash for the /tmp/gitlab-interview-step1.out
    md5sum $FIRST_SCRPT_OUT > $FILE_CHKSUM_HASH

    # Printing the MD5 hash for the /tmp/gitlab-interview-step1.out
    echo -e "\nFile location: `ls -ld $FILE_CHKSUM_HASH`"
    echo -e "File content: `cat $FILE_CHKSUM_HASH`"
elif
   md5sum $FIRST_SCRPT_OUT > $FILE_CHKSUM_HASH_CMP
   cmp -s "$FILE_CHKSUM_HASH" "$FILE_CHKSUM_HASH_CMP"; then
	   printf 'There were no changes found in the last run.\n' "$FILE_CHKSUM_HASH" "$FILE_CHKSUM_HASH_CMP"
       rm $FILE_CHKSUM_HASH_CMP
   else
	   printf 'There are new changes. Please, see the "%s" to check the changes logs.\n' "$FILE_USER_CHNGS"
       echo "`date "+%F_%H:%M:%S"` changes ocurred" >> $FILE_USER_CHNGS
       cat $FILE_CHKSUM_HASH_CMP > $FILE_CHKSUM_HASH
       echo -e "\nThe new MD5 file hash is: " `cat $FILE_CHKSUM_HASH`
       rm $FILE_CHKSUM_HASH_CMP
fi