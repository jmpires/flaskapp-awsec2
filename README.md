
# Continuously Build & Deploy Python Web App On AWS With GitHub Action

## References
https://towardsaws.com/continuously-build-deploy-python-web-app-on-aws-with-github-action-a9de1421898c
https://github.com/akhileshmishrabiz/flaskapp-awsec2

## Pre-steps
Create an SSH key pair 4 the current user or use an existing one
!!!(pay attention to change the name of the ssh key inside the code)!!!

Create the repository secrets in GitHub 
!!!(switch to the given repo first)!!!
- Access Settings\Actions\Repository Secrets\New repository secret
The needed secrets are the following ones:
AWS_ACCOUNT_ID - aws sts get-caller-identity --query Account --output text
AWS_ACCESS_KEY_ID - inside the sshKeyPair file
AWS_SECRET_ACCESS_KEY - inside the sshKeyPair file
SSH_PRIVATE_KEY - inside the .pem file

Ensure that the current user have <administratorAccess> policy attached
Can choose a profile that have that policy attached and then provide that acces to a specific user

- Set the profile to power user
aws configure --profile default (is my default user with administrative rights)

- Set the policies 4 AdministratorAccess to another user
aws iam attach-user-policy --user-name <user-name> --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam list-attached-user-policies --user-name <user-name> 

- Build the S3 bucket that will support the tfvars
aws s3api create-bucket --bucket <bucket-name> --region us-east-1
aws s3api list-buckets


### Access ec2 instance via ssh
chmod 400 path/to/your-key.pem (only necessary the first time)
ssh -i ~/.ssh/docker-demo.pem ec2-user@<your-ec2-public-dns>

## Check docker process
docker images
docker ps
docker logs flask-app

## Others
docker stop your_container_name
docker rm your_container_name
docker rmi -f image_name_or_id


### TODO #########################################
Implement the S3 bucket for the tfvars - my-backend-devops101-terraform

### ##############################################

