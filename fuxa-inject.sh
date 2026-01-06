#!/bin/bash

# Title: FUXA-Inject
# Author: Jesse Cutshall (@kiddcutty)
# Description: Retrieve or change device tag values in FUXA instance.


function create_array {
curl -s -H "Content-Type: application/json" "${BASE_URL}${PROJECT_PATH}" > /tmp/project

jq -r '.devices[]?.tags? // {} | to_entries[] | "\(.value.name) \(.value.id)"' /tmp/project > /tmp/tags


while read -r line; do
        name=$(echo "$line" | awk '{$NF=""; print $0}' | sed 's/[ \t]*$//')
        tag=$(echo "$line" | awk '{print $NF}')

        OPTIONS["$name"]="$tag"
done < /tmp/tags

rm /tmp/project 
rm /tmp/tags
}

function main_menu {
echo -e "Select an action:\n"
select action in "Get Tag" "Set Tag" "Quit"; do
	case $action in 
	"Get Tag")
		sub_menu "get_tag" 
        break
		;;
	"Set Tag")
		sub_menu "set_tag"
        break:
		;;
	"Quit")
		echo "Exiting"
		exit 0
		;;
	*)
		echo "Invalid selection. Try Again..."
		;;
	esac
done
}

function sub_menu {
clear
local action=$1
echo -e "Would you like to get or set a tag value? Enter your selection: \n"
select name in "${!OPTIONS[@]}"; do
	tag=${OPTIONS[$name]}
	echo 
	echo -e "Selected Option: $name\nSelected Tag: $tag"
	echo 
	if [[ $action == "get_tag" ]]; then
		echo -e "\nRetrieving tag value\n"
		get_tag "$name" "$tag" 
	elif [[ $action == "set_tag" ]]; then
		echo "Enter the value to set:"
		read value
		echo -e "\nWriting tag value\n"
		set_tag "$name" "$tag" "$value"
	fi
	break
done
}

function get_tag {
	local name=$1
	local tag=$2
	local value=$(curl --silent --get \
		--data-urlencode "ids=[\"$tag\"]" \
		"${BASE_URL}${GET_TAG_PATH}"| sed -n 's/.*"value":\([0-9]\{1,3\}\).*/\1/p')
	echo "The current value is: $value"
	sleep 5
	clear
	main_menu
}

function set_tag {
	local name=$1
	local tag=$2
	local value=$3
	curl --silent --request POST \
		--header "Content-Type: application/json" \
		--data "{\"tags\":[{\"id\":\"$tag\",\"value\":\"$value\"}]}" \
		"${BASE_URL}${SET_TAG_PATH}"
	sleep 3
	get_tag "$name" "$tag"
	sleep 5
	clear
	main_menu
}

echo "  █████▒█    ██ ▒██   ██▒ ▄▄▄          ██▓ ███▄    █  ▄▄▄██▀▀▀▓█████  ▄████▄  ▄▄▄█████▓";
echo "▓██   ▒ ██  ▓██▒▒▒ █ █ ▒░▒████▄       ▓██▒ ██ ▀█   █    ▒██   ▓█   ▀ ▒██▀ ▀█  ▓  ██▒ ▓▒";
echo "▒████ ░▓██  ▒██░░░  █   ░▒██  ▀█▄     ▒██▒▓██  ▀█ ██▒   ░██   ▒███   ▒▓█    ▄ ▒ ▓██░ ▒░";
echo "░▓█▒  ░▓▓█  ░██░ ░ █ █ ▒ ░██▄▄▄▄██    ░██░▓██▒  ▐▌██▒▓██▄██▓  ▒▓█  ▄ ▒▓▓▄ ▄██▒░ ▓██▓ ░ ";
echo "░▒█░   ▒▒█████▓ ▒██▒ ▒██▒ ▓█   ▓██▒   ░██░▒██░   ▓██░ ▓███▒   ░▒████▒▒ ▓███▀ ░  ▒██▒ ░ ";
echo " ▒ ░   ░▒▓▒ ▒ ▒ ▒▒ ░ ░▓ ░ ▒▒   ▓▒█░   ░▓  ░ ▒░   ▒ ▒  ▒▓▒▒░   ░░ ▒░ ░░ ░▒ ▒  ░  ▒ ░░   ";
echo " ░     ░░▒░ ░ ░ ░░   ░▒ ░  ▒   ▒▒ ░    ▒ ░░ ░░   ░ ▒░ ▒ ░▒░    ░ ░  ░  ░  ▒       ░    ";
echo " ░ ░    ░░░ ░ ░  ░    ░    ░   ▒       ▒ ░   ░   ░ ░  ░ ░ ░      ░   ░          ░      ";
echo "          ░      ░    ░        ░  ░    ░           ░  ░   ░      ░  ░░ ░               ";
echo "                                                                     ░                 ";



declare -A OPTIONS
BASE_URL=""
PROJECT_PATH="/api/project"
GET_TAG_PATH="/api/getTagValue"
SET_TAG_PATH="/api/setTagValue"

read -p "Enter FUXA URL (i.e http://10.10.10.10:1881):  " BASE_URL

create_array 

main_menu

