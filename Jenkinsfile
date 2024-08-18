pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            parallel {
                stage('Build and Push Docker Image to prod Repo') {
                    when {
                        branch 'main'
                    }
                    steps {
                        sh 'docker build -t nginx-image:latest .'
                        sh 'docker tag nginx-image:latest my-repo/prod/nginx-image:latest'
                        sh 'docker push my-repo/prod/nginx-image:latest'
                    }
                }
                stage('Build and Push Docker Image to dev Repo') {
                    when {
                        branch 'dev'
                    }
                    steps {
                        sh 'docker build -t nginx-image:latest .'
                        sh 'docker tag nginx-image:latest my-repo/dev/nginx-image:latest'
                        sh 'docker push my-repo/dev/nginx-image:latest'
                    }
                }
            }
        }
        stage('Post Actions') {
            steps {
                sh 'docker system prune -af'
            }
        }
    }
}
