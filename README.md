**Welcome, stranger!**

    install minikube - https://minikube.sigs.k8s.io/docs/start/
    install kubectl - https://kubernetes.io/docs/tasks/tools/
    install helm - https://helm.sh/docs/intro/install/

    # git clone https://github.com/LTKH/minikube.git
    # cd minikube
    # ./helm.sh install

    kubectl port-forward service/grafana 3000:3000
    kubectl port-forward service/alerttrap 8000:8000

    http://localhost:3000 (admin/password)
    http://localhost:8000 (admin/password)