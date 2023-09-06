pipeline {
    agent any

    environment { 
        //use the BRANCH_NAME and Build_ID environment variables to tag the image versions
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

        stage ('Run Container'){
            steps {
               sh 'sudo docker run --name todo-${VERSION} -d -p8000:80 jendyjasper/todo:${VERSION}'
            }
        }

        stage ('Push to Docker Hub') {
            steps {
                //test if running container is reachable by checking if the status code is 200 and if it's reachable, 
                //push the image to docker hub and if not, print an error message
                sh '''#!/bin/bash
                    code=$(curl -s -o /dev/null -w "%{http_code}" 'http://50.19.178.214:8000/')
                    if [[ $code == "200" ]]; then
                        sudo docker push jendyjasper/todo:${VERSION}
                    else
                        echo "Website is unreachable, Please troubleshhot and fix the errors before pushing to docker hub"
                    fi
                '''
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