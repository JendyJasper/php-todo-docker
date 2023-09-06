pipeline {
    agent any

    parameters {
        string(name: 'version', defaultValue: '1.0', description: 'This is the version number')
    }

    stages {

        stage('Docker Build') {
            steps {
                sh 'sudo -S docker build -t darey-todo:${version} .'
            }
        }

    }
}