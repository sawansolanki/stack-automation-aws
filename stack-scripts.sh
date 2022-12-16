#!/bin/bash

export STACK_NAME=my-bucket-stack-ga
export STACK_TEMPLATE_FILE=amazon-eks-vpc-private-subnets.yaml

output=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} 2>&1)

if [ $? -ne 0 ]; then
  if echo ${output} | grep -q ValidationError; then
        echo 'creating stack....' ${STACK_NAME}
		aws cloudformation deploy --template-file ${ROOT_PATH}/${STACK_TEMPLATE_FILE} --stack-name ${STACK_NAME}
  else
    >&2 echo "Error is -->" ${output}
  fi
fi
#>&2 means send the output to STDERR, So it will print the message as an error on the console.
