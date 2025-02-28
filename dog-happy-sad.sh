#!/usr/bin/env bash

APPS_DOMAIN="apps.sdc.tpcf.tmm-labs.com"
BASE_APP_NAME="dotnetcore-demo"
PROD_SUB_DOMAIN="tanzudotnet"
DB_NAME="my-db"

#do-happy
do-happy() {
    
    echo && printf "\e[35m▶ Changing dog image to happy-dog and building codebase \e[m\n" && echo
    
    sed "s/SADHAPPY/happy/g" config/deploying.cshtml > src/CloudPlatformDemo/Views/Home/Tas/PublishInstructions.cshtml
    
    ./build.sh Publish

    deploy "happy"

    echo && printf "\e[35m▶ Hit any key to continue with route mapping? \e[m\n" && read
    echo

    map-routes "happy" "sad"
    
}

#do-sad
do-sad() {
     echo && printf "\e[35m▶ Changing dog image to sad-dog and building codebase \e[m\n" && echo

     sed "s/SADHAPPY/sad/g" config/deploying.cshtml > src/CloudPlatformDemo/Views/Home/Tas/PublishInstructions.cshtml
    
    ./build.sh Publish

    deploy "sad"

    echo && printf "\e[35m▶ Hit any key to continue with route mapping? \e[m\n" && read
    echo

    map-routes "sad" "happy"
}

#deploy
deploy() {
    dog_state=$1

    echo && printf "\e[35m▶ Deploying a staging $dog_state-dog application \e[m\n" && echo

    cf push $BASE_APP_NAME-$dog_state \
    -m 1G -i 3 --random-route -b dotnet_core_buildpack \
    -p src/CloudPlatformDemo/bin/Debug/net8.0/linux-x64/publish \
    --no-start

    cf bind-service $BASE_APP_NAME-$dog_state $DB_NAME

    cf start $BASE_APP_NAME-$dog_state
}

#map-routes
map-routes() {
    
    new_dog_state=$1
    old_dog_state=$2
    
    cf create-route $APPS_DOMAIN -n $PROD_SUB_DOMAIN 
    cf map-route $BASE_APP_NAME-$new_dog_state $APPS_DOMAIN -n $PROD_SUB_DOMAIN

    cf unmap-route $BASE_APP_NAME-$old_dog_state $APPS_DOMAIN -n $PROD_SUB_DOMAIN
}   


case $1 in

happy)
    do-happy
    ;;   
sad)
    do-sad
    ;;
*)
    echo && printf "\e[31m⏹ Incorrect usage. Please specify happy / sad \e[m\n"
    echo   
    ;;
esac