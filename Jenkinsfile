pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withCredentials([aws(credentialsId: 'aws-access-key', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        ansible-playbook create_ec2.yml \
                        --extra-vars "aws_region=${AWS_REGION} aws_access_key=${AWS_ACCESS_KEY_ID} aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
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
            echo '❌ EC2 creation failed. Check Jenkins logs.'
        }
    }
}
