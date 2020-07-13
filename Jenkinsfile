pipeline {
    agent any
    parameters {
        string(name: 'cluster_name', description: 'Name for the Kubernetes cluster')
    }
    stages {
        stage('Generate Infra') {
            steps {
                sh 'cd infra'
                sh 'ls'
                sh 'terraform init'
                sh 'terraform plan -var="cluster_name=${params.cluster_name}"'
                sh 'terraform apply -auto-approve -var="cluster_name=${params.cluster_name}"'
            }
        }
        stage('Configure Cluster') {
            steps {
                sh 'ibmcloud ks cluster config --cluster ${params.cluster_name}'
            }
        }
        stage('Deploy App') {
            steps {
                sh 'node app/src/start.js'
            }
        }
    }
}
