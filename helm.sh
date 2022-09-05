#!/bin/bash

cd helm

case "$1" in
    "install")
        for i in $(ls -d */); do 
            #if [ "${i%%/}" = "deployment" ]; then continue; fi
            echo "# helm install ${i%%/} ./${i%%/}"
            helm install ${i%%/} ./${i%%/}
        done
    ;;
    "upgrade")
        for i in $(ls -d */); do 
            #if [ "${i%%/}" = "deployment" ]; then continue; fi
            echo "# helm upgrade ${i%%/} ./${i%%/}"
            helm upgrade ${i%%/} ./${i%%/}
        done
    ;;
    "uninstall")
        for i in $(ls -d */); do 
            #if [ "${i%%/}" = "deployment" ]; then continue; fi
            echo "# helm uninstall ${i%%/}"
            helm uninstall ${i%%/}
        done
    ;;
    "template")
        mkdir ../deployment
        for i in $(ls -d */); do
            #if [ "${i%%/}" = "deployment" ]; then continue; fi
            echo "# helm template app ./${i%%/} -f ./${i%%/}/values.yaml > ../deployment/${i%%/}.yaml"
            rm -f ./deployment/${i%%/}.yaml
            helm template app ./${i%%/} -f ./${i%%/}/values.yaml > ../deployment/${i%%/}.yaml
        done
    ;;
    *)
        echo "You have failed to specify what to do correctly."
        exit 1
    ;;
esac