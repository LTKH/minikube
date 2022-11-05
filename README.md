**Welcome, stranger!**

(charts/alerttrap/images/targets.jpg)

You need to install a few applications on your computer to get started.

    install minikube - https://minikube.sigs.k8s.io/docs/start/
    install kubectl - https://kubernetes.io/docs/tasks/tools/
    install helm - https://helm.sh/docs/intro/install/

Copy this repository to an arbitrary directory.

    # git clone https://github.com/LTKH/minikube.git
    # cd minikube

A few more commands to execute.

    # helm install alerttrap ./charts/alerttrap
    # helm install grafana ./charts/grafana
    # helm install alertmanager ./charts/alertmanager
    # helm install vmcluster ./charts/vmcluster
    # helm install vmagent ./charts/vmagent
    # helm install vmalert ./charts/vmalert
    # helm install loki ./charts/loki
    # helm install promtail ./charts/promtail
    
Monitoring is ready. Use it like this.

    kubectl port-forward service/grafana 3000:3000
    kubectl port-forward service/alerttrap 8081:8081

    http://localhost:3000 (admin/password)
    http://localhost:8081 (admin/password)