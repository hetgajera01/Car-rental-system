@Library('shared_library') _
pipeline {
    agent { label 'worker' } 
    environment {
        DOCKER_CREDS = credentials('Dockerhub')
    }
    parameters {
        string(name: 'client_docker_tag', defaultValue: '', description: 'Setting docker image for latest push')
        string(name: 'server_docker_tag', defaultValue: '', description: 'Setting docker image for latest push')
    }
    stages {
        stage("Validate Parameters") {
            steps {
                script {
                    if (params.client_docker_tag == '' || params.server_docker_tag == '') {
                        error("client_docker_tag and server_docker_tag must be provided.")
                    }
                }
            }
        }
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
                            docker_build("car-rental-client","${params.client_docker_tag}","${env.DOCKER_CREDS_USR}")
                        }
                        dir('server'){
                            docker_build("car-rental-server","${params.server_docker_tag}","${env.DOCKER_CREDS_USR}")
                    
                        }
                }
            }
        }
        stage("Push To DockerHub"){
            steps{
                script{
                    docker_push("car-rental-client","${params.client_docker_tag}")
                    docker_push("car-rental-server","${params.client_docker_tag}")
                }
            }
        }
    }
}
