pipeline {
    
    agent any

    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Choose Terraform action: apply or destroy')
    }
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages{
        stage('Checkout'){
            steps{
                git branch:'main',url:'https://github.com/vijeshdevops89/TerraformCICD.git'
            }
        }
        
        stage('Terraform Version'){
            steps{
                sh 'terraform --version'
            }
        }
        
        stage('Terraform Init'){
            steps{
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan'){
            steps{
                sh 'terraform plan -out infra1.tfplan'
            }
        }
        
        stage('Terraform Action'){
            steps{
                script {
                    if ("${params.action}" == "apply") {
                        sh '''
                            echo "Creating the Infrastructure..."
                            terraform apply infra1.tfplan -auto-approve
                        '''
                    } else if ("${params.action}" == "destroy") {
                        sh '''
                            echo "Creating the Infrastructure..."
                            terraform destroy -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
