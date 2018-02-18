#! /usr/bin/bash    
# author: Tegan Burns
# website: teganburns.com

# Bash Script to Automate Headless Interaction with Devrant
# Copyright 2018 Tegan Burns
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

username="";
password="";
email="";
userToken="";

# Dialog Settings
title="Devrant Dialog // by @teganburns";
w=8; h=40;
mw=12; mh=80;


# TODO: Check for userToken

function initPrompt {
    echo "called";
    #dialog --title "$title" --menu "Welcome..." $w $h 3 1 red 2 green 3 blue
    res=$(dialog --title "$title" --menu "Welcome..." $mw $mh 2 1 Login 2 SignUp --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    case $res in
        1) loginPrompt;;
        2) signupPrompt;;
    esac
}

function signupPrompt {
    # Prompt for Username/Password
    email=$( dialog --title "$title" --inputbox "Enter your email:" $w $h --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
        username=$( dialog --title "$title" --inputbox "Please choose a username (4-15 charters):" $w $h --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
        password=$( dialog --title "$title" --inputbox "Please choose a password (6+ charters):" $w $h --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    dialog --title "$title" --infobox "Signing up...\n\nIf you can read this you have a REALLY slow connection or something is not working correctly. Concider killing the application." $w $h;
    userToken=$( phantomjs js/signUp.js $username $password $email )
}

function loginPrompt {
    # Prompt for Username/Password
    username=$( dialog --title "$title" --inputbox "Enter your username:" $w $h --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    password=$( dialog --title "$title" --inputbox "Enter your password:" $w $h --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    dialog --title "$title" --infobox "Logging in...\n\nIf you can read this you have a REALLY slow connection or something is not working correctly. Concider killing the application." $w $h;
    userToken=$( phantomjs js/login.js $username $password )
}


function mainNav {
    res=$( dialog --title "$title" --menu "Welcome..." $w $h 10 1 Notifications 2 Feed 3 Search 4 Collabs 5 Profile 6 Settings 7 Log Out )
    echo "Res: $res";
}

initPrompt

if [[ $( echo $userToken | jq '.success' ) == true ]]; then
    mainNav;
elif [[ $( echo $userToken | jq '.success' ) == false ]]; then
    # TODO: Create Retry Prompt
    #retry=$( dialog --yesno "Try again?" $w $h )
    #if test $? -ne 0; then clear && exit; fi;
    #echo "Retry!: $retry";
    clear; echo "Login Failed!";

else
    echo "Unknown error when attempting to login..."; exit;
fi

exit

# dialog --menu "Choose one:" 10 30 3 1 red 2 green\ 3 blue






