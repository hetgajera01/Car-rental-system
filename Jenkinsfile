pipeline {
    agent { label 'worker' }

    stages {
        stage('Code') {
            steps {
                git url:'https://github.com/hetgajera01/Car-rental-system.git', branch:'main'
            }
        }
        stage('build') {
            steps {
                sh 'docker build -t client ./client'
                sh 'docker build -t server ./server'
            }
        }
        stage("Push To DockerHub"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:"Dockerhub",
                    usernameVariable:"user", 
                    passwordVariable:"pass")]){
                sh "docker login -u ${env.user} -p ${env.pass}"
                sh "docker image tag client ${env.user}/client:latest"
                sh "docker image tag server ${env.user}/server:latest"
                sh "docker push ${env.user}/client:latest"
                sh "docker push ${env.user}/server:latest"
                }
            }
        }
    }
}
