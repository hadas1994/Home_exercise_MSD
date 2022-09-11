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
                stage('Scan') {
            steps {
                // Install trivy
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

                // Scan all vuln levels
                sh 'mkdir -p reports'
                sh 'trivy filesystem --ignore-unfixed --vuln-type os,library --format template --template "@html.tpl" -o reports/nodjs-scan.html ./nodejs'
                publishHTML target : [
                    allowMissing: true,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'reports',
                    reportFiles: 'nodjs-scan.html',
                    reportName: 'Trivy Scan',
                    reportTitles: 'Trivy Scan'
                ]

                // Scan again and fail on CRITICAL vulns
                sh 'trivy filesystem --ignore-unfixed --vuln-type os,library --exit-code 1 --severity CRITICAL ./nodejs'

            }
    }
    post {
    always {
        bat "docker rmi $registry:$BUILD_NUMBER"
        }
    }
}