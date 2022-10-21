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

declare -A score_arr=([autoscaling]=30 [s3]=10 [ec2]=10 [eip]=10 [sg]=20)

if [[ ${under_limit} == 'true' ]]
then
    if [[ ${total} > 1 ]]
    then
        all_resources_arr=($eip $sg $ec2 $s3 $autoscaling)
        final_score=0
        for resource in "${all_resources_arr[@]}"
        do
          item=$(echo $resource | awk -F":" '{print $1}')
          score=$(echo $resource | awk -F":" '{print $2}')
          present=$(echo "${!score_arr[@]}" | sed 's/ /\n/g' | grep -o ${item})
          if [ ! -z ${present} ]
          then
            value=$(for i in "${!score_arr[@]}"; do echo "$i":"${score_arr[$i]}"; done | grep -i $item | awk -F":" '{print $2}')
            if [ $score > 0 ]
            then
                final_score=$((final_score + value))
                echo $final_score
            fi
          fi      
        done  
    fi
fi    