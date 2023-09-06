pipeline {
    agent any

    environment { 
        VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
        BANCH = "${env.BRANCH_NAME}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t todo:${BRANCH_NAME}-${VERSION} .'
                
            }
        }

        stage('Change tagname') {
            steps {
                sh 'sudo docker tag todo:${BRANCH_NAME}-${VERSION} jendyjasper/todo:${BRANCH_NAME}-${VERSION}'
            }        
        }

        stage ('Push to Docker Hub') {
            steps {
                sh 'sudo docker push jendyjasper/todo:${BRANCH_NAME}-${VERSION}'
            }
        }
        
        stage ('Delete Image Locally') {
            steps{
                sh 'sudo docker rmi jendyjasper/todo:${BRANCH_NAME}-${VERSION}'
                sh 'sudo docker rmi todo:${BRANCH_NAME}-${VERSION}'
            } 
        }
    }
}