pipeline {
    agent any

    parameters {
        string(name: 'version', defaultValue: '1.0', description: 'This is the version number')
    }

    stages {

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t todo:${version} .'
            }
        }

        stage('Change tagname') {
            steps {
                sh 'sudo docker tag todo:${version} jendyjasper/todo:${version}'
            }        
        }

        stage ('Push to Docker Hub') {
            steps {
                sh 'sudo docker push jendyjasper/todo:${version}'
            }
        }
        
        stage ('Delete Image Locally') {
            steps{
                sh 'sudo docker rmi jendyjasper/todo:${version}'
            sh 'sudo docker rmi todo:${version}'
            } 
        }
    }
}