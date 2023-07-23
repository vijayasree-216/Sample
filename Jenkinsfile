pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = 'vijayasree_credentials'
        DOCKER_IMAGE_NAME = 'vijayasree216/jenkinsdocker'
        DOCKER_IMAGE_TAG = "latest-${env.BUILD_NUMBER}"
        DOCKER_CONTAINER_NAME ='mycontainer'
        GIT_URL = 'https://github.com/vijayasree-216/Sample.git'
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
        }
        stage('Pulling docker image') {
            steps {
                script {
                    sh "docker pull ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" 
                }
            }
        }
        stage('Creating a docker container') {
            steps {
                script {
                    sh "docker run --name ${DOCKER_CONTAINER_NAME} -itd 3000:3000 ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        } 
    }
}
