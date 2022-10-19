#!/bin/bash

terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json

total=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score")
eip=$(./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score")
sg=$(./opa eval --format pretty --data securitygroup.rego --input tfplan.json "data.terraform.analysis.score")
ec2=$(./opa eval --format pretty --data ec2.rego --input tfplan.json "data.terraform.analysis.score")
s3=$(./opa eval --format pretty --data s3.rego --input tfplan.json "data.terraform.analysis.score")
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")

under_limit=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz")

if [[ ${under_limit} == 'true' ]]
then
    if [[ ${total} > 1 ]]
    then
        all_arr=($eip $sg $ec2 $s3 $autoscaling)
        echo ${all_arr[*]}
    fi
fi    
