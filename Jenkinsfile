pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kalpeshctrls/demo'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kalpeshctrls/helloworld-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }


          //Build stage to create .so file
        stage("Build") {
            steps{
                //Building project inside build container
                container("build"){
                    script{
			sh "apt-get install -y unzip"  
                        sh "wget https://sonar.arlocloud.com/static/cpp/build-wrapper-linux-x86.zip"
                        sh "unzip build-wrapper-linux-x86.zip"
                        sh "chmod +x build.sh"
                        sh "./build-wrapper-linux-x86/build-wrapper-linux-x86-64 --out-dir bw_output $WORKSPACE/build.sh"
                    }
                }
            }
        }


        stage('Unit Test') {
            steps {
                script {
                    echo 'Running unit tests...'
                    // Add test commands here
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}:${IMAGE_TAG}").run()
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push("${IMAGE_TAG}")
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    echo 'Stopping and removing containers...'
                    sh 'docker ps -q --filter ancestor=${IMAGE_NAME}:${IMAGE_TAG} | xargs -r docker stop'
                }
            }
        }
    }
}
