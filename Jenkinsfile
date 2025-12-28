(@Library('shared_library') _
pipeline {
    agent { label 'worker' } 
    parameters {
        string(name: 'client_docker_tag', defaultValue: '', description: 'Setting docker image for latest push')
        string(name: 'server_docker_tag', defaultValue: '', description: 'Setting docker image for latest push')
    }
    stages {
        stage('Code') {
            steps {
                git url:'https://github.com/hetgajera01/Car-rental-system.git', branch:'main'
            }
        }
        stage('build') {
            steps {
                script{
                        dir('client'){
                            docker_build("car-rental-client","${params.client_docker_tag}","hetgajera01")
                        }
                        dir('server'){
                            docker_build("car-rental-server","${params.server_docker_tag}","hetgajera01")
                    
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
