pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                script {
                    properties([pipelineTriggers([pollSCM('0,30 * * * *')])])
                }
                git 'https://github.com/hadas1994/Home_exercise_MSD.git'
            }
        }
        stage('Run hello_world') {
            steps {
                bat 'python hello_world'
            }
        }
    }
}