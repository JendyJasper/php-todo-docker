pipeline {
    agent any

    environment { 
        VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh 'echo "for branch ${env.BRANCH_NAME}, ${env.GIT_COMMIT}, ${env.BUILD_ID}"'

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