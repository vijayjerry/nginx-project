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
                        sh 'docker tag nginx-image:latest vijayjerry/prod:latest'
                        sh 'docker push vijayjerry/prod:latest'
                    }
                }
                stage('Build and Push Docker Image to dev Repo') {
                    when {
                        branch 'dev'
                    }
                    steps {
                        sh 'docker build -t nginx-image:latest .'
                        sh 'docker tag nginx-image:latest vijayjerry/dev:latest'
                        sh 'docker push vijayjerry/dev:latest'
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
