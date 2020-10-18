#!/bin/bash

echo "Please type Website's doomain name.(ex.www.hogehoge.com)"

read CNAME

echo "Please type root domain name (ex.hogehoge.com)"

read ROOTDOMAIN

echo "Please type your AWS profile name"

read AWSPROFILE

echo "Please type your stage's name (ex, live/staging/preview)"

read STAGE

echo "Please type the IP address from which you want to exclude Basicauth."

read ALLOWIP

echo "Please type your Basicauth's ID"

read BASICID

echo "Please type your Basicauth's Password"

read BASICPW

sed -i 's/profile \= "defaultprofile"/profile \= "$AWSPROFILE"/g' terraform/lambdaedge.tf 

sed -i "s/ALLOWIP/$ALLOWIP/g" terraform/lambda/basic_auth/index.js 

sed -i "s/hoge/$AWSPROFILE/g" terraform/main.tf 


sed -i -e "s/BASICUSER/$BASICID/g" -e "s/BASICPASS/$BASICPW/g" terraform/lambda/basic_auth/index.js  

cat  << EOF > terraform/variables.tf

# ---------------
# variables.tf
# ---------------

variable "site_domain" {
  default = "$CNAME"
}

variable "root_domain" {
  default = "$ROOTDOMAIN"
}

variable "bucket_name" {
  default = "$CNAME"
}

variable "logbucket_name" {
  default = "$CNAME-cflog"
}

variable "stage" {
  default = "$STAGE"
}

EOF

cat   << EOF > terraform/index.html

<html>
	<head>
		<title>$CNAME</title>
	</head>

	<body>
		$CNAME <br>
	    `date "+%Y%m%d-%H%M%S"`
	</body>
</html>

EOF


cd terraform ; terraform init
terraform plan