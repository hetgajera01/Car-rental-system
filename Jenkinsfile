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
                sh 'docker build -t hetgajera01/client ./client'
                sh 'docker build -t hetgajera01/server ./server'
            }
        }
    }
}
