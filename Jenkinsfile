pipeline {
    agent any

    environment { 
        //use the BRANCH_NAME and Build_ID environment variables to tag the image versions
        VERSION = "${env.BRANCH_NAME}-V1.${env.BUILD_ID}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t jendyjasper/todo:${VERSION} .'
                
            }
        }

        stage ('Run Container'){ //can use docker-compose too
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
        
        stage ('Stop container') { //can use docker-compuse too
            steps {
                sh 'sudo docker stop todo-${VERSION}'
            }
        }

        stage ('Delete containers'){
            steps {
                sh 'sudo docker rm -f todo-${VERSION}'
            }
        }

        stage ('Delete Image Locally') {
            steps{
                sh 'sudo docker rmi -f jendyjasper/todo:${VERSION}'
            } 
        }

        stage ('Docker System Prune') {
            steps {
                sh 'sudo docker system prune -f'
            }
        }
    }
}