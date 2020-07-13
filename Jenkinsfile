pipeline {
    agent any
    parameters {
        string(name: 'cluster_name', description: 'Name for the Kubernetes cluster')
    }
    stages {
        stage('Generate Infra') {
            steps {
                cd infra
                sh 'terraform init'
                sh 'terraform plan -var="cluster_name=mycluster"'
                sh 'terraform apply -auto-approve -var="cluster_name=mycluster"'
            }
        }
        stage('Configure Cluster') {
            steps {
                ibmcloud ks cluster config --cluster ${params.cluster_name}
            }
        }
        stage('Deploy App') {
            steps {
                node app/src/start.js
            }
        }
    }
}
