#!/usr/bin/env bash
#!'C:/Program Files/Git/bin/sh.exe'
#
# Automatically adds branch name and branch description to every commit message.
# For excluded branches (like main), enforces that a branch name is prepended.
# Modified from the gist here https://gist.github.com/bartoszmajsak/1396344
#

# This way you can customize which branches should be skipped when
# prepending commit message.
if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master production staging main bangkok-pc)
fi

# Get branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Select ticket id from branch name and capitalize it
TICKET_ID=$(echo $BRANCH_NAME | sed -e 's:^\([^-]*-[^-]*\).*:\1:' -e \
    'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/')

# Regex to check the valid branch name (allows numbers in first part)
VALID_BRANCH_REGEX="^([a-zA-Z0-9]+\-[0-9]+.*)$"

# Regex to check if commit message starts with [BRANCH-NAME] format (allows numbers in first part)
BRANCH_PREFIX_REGEX="^\[[a-zA-Z0-9]+-[0-9]+\]"

# Whether branch name should be excluded from the prepend
BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")

# Whether the commit message has a TICKET_ID
BRANCH_IN_COMMIT=$(grep -c "$TICKET_ID" $1)

# Get the first line of the commit message
COMMIT_MSG=$(head -n 1 $1)

# Check if branch is excluded (like main)
if [[ $BRANCH_EXCLUDED -eq 1 ]]; then
  # For excluded branches, enforce that a branch name is prepended in square brackets
  if ! [[ "$COMMIT_MSG" =~ $BRANCH_PREFIX_REGEX ]]; then
    echo ""
    echo "========================================"
    echo "ERROR: Missing Branch Prefix"
    echo "========================================"
    echo ""
    echo "Commits to '$BRANCH_NAME' must have a branch name"
    echo "prepended in square brackets."
    echo ""
    echo "Expected format:"
    echo "  [ABC-123] Your commit message"
    echo ""
    echo "Your message:"
    echo "  $COMMIT_MSG"
    echo ""
    echo "Please update your commit message and try again."
    echo ""
    exit 1
  fi
elif [[ "$BRANCH_NAME" =~ $VALID_BRANCH_REGEX ]]; then
  # Valid feature branch - auto-prepend if needed
  if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]]; then
    sed -i -e "1s:^:[$TICKET_ID] :" $1
  fi
else
  # Invalid branch name
  echo ""
  echo "========================================"
  echo "ERROR: Invalid Branch Name"
  echo "========================================"
  echo ""
  echo "Current branch name: $BRANCH_NAME"
  echo ""
  echo "Branch names must follow the format: ABC-123-description"
  echo ""
  exit 1
fi