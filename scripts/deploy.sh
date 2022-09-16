#!/usr/bin/env bash

# Package binaries and upload them to S3 bucket
sam package --template-file .aws-sam/build/$4.yaml --s3-bucket $2 --output-template-file build/templates/$1-$4-out.yaml --profile $1

# Wrap lambdas in the newrelic wrapper handler
sed -i'.handler.bak' -e 's/      Handler: app.lambdaHandler/      Handler: newrelic-lambda-wrapper.handler/g' build/templates/$1-$4-out.yaml

# Set NewRelic Layer Version
NEW_RELIC_LATEST_LAYER_NODE16=$(curl -s https://eu-west-1.layers.newrelic-external.com/get-layers?CompatibleRuntime=nodejs16.x \
  | jq -r '.Layers[] | select(.LayerArn == "arn:aws:lambda:eu-west-1:451483290750:layer:NewRelicNodeJS16X") | .LatestMatchingVersion.LayerVersionArn'
)
sed -i'.layer.bak' -e "s/NEW_RELIC_LAYER_NODE16/$NEW_RELIC_LATEST_LAYER_NODE16/g" build/templates/$1-$4-out.yaml

# Deploy binaries to lambda functions
sam deploy --template-file build/templates/$1-$4-out.yaml --s3-bucket $2 --stack-name $3 --capabilities CAPABILITY_NAMED_IAM --profile $1 --no-fail-on-empty-changeset --parameter-overrides Stage=$1 Username=$5
