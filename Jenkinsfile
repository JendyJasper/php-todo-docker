pipeline {
    agent any

    environment { 
        VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh 'echo ${env.BRANCH_NAME}'
                sh 'echo ${env.BUILD_ID}'
                sh 'echo ${env.GIT_COMMIT}'

                sh 'sudo docker build -t todo:${VERSION} .'
                
            }
        }

        stage('Change tagname') {
            steps {
                sh 'sudo docker tag todo:${VERSION} jendyjasper/todo:${VERSION}'
            }        
        }

        stage ('Push to Docker Hub') {
            steps {
                sh 'sudo docker push jendyjasper/todo:${VERSION}'
            }
        }
        
        stage ('Delete Image Locally') {
            steps{
                sh 'sudo docker rmi jendyjasper/todo:${VERSION}'
            sh 'sudo docker rmi todo:${VERSION}'
            } 
        }
    }
}