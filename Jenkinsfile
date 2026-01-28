pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'git@github.com:RahulWakde/EKS-terraform-nginx.git',
            credentialsId: 'github-ssh'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Configure kubeconfig') {
      steps {
        sh '''
        aws eks update-kubeconfig \
        --region ap-south-1 \
        --name eks-demo
        '''
      }
    }

    stage('Deploy Nginx') {
      steps {
        sh '''
        kubectl apply -f nginx/deployment.yaml
        kubectl apply -f nginx/service.yaml
        '''
      }
    }
  }
}

