pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = 'vijayasree_credentials'
        DOCKER_IMAGE_NAME = 'vijayasree216/jenkinsdocker'
        DOCKER_IMAGE_TAG = "latest-${env.BUILD_NUMBER}"
        GIT_URL = 'https://github.com/Gopala-Polimetla/Demo.git'
    }
    
    stages {
         stage('Checkout') {
            steps {
                git url: "${GIT_URL}"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        sh "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }
        stage('Clean Up Local Image') {
            steps {
                script {
                    sh "docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        stage('Pull Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        def image = docker.image('${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}')
                        image.pull()
                }
            }
        }   
    }
}
