#!/usr/bin/env bash
#!'C:/Program Files/Git/bin/sh.exe'
#
# Automatically adds branch name and branch description to every commit message.
# Modified from the gist here https://gist.github.com/bartoszmajsak/1396344
#
echo "Hello"
# RED="\033[1;31m"
# GREEN="\033[1;32m"
# ORANGE="\033[0;33m"
# NOCOLOR="\033[0m"


# # This way you can customize which branches should be skipped when
# # prepending commit message.
# if [ -z "$BRANCHES_TO_SKIP" ]; then
#   BRANCHES_TO_SKIP=(master production staging main bangkok-pc)
# fi

# # Get branch name
# BRANCH_NAME=$(git branch | grep '*' | sed 's/* //')

# # Select ticket id from branch name and capitalize it
# TICKET_ID=$(echo $BRANCH_NAME | sed -e 's:^\([^-]*-[^-]*\)-.*:\1:' -e \
#     'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/')

# # Regex to check the valid branch name
# VALID_BRANCH_REGEX="^([a-zA-Z]+\-[0-9]+-.*)$"

# # Whether branch name should be excluded from the prepend
# BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")

# # Whether the commit message has a TICKET_ID
# BRANCH_IN_COMMIT=$(grep -c "$TICKET_ID" $1)

# # check the branch name is valid or not
# if [[ "$BRANCH_NAME" =~ $VALID_BRANCH_REGEX ]] || [[ $BRANCH_EXCLUDED -eq 1 ]] ; then
#   if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]]; then
#     sed -i -e "1s:^:[$TICKET_ID] :" $1
#   fi
# else
#   echo -e "${RED}Please correct the branch name"
#   echo -e "${NOCOLOR}Current BRANCH_NAME: ${ORANGE}${BRANCH_NAME}\n${NOCOLOR}"
#   exit 1;
# fi
