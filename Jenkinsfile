pipeline{
    agent any

    stages{
        stage ('Sonarqube') {
            environment{
                SONAR_URL = "http://98.81.173.139:9000" 
            }
            steps {
                withCredentials([string(credentialsId: 'sonarqube', variable: "SONAR_TOKEN")]) {
                    sh 'cd app-code/ && mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.host.url=${SONAR_URL}'
                }
            }
        }

        stage ('Docker build and push') {
            environment {
                DOCKER_IMAGE = "rganesh7/helloworld:${BUILD_NUMBER}"
                DOCKER_CRED = credentials('docker-cred')
            }
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                    def dockerImage = docker.image("${DOCKER_IMAGE}")
                    docker.withRegistry('https://index.docker.io/v1/', "docker-cred")
                        dockerImage.push()
                }
            }
        }

        stage ('Update deployment file') {
            environment {
                gitreponame = "Argo-CD"
                gitusername = "rganesh29"
            }
            steps {
                withCredentials([string(credentialsId: 'GitHub', variable: "GITHUB_TOKEN")]) {
                    sh """
                        git config user.email "ganeshr2903@gmail.com"
                        git config user.name "rganesh29"
                        BUILD_NUMBER = ${BUILD_NUMBER}
                        sed -i "s/helloworld:v0.*/helloworld:v0.${BUILD_NUMBER}/g" /Argo-CD/app.yaml
                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://${GITHUB_TOKEN}@github.com/${gitusername}/${gitreponame} HEAD:main
                    """
                }
            }
        }
    }
}