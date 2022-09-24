**Welcome, stranger!**

    install minikube - https://minikube.sigs.k8s.io/docs/start/
    install kubectl - https://kubernetes.io/docs/tasks/tools/
    install helm - https://helm.sh/docs/intro/install/

    # git clone https://github.com/LTKH/minikube.git
    # cd minikube

    # helm install alertmanager ./helm/alertmanager
    # helm install alerttrap ./helm/alerttrap
    # helm install grafana ./helm/grafana
    # helm install vmagent ./helm/vmagent
    # helm install vmalert ./helm/vmalert
    # helm install vminsert ./helm/vminsert
    # helm install vmselect ./helm/vmselect
    # helm install vmstorage ./helm/vmstorage

    kubectl port-forward service/grafana 3000:3000
    kubectl port-forward service/alerttrap 8081:8081

    http://localhost:3000 (admin/password)
    http://localhost:8081 (admin/password)