#!/bin/bash
prof_name=""
prof_type=""

OPTIND=1

while getopts ":p:t:" opt; do
  case $opt in
    p)
      prof_name=$OPTARG 
      ;;
    t)
      prof_type=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift


#download all profiles
ios profiles:download $prof_name  --type $prof_type  -u <email> -p <pwd> 

prov_file="$prof_name.mobileprovision"
if [ -f "$prov_file" ]
then
    cp ${prov_file} ~/Library/MobileDevice/Provisioning\ Profiles/
fi

export UUID=$(profile_parse.py -i ~/Library/MobileDevice/Provisioning\ Profiles/$prov_file)
