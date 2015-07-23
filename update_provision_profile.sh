#!/bin/bash   

#download all profiles 
ios profiles:download:all -u arturs.alehna@accenture.com -p Na8Kt3Bb

prov_file="./Hotstar__Development.mobileprovision"
if [ -f "$prov_file" ]
then
    cp ${prov_file} ~/Library/MobileDevice/Provisioning\ Profiles/
fi

export UUID="$(profile_parse.py -i ~/Library/MobileDevice/Provisioning\ Profiles/Hotstar__Development.mobileprovision)"

