#!make
include ./configs/.env
export $(shell sed 's/=.*//' ./configs/.env)
export SAM_CLI_TELEMETRY=0
export UID=$(shell id -u)
export GID=$(shell id -g)

AWS_PROFILE ?= sandbox
APP_TEMPLATE = "template"
S3_BUCKET = $(APP_NAME)-$(AWS_PROFILE)-$(USERNAME)

ifneq ($(USE_DOCKER),no)
	PROJECT_DIR ?=  $(shell pwd)
	DOCKER = docker run --user ${UID}:${GID} -t -v ${PROJECT_DIR}:/app $(APP_NAME):latest
endif

.SILENT:
.PHONY: help

## Prints this help screen
help:
	printf "Available targets\n\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-15s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)


## Create the s3 bucket that will host the artifacts in aws environment
setup:
	aws configure --profile $(AWS_PROFILE)
	aws s3 mb s3://$(S3_BUCKET) --profile $(AWS_PROFILE)

## Build the docker image to execute make commands locally
docker-build:	
	docker build --build-arg UID=${UID} --build-arg GID=${GID} -f build/ci/Dockerfile . -t $(APP_NAME):latest

## Install npm dependencies
install:
	${DOCKER} npm ci

## Run npm audit
audit:
	${DOCKER} npm audit

## Install npm audit fixes
audit-fix:
	${DOCKER} npm audit fix

## Run linter
lint:
	${DOCKER} npm run lint

## Format code
format:
	${DOCKER} npm run lint:fix

## Run tests
tests:
	${DOCKER} npm run test

## Build webpack
webpack-build:
	NODE_ENV=production ${DOCKER} npm run build

## Deploy application code (template.yml) to aws environment
deploy: webpack-build
	scripts/deploy.sh $(AWS_PROFILE) $(S3_BUCKET) $(APP_NAME) ${APP_TEMPLATE} ${USERNAME}

## Run the lambda functions locally
run: webpack-build
	cp configs/lambdas-env.json /tmp/lambdas-env.json && sed -n 's/#USERNAME#/${USERNAME}/g' /tmp/lambdas-env.json
	cd .aws-sam/build/ && sam local start-api --env-vars /tmp/lambdas-env.json --profile $(AWS_PROFILE)

## Display logs of certain function (ex: make logs function=FUNCTION-NAME)
logs:
	sam logs -n $(function) --stack-name $(APP_NAME) --profile $(AWS_PROFILE)
## Destroy the stacks (resources & application)
destroy:
	aws cloudformation delete-stack --stack-name $(APP_NAME) --profile $(AWS_PROFILE)
