pipeline {
    agent any

    environment { 
        //use the BRANCH_NAME and Build_ID environment var to tag the versions
        VERSION = "${env.BRANCH_NAME}-V1.${env.BUILD_ID}"
}

    stages {

        stage('Docker Build') {
            steps {
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