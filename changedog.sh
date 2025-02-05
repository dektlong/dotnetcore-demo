#!/usr/bin/env bash

#change dog image to happy-dog
behappy() {
    sed "s/SADHAPPY/happy/g" config/deploying.cshtml > src/CloudPlatformDemo/Views/Home/Tas/PublishInstructions.cshtml
    
    ./build.sh Publish
}

#change dog image to sad-dog
besad() {
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
    echo "please specify happy / sad"    
    ;;
esac