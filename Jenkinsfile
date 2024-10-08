pipeline {
    agent any
    environment {
        // Define your Docker Hub credentials and repository names
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        PROD_REPO = 'vijayjerry/prod'
        DEV_REPO = 'vijayjerry/dev'
    }
    stages {
        stage('Build and Push Production Image') {
            steps {
                script {
                    // Checkout the main branch
                    checkout scm: [
                        $class: 'GitSCM',
                        branches: [[name: 'main']],
                        userRemoteConfigs: [[url: 'https://github.com/vijayjerry/nginx-project.git']]
                    ]
                    
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
            steps {
                script {
                    // Checkout the dev branch
                    checkout scm: [
                        $class: 'GitSCM',
                        branches: [[name: 'dev']],
                        userRemoteConfigs: [[url: 'https://github.com/vijayjerry/nginx-project.git']]
                    ]
                    
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
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            script {
                // Send an email notification if the pipeline fails
                emailext(
                    subject: "Application Deployment Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                    body: "The deployment of the application failed. The application is down. Please investigate.",
                    to: "vijayjerry01@gmail.com"
                )
            }
        }
    }
}

     
