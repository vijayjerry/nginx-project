pipeline {
    agent any
    environment {
        // Define your Docker Hub credentials and repository names
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        PROD_REPO = 'prod/nginx'
        DEV_REPO = 'dev/nginx'
    }
    stages {
        stage('Build and Push Production Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    // Checkout the main branch
                    checkout scm: [$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'your-git-repo-url']]]
                    
                    // Build Docker image
                    sh 'docker build -t ${PROD_REPO}:latest .'
                    
                    // Push Docker image to Docker Hub production repository
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker push ${PROD_REPO}:latest'
                    }
                }
            }
        }
        
        stage('Build and Push Development Image') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    // Checkout the dev branch
                    checkout scm: [$class: 'GitSCM', branches: [[name: 'dev']], userRemoteConfigs: [[url: 'your-git-repo-url']]]
                    
                    // Build Docker image
                    sh 'docker build -t ${DEV_REPO}:latest .'
                    
                    // Push Docker image to Docker Hub development repository
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker push ${DEV_REPO}:latest'
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean workspace after build
        }
    }
}
