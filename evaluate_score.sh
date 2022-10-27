#!/bin/bash

terraform init
#terraform validate
if [ $? -gt '0' ] 
then
  echo "[ERROR]: There is a syntax issue in your .tf file, please fix it and try again!"
  exit 1
fi  
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json

total=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score")
# echo $total
eip=$(./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score")
# echo $eip
sg=$(./opa eval --format pretty --data securitygroup.rego --input tfplan.json "data.terraform.analysis.score")
# echo $sg
ec2=$(./opa eval --format pretty --data ec2.rego --input tfplan.json "data.terraform.analysis.score")
# echo $ec2
s3=$(./opa eval --format pretty --data s3.rego --input tfplan.json "data.terraform.analysis.score")
# echo $s3
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")
# echo $autoscaling
under_limit=$(./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz")
# echo $under_limit
eip="eip:${eip}"
sg="sg:${sg}"
ec2="ec2:${ec2}"
s3="s3:${s3}"
autoscaling="autoscaling:${autoscaling}"
res_over_zero=($eip $sg $ec2 $s3 $autoscaling)
all_resources_arr=()
for res in "${res_over_zero[@]}"
do
  res_score=$(echo $res | awk -F":" '{print $2}')
#   echo $res_score
  if [ $res_score != 0 ]
  then
    all_resources_arr+=($res)
    # echo ${all_resources_arr[@]}    
  fi
done
# echo ${all_resources_arr[@]}
declare -A score_arr=([autoscaling]=30 [s3]=10 [ec2]=10 [eip]=10 [sg]=20)

if [[ ${under_limit} == 'true' ]]
then
    if [[ ${total} > 1 ]]
    then
        final_score=0
        for resource in "${all_resources_arr[@]}"
        do
          item=$(echo $resource | awk -F":" '{print $1}')
          score=$(echo $resource | awk -F":" '{print $2}')
          present=$(echo "${!score_arr[@]}" | sed 's/ /\n/g' | grep -o ${item})
          if [ ! -z ${present} ]
          then
            value=$(for i in "${!score_arr[@]}"; do echo "$i":"${score_arr[$i]}"; done | grep -i $item | awk -F":" '{print $2}')
            # if [ $score > 0 ]
            # then
            final_score=$((final_score + value))
                
            # fi
          fi      
        done  
    fi
fi   

function cleanup_terraform () {
    all_terraform_files=(.terraform .terraform.d .terraform.lock.hcl tfplan.binary tfplan.json)
    for fileORdir in "${all_terraform_files[@]}"
    do
        if [ -d $fileORdir ] || [ -f $fileORdir ];then rm -rf $fileORdir; fi
    done    
}

if [ "${final_score}" -gt "30" ]
then
    echo "Congrats! you passed the test, your score is '${final_score}'"
else
    echo "Sorry! you failed the test"
fi    
#echo $final_score
cleanup_terraform