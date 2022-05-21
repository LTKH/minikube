#!/bin/bash
case "$1" in
    "install")
        for i in $(ls -d */); do 
            echo "# helm install ${i%%/} ./${i%%/}"
            helm install ${i%%/} ./${i%%/}
        done
    ;;
    "upgrade")
        for i in $(ls -d */); do 
            echo "# helm upgrade ${i%%/} ./${i%%/}"
            helm upgrade ${i%%/} ./${i%%/}
        done
    ;;
    "uninstall")
        for i in $(ls -d */); do 
            echo "# helm uninstall ${i%%/}"
            helm uninstall ${i%%/}
        done
    ;;
    *)
        echo "You have failed to specify what to do correctly."
        exit 1
    ;;
esac