pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "🔄 Checking out source code..."
                checkout scm  // Uses the branch Jenkins is already building
            }
        }

        stage('Run Ansible Playbook to Launch EC2') {
            steps {
                echo "🚀 Running Ansible Playbook to launch EC2..."
                withCredentials([
                    aws(credentialsId: 'aws-access-key',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        ansible-playbook create_ec2.yml \
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
