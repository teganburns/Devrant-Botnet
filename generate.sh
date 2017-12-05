#! /bin/bash

#  Copyright 2017 Tegan Burns-Berger
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

## Colors ##
readonly NC='\033[0m'
readonly LBLUE='\033[0;34m'
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'


## Setup Variables ##
url="https://devrant.com/api/users"
username="dfox"
email="dfox@devrant.com"
password="123456"
app="3"
type_="1"


## POST Request ##
response=$( curl -s -L -X POST -F "username=$username" -F "email=$email" -F "password=$password" -F "app=$app" -F "type=$type_" $url )

## Handle Response ##
if [ $(echo $response | jq '.success') == 'false' ]; then
    echo -e "$RED"
    echo "Account creation failed for \"$username\"!!"
    echo -e "error$NC : $( echo $response | jq '.error')"
    echo -e "$RED error_field $NC : $( echo $response | jq '.error_field')"
    exit;

elif [ $(echo $response | jq '.success') == 'success' ]; then
    echo -e "$GREEN"
    echo "Account creation sucessful for \"$username\"!!"
    echo "$response | jq '.'"
    echo -e "$NC"
    exit;

else
    echo "Unknown error occoured. Dumping response below after 10 seconds."
    echo "-----------------------------------------------"
    sleep 10
    echo "$response"
    exit;

fi

