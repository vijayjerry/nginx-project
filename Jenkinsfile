pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = ''
                    def branchName = env.BRANCH_NAME

                    // Set Docker image tag based on branch
                    if (branchName == 'dev') {
                        imageTag = 'dev'
                    } else if (branchName == 'main') {
                        imageTag = 'prod'
                    } else {
                        error "Branch ${branchName} is not supported for Docker image builds."
                    }

                    // Build Docker image
                    sh 'docker build -t vijayjerry/nginx-image:${imageTag} .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                    def imageTag = ''

                    // Set Docker image tag based on branch
                    if (branchName == 'dev') {
                        imageTag = 'dev'
                    } else if (branchName == 'master') {
                        imageTag = 'prod'
                    } else {
                        error "Branch ${branchName} is not supported for Docker image pushes."
                    }

                    // Push Docker image to DockerHub
                    sh "docker push vijayjerry/nginx-image:${imageTag}"
                }
            }
        }
    }
    post {
        always {
            // Cleanup Docker images if necessary
            sh 'docker system prune -af'
        }
    }
}
