pipeline {
    agent any
    environment {
    registry = "hadas1994/my-repo"
    registryCredential = 'docker_hub'
    dockerImage = ''
    NEXT_VERSION = nextVersion(buildMetadata: "$env.BUILD_NUMBER")
    }
    stages{
        stage('checkout') {
            steps {
                git 'https://github.com/hadas1994/Home_exercise_MSD.git'
            }
        }
        stage('build and push image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    docker.withRegistry('', registryCredential) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('set version') {
            steps {
                bat "echo IMAGE_TAG=${BUILD_NUMBER} > .env"
            }
        }
        stage('Hello') {
            steps {
                echo "next version = ${NEXT_VERSION}"
            }
        }
    }
    post {
    always {
        bat "docker rmi $registry:$BUILD_NUMBER"
        }
    }
}