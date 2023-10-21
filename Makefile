WEB_UI_USERNAME=admin
WEB_UI_PASSWORD=password

NAMESPACE=default

BASE_DIR=$(shell pwd)

all: 
	${MAKE} create
	${MAKE} install

create:
	printf "\033[32m------------------ applying settings\033[0m\n"
	kubectl create namespace ${NAMESPACE}
	kubectl -n ${NAMESPACE} apply -f ${BASE_DIR}/charts/quota.yaml
	kubectl -n ${NAMESPACE} create secret generic web-ui-user-pass --from-literal=username=${WEB_UI_USERNAME} --from-literal=password='${WEB_UI_PASSWORD}'
	
install:
	printf "\033[32m------------------ install charts\033[0m\n"
	cd ${BASE_DIR}/charts; for i in `ls -d */`; do \
	  printf "\033[32m------------------ install $${i%%/}\033[0m\n"; \
	  cd ${BASE_DIR} && helm -n ${NAMESPACE} upgrade --install $${i%%/} charts/$${i%%/}; \
	done

uninstall:
	printf "\033[32m------------------ uninstall charts\033[0m\n"
	cd ${BASE_DIR}/charts; for i in `ls -d */`; do \
	  printf "\033[32m------------------ uninstall $${i%%/}\033[0m\n"; \
	  cd ${BASE_DIR} && helm -n ${NAMESPACE} uninstall $${i%%/}; \
	done