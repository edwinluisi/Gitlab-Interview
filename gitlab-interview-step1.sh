#! /bin/bash

#######################################
# First script for Gitlab Support Engineer interview process
#
# Write a Ruby or Bash script that will print usernames of all users on a Linux system together with
# their home directories. Here's some example output:
# gitlab:/home/gitlab
# nobody:/nonexistent
# .
# .
# Each line is a concatenation of a username, the colon character (:), and the home directory path
# for that username. Your script should output such a line for each user on the system.
#
# Author: Edwin Luisi
# Date: May 29, 2022
#######################################

# Getting the user and home directories for all users
cut -d":" -f1,7 /etc/passwd > /tmp/gitlab-interview-step1.out