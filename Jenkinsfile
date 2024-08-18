pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the Git repository's main branch
                checkout([$class: 'GitSCM', 
                          branches: [[name: 'refs/heads/main']],
                          userRemoteConfigs: [[url: 'https://github.com/vijayjerry/nginx-project/build.git']]])
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Docker image details
                    def imageName = 'vijayjerry/prod'
                    def imageTag = 'latest'
                    
                    // Build the Docker image
                    docker.build("${imageName}:${imageTag}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    def imageName = 'vijayjerry:/prod'
                    def imageTag = 'latest'
                    
                    // Log in to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'your-dockerhub-credentials-id') {
                        // Push the Docker image to Docker Hub
                        docker.image("${imageName}:${imageTag}").push("${imageTag}")
                    }
                }
            }
        }
    }
