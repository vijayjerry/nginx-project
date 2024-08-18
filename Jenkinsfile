pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'main'
            }
            stage('Build and Push Docker Image to prod Repo') {
    steps {
        // Steps should not contain other stages or steps blocks
        sh 'docker build -t nginx-image:latest .'
        sh 'docker tag nginx-image:latest my-repo/prod/nginx-image:latest'
        sh 'docker push my-repo/prod/nginx-image:latest'
    }
}
    stage('Build Docker Image') {
            when {
                branch 'dev'
            }    
        stage('Build and Push Docker Image to dev Repo') {
    steps {
        // All steps should be included within a single 'steps' block
        sh 'docker build -t nginx-image:latest .'
        sh 'docker tag nginx-image:latest my-repo/dev/nginx-image:latest'
        sh 'docker push my-repo/dev/nginx-image:latest'
    }
}
        stage('Post Actions') {
            steps {
                sh 'docker system prune -af'
            }
        }
    
