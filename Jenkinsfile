pipeline {
    agent any
    parameters {
        string(name: 'api_key', description: 'API Key to connect to IBM Cloud account')
        string(name: 'region', description: 'Target Region')
        string(name: 'cluster_name', description: 'Name for the Kubernetes cluster')
    }
    stages {
        stage('Generate Infra') {
            steps {
                dir("infra") {
                   sh 'terraform init'
                   sh 'terraform plan -var="cluster_name=$cluster_name" -var="ibmcloud_api_key=$api_key"'
                   sh 'terraform apply -auto-approve -var="cluster_name=$cluster_name" -var="ibmcloud_api_key=$api_key"'
                }
            }
        }
        stage('Configure Cluster') {
            steps {
                sh 'ibmcloud login --apikey $api_key -r $region'
                sh 'ibmcloud ks cluster config --cluster $cluster_name'
            }
        }
        stage('Deploy App') {
            steps {
                dir("app") {
                   sh 'node src/start.js'
                   sh 'chmod +x deploy.sh'
                   sh './deploy.sh'
                }
            }
        }
    }
}
