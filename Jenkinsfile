pipeline {
    agent any
    
    environment {
        // Define Docker Hub credentials ID
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        // Define Docker Hub repository names
        PROD_REPO = 'vijayjerry/prod'
        DEV_REPO = 'vijayjerry/dev'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t nginx-image:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Determine the target repository based on branch
                    def targetRepo = env.BRANCH_NAME == 'main' ? PROD_REPO : DEV_REPO
                    def imageTag = "nginx-image:${env.BRANCH_NAME}"
                    
                    // Login to Docker Hub
                    sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                    
                    // Tag the Docker image with the repository
                    sh "docker tag nginx-image:latest vijayjerry/${targetRepo}:${env.BRANCH_NAME}"
                    
                    // Push the Docker image to the appropriate repository
                    sh "docker push ${targetRepo}:${env.BRANCH_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images after the build
            sh "docker system prune -af"
        }
    }
}
