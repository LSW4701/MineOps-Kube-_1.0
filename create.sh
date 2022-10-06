#!/bin/bash
#: Title   :MineOps EKS create script
#: Date :2022-10-07
#: Author : LSW <pro_4701@naver.com>
#: Version  : 1.0
#: Description : : Hi

echo "============================================"
echo " create MineOps EKS create script  "
echo " module.cluster.aws_eks_cluster.this: Still creating... [10m50s elapsed] "
echo " EKS 리소스 생성과정에서 10분 이상 시간 소모 "
date +%Y-%m-%d

# aws sts get-caller-identity 

DIR="$( cd "$( dirname "$0" )" && pwd -P )"
echo $DIR

cd $DIR/env/terraform-aws-ubuntu/network ; terraform init
terraform apply -auto-approve

cd $DIR/env/terraform-eks/3-irsa ; terraform init
terraform apply -auto-approve

aws eks update-kubeconfig --region ap-northeast-2 --name apne2-mineops --alias apne2-mineops
# EKS연결을 위해선 ~/.kube/config 파일 내 클러스터 연결 정보를 추가해야함

irsa_arn="$(terraform output irsa_arn)"


###########################################################################################
cd $DIR/eks-irsa
echo $irsa_arn > arn_tmp
sed -i "s/role/role\\\/1" ./arn_tmp   # role -> role\/    이스케이프 전처리   

irsa_arn2= "$(cat ./arn_tmp)" 
sed -i "s/input/$irsa_arn2/1" ./rbac.yaml

# kubectl create namespace mineopsname
# lkubectl apply -k .



# aa="$(terraform output vpc1)"
# echo $aa >vpc1
# #

# sed -i "s/\///g" ./vpc1   #  이거는 / 지우기
# sed -i "s/vpc\///g" ./vpc1   #  vpc 지우기,  (모든 vpc )
# sed -i "s/vpc\///1" ./vpc1   #  vpc 맨 처음 지우기,  (모든 vpc )  

# sed -i "s/\//\\/g" ./vpc1  #  이거는 암됨
# sed -i "s/\//\\\\//g" ./vpc1   #  이거는 /를 \/ 로 바꾸기   \ -> \\\   / -> \/    인데  \\\\ 4개인식이라 안된다

# sed -i "s/vpc/vpc\\\/1" ./vpc1   # 1회만 변경 


# cc="$(cat vpc1)"  # 

# sed -i "s/input/$cc/1" ./rbac.yaml   # 복붙으로 들어간 arn이 또 복사되므로 g가 아닌 1 옵션 



# sed -i ''
# echo $LSW2

# sed -i "s/arn/$LSW2/g" ./rbac.yaml
# sed -i "s/arn/ddd/g" ./rbac.yaml
# sed -i "s/ars::/arn/g" ./rbac.yaml
# sed -i "s/arn/arn:aws:ec2:ap-northeast-2:959714228357:vpc/vpc-00ea7001e778b6049/g" ./rbac.yaml
# sed -i "s/arn/arn:aws:ec2:ap-northeast-2:959714228357:vpc\/vpc-00ea7001e778b6049/g" ./rbac.yaml



