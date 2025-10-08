pipeline {
    agent any

    environment {
    AWS_REGION = 'us-east-1'
    AWS_ACCESS_KEY_ID = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
}

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                echo 'Launching EC2 instance using Ansible...'
                sh '''
                    ansible-playbook create_ec2.yml --extra-vars "aws_region=${AWS_REGION}"
                '''
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
