#!/usr/bin/env bash

#change dog image to happy-dog
behappy() {
    
    echo && printf "\e[35m▶ Changing dog image to happy-dog and building codebase \e[m\n" && echo
    
    sed "s/SADHAPPY/happy/g" config/deploying.cshtml > src/CloudPlatformDemo/Views/Home/Tas/PublishInstructions.cshtml
    
    ./build.sh Publish
}

#change dog image to sad-dog
besad() {
     echo && printf "\e[35m▶ Changing dog image to sad-dog and building codebase \e[m\n" && echo

     sed "s/SADHAPPY/sad/g" config/deploying.cshtml > src/CloudPlatformDemo/Views/Home/Tas/PublishInstructions.cshtml
    
    ./build.sh Publish

}    
case $1 in

happy)
    behappy
    ;;   
sad)
    besad
    ;;
*)
    echo && printf "\e[31m⏹ Incorrect usage. Please specify happy / sad \e[m\n"
    echo   
    ;;
esac