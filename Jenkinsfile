pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub' // Jenkins credentials ID for Docker Hub
        DOCKER_DEV_REPO = 'vijayjerry/dev-repo'
        DOCKER_PROD_REPO = 'vijayjerry/prod-repo'
        IMAGE_NAME = 'nginx-image'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the repository
                    checkout scm
                }
            }
        }
        
        stage('Build Docker Image') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    // Build the Docker image
                    def imageTag = "${env.IMAGE_NAME}:dev-${env.BUILD_ID}"
                    sh "docker build -t ${imageTag} ."
                    
                    // Login to Docker Hub
                    withDockerRegistry([credentialsId: "${env.DOCKER_CREDENTIALS_ID}", url: 'https://index.docker.io/v1/']) {
                        // Push the Docker image to the dev repository
                        sh "docker tag ${imageTag} ${env.DOCKER_DEV_REPO}:${env.BUILD_ID}"
                        sh "docker push ${env.DOCKER_DEV_REPO}:${env.BUILD_ID}"
                    }
                }
            }
        }
        
        stage('Merge to Master') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Build the Docker image
                    def imageTag = "${env.IMAGE_NAME}:prod-${env.BUILD_ID}"
                    sh "docker build -t ${imageTag} ."
                    
                    // Login to Docker Hub
                    withDockerRegistry([credentialsId: "${env.DOCKER_CREDENTIALS_ID}", url: 'https://index.docker.io/v1/']) {
                        // Push the Docker image to the prod repository
                        sh "docker tag ${imageTag} ${env.DOCKER_PROD_REPO}:${env.BUILD_ID}"
                        sh "docker push ${env.DOCKER_PROD_REPO}:${env.BUILD_ID}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
