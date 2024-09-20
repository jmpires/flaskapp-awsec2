
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



## Steps to run the container

### Access ec2 instance via ssh
chmod 400 path/to/your-key.pem (only necessary the first time)
ssh -i ~/.ssh/docker-demo.pem ec2-user@<your-ec2-public-dns>
mkdir dockerProject


## Creating Docker image support files
mkdir Src
cd Src

### requirements.txt
cat <<EOF > requirements.txt
Flask
EOF

### app.py
cat <<EOF > app.py
from flask import Flask


app = Flask(__name__)
@app.route('/')
def hello_docker():
    return '<h1> This is Akhilesh Mishra</h1><br><p>Thank you for reading. I hope you enjoyed it, follow for more content around Devops.</p> '

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
EOF

### Dockerfile
cat <<EOF > Dockerfile
# Use the official Python 3 base image from Docker Hub
FROM python:3

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the requirements.txt file from the src directory of the host to the /app directory inside the container
COPY Src/requirements.txt /app

# Install the Python dependencies listed in the requirements.txt file using pip
RUN pip install -r requirements.txt

# Copy all files from the src directory of the host to the /app directory inside the container
COPY Src/* /app

# Expose port 5000 to allow external connections to the docker application
EXPOSE 5000

# Define the default command to run when the container starts
# This command starts 
EOF
cd ~

## Creating GitHub Action workflow
cd ~
mkdir .github
mkdir .github/workflows
cd .github/workflows
nano build-deploy.yaml

cd ~


## Creating docker image & running container
docker build -t flask-app .
docker run -d -p 5000:5000 --name flask-app-container flask-app

## Check docker process
docker images
docker ps
docker logs flask-app-container

## Check access to app
curl http://localhost:5000
curl http://54.92.148.51:5000

## Others
docker stop your_container_name
docker rm your_container_name
docker rmi -f image_name_or_id



### TODO #########################################
Implement <arn:aws:iam::aws:policy/AdministratorAccess> for the new user
Implement the S3 bucket for the tfvars - my-backend-devops101-terraform

### ##############################################

