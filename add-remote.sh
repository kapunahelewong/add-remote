#!/usr/bin/env bash
# Bash script for adding someone else's fork as a remote to your Angular clone and checking out a specified branch.
#
#


bold=`tput bold`
normal=`tput sgr0`
clear
echo
echo
echo -e "\033[30;42m************************************************"
echo -e "                                                "
echo -e "                  ${bold} Add Remote${normal}\033[30;42m                   "
echo -e "                                                "
echo -e "          Add remote and checkout               "
echo -e "             a specific branch.                 "
echo -e "                                                "
echo -e "              Kapunahele Wong                   "
echo -e "                                                "
echo -e "                                                "
echo -e "************************************************\033[0m"
echo

echo "${bold}Run this script inside your local Angular clone."
echo "Enter the user's handle: ${normal}"
read user_name
echo
echo "${bold}Enter the name of the person's branch"
echo "as it appears on their fork: ${normal}"
read branch
echo
echo
echo "${bold}Enter the name of the person's branch"
echo "as you will refer to it locally.${normal}"
read your_branch
echo
echo

# Make remotes array
IFS=$'\n' read -r -d '' -a remotes < <( git remote && printf '\0' )

# print all remotes on separate lines
printf -- "%s\n" "${remotes[@]}"

# If the remote exists skip adding the remote. If it doesn't exist add the remote.
if [[ " ${remotes[@]} " =~ " ${user_name} " ]]; then
  echo "Remote already exists. Fetching branch…"
else
  echo "Adding new remote..."
  # Create an alias for the contributor's remote.
  git remote add $user_name https://github.com/$user_name/angular.git
  echo "$user_name added."
fi

# Fetch the PR branch.
git fetch $user_name $branch

# Create a new local branch based on their branch.
git checkout -b $your_branch $user_name/$branch
