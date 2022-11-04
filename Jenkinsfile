def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                echo 'Cloning project code base'
                git branch: 'main', url: 'https://github.com/Vstar007/Airbnb-infra-2.git'
            }
        }
        
        stage('Verify Terraform Version') {
            steps {
                echo 'Veryfing the terraform version'
                sh 'terraform --version'
            }
            
        }
        
        stage('Terraform Initialization') {
            steps {
                echo 'Initializing terraform'
                sh 'terraform init'
            }
            
        }
        
        stage('Terraform Validate') {
            steps {
                echo 'Terraform Validation'
                sh 'terraform validate'
            }
            
        }
        
        stage('Terraform Plan') {
            steps {
                echo 'Plan for dry run'
                sh 'terraform plan'
            }
            
        }
        
        stage('Checkov scan') {
            steps {
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS_79
                """
            }
            
        }
        
        stage('Manual Approval') {
            steps {
                input 'Approval required for deployment'
            }
            
        }
        
        stage('Terraform Apply') {
            steps {
                echo 'Deploying the resource'
                sh 'sudo terraform apply --auto-approve'
            }
            
        }
    }
    
          post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#vstar-cicd-alerts', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}

