pipeline{
    agent any

    stages{
        stage ('Sonarqube') {
            environment{
                SONAR_URL = "http://54.91.2.27:9000" 
            }
            steps {
                withCredentials([string(credentialsId: 'sonarqube', varibale: "SONAR_TOKEN")]) {
                    sh 'cd app-code/ && mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.host.url=${SONAR_URL}'
                }
            }
        }
    }
}