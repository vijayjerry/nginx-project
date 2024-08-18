pipeline {
    agent any

    environment {
        // Define Docker registry URLs and credentials
        DEV_REGISTRY = 'https://hub.docker.com/repository/docker/vijayjerry/dev/general'
        PROD_REGISTRY = 'https://hub.docker.com/repository/docker/vijayjerry/prod/general'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your version control system
                git 'https://your-repo-url.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build('nginx-app')
                }
            }
        }

        stage('Push to Development Registry') {
            steps {
                script {
                    // Push Docker image to development registry
                    docker.withRegistry("${DEV_REGISTRY}", "${DOCKER_CREDENTIALS_ID}") {
                        docker.image('nginx-app').push('latest')
                    }
                }
            }
        }

        stage('Push to Production Registry') {
            steps {
                script {
                    // Push Docker image to production registry
                    docker.withRegistry("${PROD_REGISTRY}", "${DOCKER_CREDENTIALS_ID}") {
                        docker.image('nginx-app').push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images after the build
            script {
                docker.image('nginx-app').remove()
            }
        }
    }
}
