pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build ') {
                    steps {
                        sh 'docker build -t nginx-image:latest .'
                        sh 'docker tag nginx-image:latest vijayjerry/prod:latest'
                        sh 'docker push vijayjerry/prod:latest'
                    }
                }
                stage('deploy') {
                    steps {
                        sh 'docker tag nginx-image:latest vijayjerry/dev:latest'
                        sh 'docker push vijayjerry/dev:latest'
                    }
                }
            }
        }
        
