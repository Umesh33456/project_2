pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'  // change to your AWS region
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
