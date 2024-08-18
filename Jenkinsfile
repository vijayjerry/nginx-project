pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub' 
        DEV_REPO = 'vijayjerry/dev' 
        PROD_REPO = 'vijayjerry/prod' 
        IMAGE_NAME = 'nginx-image'  
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker build -t ("${IMAGE_NAME}:prod") .
                }
            }
        }

        stage('Push Docker Image to Dev Repo') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker push vijayjerry ("${IMAGE_NAME}:prod"):('latest')
                    }
                }
            }
        }

        stage('Build and Push Docker Image to Prod Repo') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    docker build -t ("${IMAGE_NAME}:dev") .
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                         docker push vijayjerry ("${IMAGE_NAME}:dev"):('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images and containers if necessary
            sh 'docker system prune -af'
        }
    }
}
