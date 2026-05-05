pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-app"
    }

    stages {

        stage('Build Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${env.BRANCH_NAME} ."
            }
        }

        stage('Deploy Dev') {
            when { branch 'dev' }
            steps {
                sh '''
                    docker stop devops-dev || true
                    docker rm devops-dev || true
                    docker run -d --name devops-dev -p 5001:5000 \
                    -e APP_ENV=dev devops-app:dev
                '''
            }
        }

        stage('Deploy Staging') {
            when { branch 'staging' }
            steps {
                sh '''
                    docker stop devops-staging || true
                    docker rm devops-staging || true
                    docker run -d --name devops-staging -p 5002:5000 \
                    -e APP_ENV=staging devops-app:staging
                '''
            }
        }

        stage('Deploy Production') {
            when { branch 'main' }
            steps {
                sh '''
                    docker stop devops-prod || true
                    docker rm devops-prod || true
                    docker run -d --name devops-prod -p 5000:5000 \
                    -e APP_ENV=prod devops-app:main
                '''
            }
        }
    }
}
