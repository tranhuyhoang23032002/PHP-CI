pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        DOCKER_IMAGE = "my-php-app" // Tên Docker image của bạn
        MYSQL_CONTAINER = "mysql" // Tên container MySQL
        MYSQL_ROOT_PASSWORD = "rootpassword" // Mật khẩu root cho MySQL
        MYSQL_DATABASE = "mydb" // Tên database cho MySQL
        MYSQL_USER = "user" // User cho MySQL
        MYSQL_PASSWORD = "password" // Mật khẩu cho user
        SCANNER_HOME = tool 'sonar-scanner'
        APP_NAME = "demo"
        RELEASE = "1.0.0"
        DOCKER_USER = "hoangb2013534"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        SONAR_TOKEN = credentials("SonarQube-Token") // Thay đổi ở đây để lấy mã thông báo từ Jenkins
    }

    stages {
        stage('Prepare') {
            steps {
                script {
                    // Cleanup Docker containers and images from previous builds
                    sh '''
                    docker rm -f ${MYSQL_CONTAINER} || true
                    docker rmi -f ${DOCKER_IMAGE} || true
                    '''
                }
            }
        }

        stage('Build PHP Docker Image') {
            steps {
                script {
                    // Xây dựng Docker image cho PHP từ Dockerfile trong project PHP của bạn
                    sh '''
                    docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Run MySQL Container') {
            steps {
                script {
                    // Chạy MySQL container
                    sh '''
                    docker run -d --name ${MYSQL_CONTAINER} \
                    -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
                    -e MYSQL_DATABASE=${MYSQL_DATABASE} \
                    -e MYSQL_USER=${MYSQL_USER} \
                    -e MYSQL_PASSWORD=${MYSQL_PASSWORD} \
                    mysql:latest
                    '''
                }
            }
        }

        stage('Run PHP Container') {
            steps {
                script {
                    // Chạy PHP container và kết nối nó với MySQL container
                    sh '''
                    docker run -d --name php-app --link ${MYSQL_CONTAINER}:mysql ${DOCKER_IMAGE}
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup sau khi job kết thúc
                sh '''
                docker rm -f php-app || true
                docker rm -f ${MYSQL_CONTAINER} || true
                '''
            }
        }
    }
}
