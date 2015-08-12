#!/bin/bash
prof_name=""
prof_type=""
u_name=""
pswrd=""

OPTIND=1

while getopts ":p:t:u:w:" opt; do
  case $opt in
    p)
      prof_name=$OPTARG 
      ;;
    t)
      prof_type=$OPTARG
      ;;
    u)
      u_name=$OPTARG
      ;;
    w)
      pswrd=$OPTARG
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
ios profiles:download $prof_name  --type $prof_type  -u $u_name -p $pswrd 

prov_file="$prof_name.mobileprovision"
if [ -f "$prov_file" ]
then
    cp ${prov_file} ~/Library/MobileDevice/Provisioning\ Profiles/
fi

export UUID=$(profile_parse.py -i ~/Library/MobileDevice/Provisioning\ Profiles/$prov_file)
