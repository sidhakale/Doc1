pipeline {
environment {
        
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
                stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/sidhakale/Doc1.git"			    
                        
                    }
                }
            }      
        
         stage('Maven - WAR creation') {
            steps {
                    sh '''#!/bin/bash
                 rm -rf ./project
                 mkdir project
                 git -C ./project clone https://github.com/sidhakale/Manavae-web-app.git             
         '''                 
                    sh "cd ./project/Manavae-web-app/Java-Ansible && mvn clean package"
                }
            }   
        stage('jFrog artifactory'){
        steps{
                sh "cd ./project/Manavae-web-app/Java-Ansible && mvn deploy"
        }
        }
        stage('Terraform Plan') {
            steps {
                     withCredentials([vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat 'cd&cd terraform/Doc1 & terraform init -input=false'
                bat 'cd&cd terraform/Doc1 & terraform destroy -auto-approve'
                bat "cd&cd terraform/Doc1 & terraform plan -input=false -out tfplan"
                bat 'cd&cd terraform/Doc1 & terraform show -no-color tfplan > tfplan.txt'
                     }
            }
        }
       

        stage('Terraform Apply') {
            steps {
                    withCredentials([vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat "cd&cd terraform/Doc1 & terraform apply -input=false tfplan"
                    }
            }
        }

        
        }
   }
