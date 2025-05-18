pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url 'https://github.com/kalpeshctrls/helloworld-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("helloworld-java:latest")
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                script {
                    docker.image("helloworld-java:latest").run()
                }
            }
        }
    }
}
