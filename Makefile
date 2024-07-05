WEB_UI_USERNAME=admin
WEB_UI_PASSWORD=password

NAMESPACE=default
CLUSTER_IP=10.107.146.91

BASE_DIR=$(shell pwd)

export PYTHONDONTWRITEBYTECODE=1

all: 
	${MAKE} create
	${MAKE} install

start:
	minikube start

stop:
	minikube stop

create:
	printf "\033[32m------------------ applying settings\033[0m\n"
	kubectl create namespace ${NAMESPACE}
	#kubectl -n ${NAMESPACE} apply -f ${BASE_DIR}/charts/quota.yaml
	kubectl -n ${NAMESPACE} create secret generic web-ui-user-pass --from-literal=username=${WEB_UI_USERNAME} --from-literal=password='${WEB_UI_PASSWORD}'
	
install:
	printf "\033[32m------------------ install charts\033[0m\n"
	cd ${BASE_DIR}/charts; for i in `ls -d */`; do \
	  printf "\033[32m------------------ install $${i%%/}\033[0m\n"; \
	  cd ${BASE_DIR} && helm -n ${NAMESPACE} upgrade --install $${i%%/} charts/$${i%%/}; \
	done
	cd ${BASE_DIR} && kubectl apply -f charts/ingress-nginx.yaml

uninstall:
	printf "\033[32m------------------ uninstall charts\033[0m\n"
	cd ${BASE_DIR}/charts; for i in `ls -d */`; do \
	  printf "\033[32m------------------ uninstall $${i%%/}\033[0m\n"; \
	  cd ${BASE_DIR} && helm -n ${NAMESPACE} uninstall $${i%%/}; \
	done

test:
	python3 -m pip install --user pytest requests #toml json_diff
	python3 -m pytest --cluster=${CLUSTER_IP} -v ${BASE_DIR}/tests/pytest
	k6 run -e CLUSTER_IP=${CLUSTER_IP} ${BASE_DIR}/tests/k6/netserver/test_netserver_api.js 
	#k6 run --out influxdb=http://127.0.0.1:8480/k6 click_performancetest.js --http-debug="full"