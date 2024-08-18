pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub' 
        GITHUB_CREDENTIALS_ID = 'github' 
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the appropriate branch based on the BRANCH_NAME environment variable
                    git branch: "${env.BRANCH_NAME}", url: 'https://github.com/vijayjerry/nginx-project.git', credentialsId: GITHUB_CREDENTIALS_ID
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "nginx-image:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                    docker.build(imagename)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def imageName = "nginx-image:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                    def repo = env.BRANCH_NAME == 'main' ? 'prod-repo' : 'dev-repo'
                    def fullImageName = "${repo}/${imagename}"

                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image(imagename).push(imagename)
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { return env.BRANCH_NAME == 'dev' }
            }
            steps {
                script {
                    def imageName = "nginx-image:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                    def fullImageName = "dev-repo/${imagename}"

                }
            }
        }
    }

    post {
        success {
            echo "Build and push successful."
        }
        failure {
            echo "Build failed."
        }
    }
}
