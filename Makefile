help:			## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

start:			## Start up containers
	docker compose up -d

stop:			## Tear down containers and volumes
	docker compose down -v

init:			## initialize git dependencies
	git submodule update --init --recursive

