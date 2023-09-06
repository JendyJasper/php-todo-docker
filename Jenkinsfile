pipeline {
    agent any

    environment { 
        //use the BRANCH_NAME and Build_ID environment variables to tag the image versions
        VERSION = "${env.BRANCH_NAME}-V1.${env.BUILD_ID}"
}

    stages {

        stage('Docker Build') {
            steps {
                sh '''code=$(curl -s -o /dev/null -w "%{http_code}" 'http://50.19.178.214/ufh')
                    if [[ $code == 200 ]]; then
                        echo "correct"
                    else
                        echo "incorrect"
                        # other actions
                    fi
                '''
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