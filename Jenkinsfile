@Library('shared_library') _
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
                script{
                    withCredentials([usernamePassword(
                    credentialsId:"Dockerhub",
                    usernameVariable:"user", 
                    passwordVariable:"pass")]){
                    docker_build{"car-rental-client",${params.client_docker_tag},"${env.user"}}
                    docker_build{"car-rental-server",${params.server_docker_tag},"${env.user"}}
                    }
                }
            }
        }
     /*   stage("Push To DockerHub"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:"Dockerhub",
                    usernameVariable:"user", 
                    passwordVariable:"pass")]){
                sh "docker login -u ${env.user} -p ${env.pass}"
                sh "docker push ${env.user}/client:latest"
                sh "docker push ${env.user}/server:latest"
                }
            }
        }*/
    }
}
