pipeline {
    agent any

    environment { 
        VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t todo:${env.BRANCH_NAME}-${VERSION} .'
                
            }
        }

        stage('Change tagname') {
            steps {
                sh 'sudo docker tag todo:${env.BRANCH_NAME}-${VERSION} jendyjasper/todo:${env.BRANCH_NAME}-${VERSION}'
            }        
        }

        stage ('Push to Docker Hub') {
            steps {
                sh 'sudo docker push jendyjasper/todo:${env.BRANCH_NAME}-${VERSION}'
            }
        }
        
        stage ('Delete Image Locally') {
            steps{
                sh 'sudo docker rmi jendyjasper/todo:${env.BRANCH_NAME}-${VERSION}'
                sh 'sudo docker rmi todo:${env.BRANCH_NAME}-${VERSION}'
            } 
        }
    }
}