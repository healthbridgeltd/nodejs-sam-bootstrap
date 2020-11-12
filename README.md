# Node.js + AWS SAM bootstrap

Bootstrap project to quickly kick off your serverless projects running with Node.js and AWS SAM framework.

Features:
* Type checking and compilation for TypeScript code

## How to use this repo

Click on the green button that says "Use this template", then chose a name for your new repository.
This will create a new repository using this one.

![](how-to-use.gif)

## Setup Instructions

### Prerequisites

* [NodeJS version 12 or later](https://nodejs.org/en/download/) - or use [nvm](https://github.com/nvm-sh/nvm)
* [Docker](https://docs.docker.com/install)
* [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
* [SAM CLI](https://aws.amazon.com/serverless/sam/)

### Project Configuration

- Copy the `configs/.env.example` variable file to `configs/.env` and change the project name, username, aws profile.
```
cp configs/.env.example configs/.env
```

### Project Setup
- Go to AWS console -> IAM -> Users -> Create, and create new user with programmatic access.

- Run the following commands, and use the IAM key / secret you generated.
```
make setup
```

### Docker container build
```
make docker-build
```

### Install NodeJS dependencies
```
make install
```

### Local Development
To invoke the function locally through API Gateway
```
make run
```
When this command runs successfully, you will see the endpoints you can invoke


### AWS Deployment
To deploy the application to your aws account, invoke the following command
```
make deploy
```

- The default profile for deploy command is the aws profile in your .env, You can override it as follow:
```
make deploy STAGE=staging
```

## Make targets
```
help            Prints this help screen
setup           Create the s3 bucket that will host the artifcats in aws environment
docker-build    Build the docker image to execute make commands locally
install         install npm dependencies
lint            Run linter
format          Format code
tests           Run tests
deploy          Deploy application code (template.yml) to aws environment
run             Run the lambda functions locally
logs            Display logs of certain function (ex: make logs function=FUNCTION-NAME)
destroy         Destroy the stacks (resources & application)
```

## Contributing to this project

[Check contributing guidelines](./contributing.md)
