pipeline {
    agent any

    environment { 
        //use the BRANCH_NAME and Build_ID environment variables to tag the image versions
        VERSION = "${env.BRANCH_NAME}-V1.${env.BUILD_ID}"
}

    stages {

        stage('Docker Compose') {
            steps {
                sh '''#!/bin/bash
                    sudo docker compose -f todo.yaml up -d
                '''
                
            }
        }

        stage('DB Migration') {
            steps {
                sh '''#!/bin/bash
                    sudo docker exec -it todo php artisan
                '''
                
            }
        }

        //run sudo docker exec -it todo php artisan migrate after successfull run by running it on the shell 
        stage ('Push to Docker Hub') {
            steps {
                //test if running container is reachable by checking if the status code is 200 and if it's reachable, 
                //push the image to docker hub and if not, print an error message
                sh '''#!/bin/bash
                    code=$(curl -s -o /dev/null -w "%{http_code}" 'http://54.146.33.56:5000/')
                    if [[ $code == "200" ]]; then
                        sudo docker push jendyjasper/todo:${VERSION}
                    else
                        echo "Website is unreachable, Please troubleshhot and fix the errors before pushing to docker hub"
                    fi
                '''
            }
        }
        
        stage ('Stop and Delete Container') { //can use docker-compuse too
            steps {
                sh '''#!/bin/bash
                sudo docker compose -f todo.yaml down
                '''
            }
        }

        stage ('Delete Image and Prune System') {
            steps{
                sh '''#!/bin/bash
                sudo docker rmi -f jendyjasper/todo:${VERSION}
                sudo docker system prune -f
                '''
            } 
        }

    }
}