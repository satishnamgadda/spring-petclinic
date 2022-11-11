pipeline {
    agent  { label 'JDK11' }
    stages {
        stage('vcs') {
            steps {     
                git branch: "REl_INT_1.0", url: 'https://github.com/satishnamgadda/spring-petclinic.git'
            }

        }
        stage('build') {
            steps {
                sh "mvn package"
            }
        }
        stage('artifacts') {
            steps {
            archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
            }
        }
        stage('test results') {
            steps {  
                 junit 'target/surefire-reports/*.xml'
            }
        }
    }
}        