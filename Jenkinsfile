pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub'  
        DOCKER_IMAGE_NAME = 'vijayjerry/prod'  
        DOCKER_TAG = 'latest'  
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code from version control
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_TAG}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_CREDENTIALS_ID}") {
                        // Push the Docker image to Docker Hub
                        docker.image("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_TAG}").push("${env.DOCKER_TAG}")
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Clean up any resources if needed
        }
    }
}
