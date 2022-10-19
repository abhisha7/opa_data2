#!/bin/bash

terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json

total=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score")
eip=$(./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score")
eip="eip:${eip}"
sg=$(./opa eval --format pretty --data securitygroup.rego --input tfplan.json "data.terraform.analysis.score")
sg="sg:${sg}"
ec2=$(./opa eval --format pretty --data ec2.rego --input tfplan.json "data.terraform.analysis.score")
ec2="ec2:${ec2}"
s3=$(./opa eval --format pretty --data s3.rego --input tfplan.json "data.terraform.analysis.score")
s3="s3:${s3}"
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")
autoscaling="autoscaling:${autoscaling}"
under_limit=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz")

declare -A score_arr
score_arr["autoscaling"]="30"
score_arr["s3"]="10"
score_arr["ec2"]="10"
score_arr["eip"]="10"
score_arr["sg"]="20"


if [[ ${under_limit} == 'true' ]]
then
    if [[ ${total} > 1 ]]
    then
        all_resources_arr=($eip $sg $ec2 $s3 $autoscaling)
        echo ${all_resources_arr[*]}
        final_score=0
        for resource in "${all_resources_arr[@]}"
        do
          item=$(echo $resource | awk -F":" '{print $1}')
          echo $item
        done  
    fi
fi    
