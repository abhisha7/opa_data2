ls
history | grep -i "opa"
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano terraform.rego 
cp terraform.rego ec2.rego
cp terraform.rego s3.rego
cp terraform.rego autoscaling.rego
cp terraform.rego elasticip.rego
cp terraform.rego securitygroup.rego
ls
rm -rf terraform_files/
ls
rm -rf terraform-files
ls
ls -a
rm -rf .*
ls -a
git remote -v
rm -rf awscliv2.zip 
mv opa_policies_aws/ /tmp
ls
git remote add origin https://github.com/abhisha7/opa_data2.git
git init
git remote add origin https://github.com/abhisha7/opa_data2.git
git add .
git commit -m "changes"
git push origin master
ls
cd tmp
cd /tmp/
ls
cd opa_policies_aws/
ls
cd sample-tf-opa-policies/
ls
cd terraform_files/
ls
cd ..
pwd
cd ..
cd opa-terraform-example/
ls
cat main.tf 
cd ../../
cd /root/
ls
git pull
cat ec2.rego 
git checkout master
ls
ls -lrth
less securitygroup.rego 
git pull
git pull origin master
less securitygroup.rego 
ls -lrth
cat ec2.tf 
rm -f ec2.tf 
ls -lrth
terraform init
terraform plan --out tfplan.binary
nano securitygroup.rego 
nano main.tf 
terraform plan --out tfplan.binary
yum install awscli -y
ls
cd aws/
ls
./install 
./install --update
aws
aws configure
cd ..
ls
ls -a
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data securitygroup.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data ec2.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data s3.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score"
ls
ls -a
cd /tmp/
ls
git clone https://github.com/abhisha7/opa_data2.git
ls
cd opa_data2/
ls
git checkout master
ls
cd /root/
ls
ls -a
ouch .gitignore
touch .gitignore
nano .gitignore 
git add .
git commit -m "changes"
git pull
git push origin master
git pull origin master
git push origin master
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano main.tf 
terraform plan --out tfplan.binary
nano main.tf 
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano terraform.rego 
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano terraform.rego 
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano terraform.rego 
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
ls
rm -f tfplan.binary 
rm -f tfplan.json 
ls -a
rm -rf .terraform
rm -rf .terraform.d/
rm -rf .terraform.lock.hcl 
ls -a
terraform plan --out tfplan.binary
terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz"
git add .
git commit -m "changes"
git push origin master
git logon
git login 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
git login https://github.com/abhisha7/opa_data2.git
git pull
git pull origin master
less terraform.rego 
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
nano main.tf 
nano terraform.rego 
git add .
git commit -m "changes"
git push origin master
git config user.name "abhisha7"
git config user.name
#terraform plan --out tfplan.binary
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
/opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score"
ls
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.score"
/opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score"
nano elasticip.rego 
/opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score"
./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score"
eip=$(./opa eval --format pretty --data elasticip.rego --input tfplan.json "data.terraform.analysis.score")
echo $eip
git add .
git commit -m "changes"
git push origin master
./opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz"
terraform init
git pull origin master
chmod 777 evaluate_score.sh 
./evaluate_score.sh 
score_arr=( "autoscaling:30"         "s3:10"         "ec2:10"         "eip:10"         "sg:20" )
echo ${array[@]}
echo ${score_arr[@]}
echo ${score_arr[ec2]}
declare -A score_arr
score_arr["autoscaling"]="30"
score_arr["s3"]="10"
score_arr["ec2"]="10"
score_arr["eip"]="10"
score_arr["sg"]="20"
echo ${score_arr["sg"]}
echo ${score_arr[@]}
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score" | echo "autoscaling:")
echo $autoscaling
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")
echo $autoscaling
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score" | echo "autoscaling: --stdin")
echo $autoscaling
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")
autoscaling="autoscaling:${autoscaling}"
echo $autoscaling
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
autoscaling=$(./opa eval --format pretty --data autoscaling.rego --input tfplan.json "data.terraform.analysis.score")
echo $s3
echo $sg
git pull origin master
git add .
git commit -m "changes"
git pull origin master
git push origin master
git pull
git pull origin master
./evaluate_score.sh 
git add .
git commit -m "changes"
git pull origin master
git push origin master
echo ${score_arr[@]}
echo ${score_arr[keys]}
score_arr=( "autoscaling:30"             "s3:10"             "ec2:10"             "eip:10"             "sg:20" )
echo ${score_arr[@]}
echo ${score_arr[@]} | grep -i ec2)
echo ${score_arr[@]} | grep -i ec2
echo ${score_arr[@]} | grep -o ec2
echo ${score_arr[@]} | grep -o ec2:*
echo ${score_arr[@]} | grep -w ec2:*
echo ${score_arr[@]} | grep -o ec2.*
echo ${score_arr[@]} | grep -o ec2:.*
echo ${score_arr[@]} | grep -o ec2:*
echo ${score_arr[@]} | grep -o ec2:?
echo ${score_arr[@]} | grep -o ec2:??
echo ${score_arr[keys]}
echo ${score_arr[@
echo ${score_arr[@]}
echo ${score_arr[@]} | sed 's/ /\n/g'
echo ${score_arr[@]} | sed 's/ /\n/g' | grep -i ec2
echo ${score_arr[@]} | sed 's/ /\n/g' | grep -i ec2 | awk -F":" '[print $2]'
echo ${score_arr[@]} | sed 's/ /\n/g' | grep -i ec2 | awk -F":" '[print $2}'
echo ${score_arr[@]} | sed 's/ /\n/g' | grep -i ec2 | awk -F":" '{print $2}'
git pull origin master
./evaluate_score.sh 
git add .
git commit -m "changes"
git push origin master
