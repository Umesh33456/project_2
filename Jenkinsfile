pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Umesh33456/project_2.git'
            }
        }

        stage('Setup AWS Credentials') {
            steps {
                withCredentials([
                    aws(credentialsId: 'aws-access-key',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        echo "AWS credentials configured."
                        aws sts get-caller-identity
                    '''
                }
            }
        }

        stage('Install Ansible') {
            steps {
                sh '''
                    sudo yum update -y
                    sudo yum install -y python3-pip
                    pip3 install ansible boto3 botocore amazon.aws
                    ansible-galaxy collection install amazon.aws
                    ansible --version
                '''
            }
        }

        stage('Run Ansible Playbook to Launch EC2') {
            steps {
                withCredentials([
                    aws(credentialsId: 'aws-access-key',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        echo "Running EC2 provisioning playbook..."
                        ansible-playbook ansible/create_ec2.yml \
                            -e "aws_access_key=${AWS_ACCESS_KEY_ID}" \
                            -e "aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ EC2 instance created successfully!'
        }
        failure {
            echo '❌ Jenkins job failed. Check logs for details.'
        }
    }
}
