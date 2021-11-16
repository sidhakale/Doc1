pipeline {
environment {
        
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
                stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/sidhakale/Terra_Ansible.git"			    
                        
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
                    sh "cd ./project/Manavae-web-app-2/Java-Ansible && mvn clean package"
                }
            }   
        stage('jFrog artifactory'){
        steps{
                sh "cd ./project/Manavae-web-app-2/Java-Ansible && mvn deploy"
        }
        }
        stage('Terraform Plan') {
            steps {
                     withCredentials([vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat 'cd&cd terraform/Terra-Ansi-jFrog & terraform init -input=false'
                bat 'cd&cd terraform/Terra-Ansi-jFrog & terraform destroy -auto-approve'
                bat "cd&cd terraform/Terra-Ansi-jFrog & terraform plan -input=false -out tfplan"
                bat 'cd&cd terraform/Terra-Ansi-jFrog & terraform show -no-color tfplan > tfplan.txt'
                     }
            }
        }
       

        stage('Terraform Apply') {
            steps {
                    withCredentials([vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat "cd&cd terraform/Terra-Ansi-jFrog & terraform apply -input=false tfplan"
                    }
            }
        }

        
        }
   }
