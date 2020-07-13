pipeline {
    agent any
    parameters {
        string(name: 'cluster_name', description: 'Name for the Kubernetes cluster')
    }
    stages {
        stage('Generate Infra') {
            steps {
                cd infra
                terraform init
                terraform plan -var="cluster_name=${params.cluster_name}"
                terraform apply -auto-approve -var="cluster_name=${params.cluster_name}"
            }
        }
        stage('Configure Cluster') {
            steps {
                ibmcloud ks cluster config --cluster ${params.cluster_name}
            }
        }
        stage('Deploy App') {
            steps {
                cd app/src
                node start.js
                cd ..
                chmod +x deploy.sh
                ./deploy.sh
            }
        }
    }
}
