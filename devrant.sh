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
userTokenFile="userToken.json"

# Dialog Settings
title="Devrant Dialog // by @teganburns";
w=8; h=40;
mw=70; mh=130;

# TODO: Clean up invalid charters from user input

function initPrompt {
    echo "called";
    res=$(dialog --title "$title" --menu "Welcome..." $mw $mh 2 1 Login 2 SignUp --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    case $res in
        1) loginPrompt;;
        2) signupPrompt;;
    esac
}

function handleUserToken {
    echo "Function Not implemented";
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
    clear;
    echo "UserToken: $userToken";
    echo "$userToken" | jq '.';
}

function loginPrompt {
    # Check for userToken // aka. user already logged in
    if [[ -e "userTokenFile" ]]; then
        # TODO: Handle Refresh tokens
        userToken=$( cat $userTokenFile );

    else
        # Prompt for Username/Password
        username=$( dialog --title "$title" --inputbox "Enter your username:" $w $h --output-fd 1 )
        if test $? -ne 0; then clear && exit; fi;
        password=$( dialog --title "$title" --inputbox "Enter your password:" $w $h --output-fd 1 )
        if test $? -ne 0; then clear && exit; fi;
        dialog --title "$title" --infobox "Logging in...\n\nIf you can read this you have a REALLY slow connection or something is not working correctly. Concider killing the application." $w $h;
        userToken=$( phantomjs js/login.js $username $password )

    fi
}

function navNotifications {
    echo "Notifications Function";
}

#function navFeed {}
#function navSearch {}
#function navCollabs {}
#function navProfile {}
#function navSettings {}

function navLogout { rm "$userTokenFile" && clear && exit; }

function mainNav {
    res=$( dialog --title "$title" --menu "Main Menu" $mw $mh $mw 1 Notifications 2 Feed 3 Search 4 Collabs 5 Profile 6 Settings 7 LogOut --output-fd 1 )
    if test $? -ne 0; then clear && exit; fi;
    case $res in
        0) clear && exit;;
        1) navNotifications;;
        2) clear && echo "Feed Menu";;
        3) clear && echo "Search Menu";;
        4) clear && echo "Collabs Menu";;
        5) clear && echo "Profile Menu";;
        6) clear && echo "Settings Menu";;
        7) clear && echo "Logged out!";;
    esac
}

initPrompt

if [[ $( echo $userToken | jq '.success' ) == true ]]; then
    echo $userToken > $userTokenFile;
    dialog --title "$title" --infobox "Login Sucessful!" $w $h; sleep 1; 
    mainNav;
elif [[ $( echo $userToken | jq '.success' ) == false ]]; then
    prompt="Error: "
    prompt+=$( echo $userToken | jq '.error' );
    prompt+="\n\nTry again?";
    dialog --title "$title" --yesno "$prompt" $w $h
    if test $? -ne 0; then clear && exit; else initPrompt; fi;

else
    echo "Unknown error when attempting to login..."; exit;
fi

exit

# dialog --menu "Choose one:" 10 30 3 1 red 2 green\ 3 blue






