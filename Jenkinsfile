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
                sh 'ibmcloud ks cluster config --cluster mycluster'
            }
        }
        stage('Deploy App') {
            steps {
                sh 'node app/src/start.js'
            }
        }
    }
}
