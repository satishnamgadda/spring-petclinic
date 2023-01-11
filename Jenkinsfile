pipeline {
    agent { label 'JDK11'} 
    stages {
        stage('checkout') {
            steps { 
                mail subject: 'build started',
                     body: 'build started',
                     to: 'qtdevops@gmail.com'   
                git branch: "main", url: 'https://github.com/satishnamgadda/spring-petclinic.git'
            }

        }
         stage('artifactory configuaration') {
             steps {
                rtMavenDeployer(
                   id : "MAVEN_DEPLOYER",
                   releaseRepo : "libs-release-local",
                   snapshotRepo : "libs-snapshot-local",
                   serverId : "JFROG_ID"
                )

           }
        }
        // stage('Exec Maven') {
        //    steps {
        //         rtMavenRun(
        //             pom : "pom.xml",
        //             goals : "clean install",
        //             tool : "mvn",
        //             deployerId : "MAVEN_DEPLOYER"
                    
        //         )
          
        //     }
        // }
        stage('sonar scan') {
            steps {
               withSonarQubeEnv('SONAR_SH') {
                    sh script: 'mvn clean package sonar:sonar'
               }
            }
        }
        // create webhooks: <jenkins_url:8080/sonarqube-webhook/>//
        stage("Quality Gate") {
            steps {
              timeout(time: 20, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        stage('publish build info') {
            steps {
               rtPublishBuildInfo(
                serverId : "JFROG_ID"
              )
           }
        }
        stage('build the docker image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'JFROG', passwordVariable: 'JFROG_PWD', usernameVariable: 'JFROG_NAME')]) {
                sh "docker login sonarnew.jfrog.io -u ${JFROG_NAME}  -p ${JFROG_PWD}"
                sh 'docker image build -t sonarnew.jfrog.io/spc-docker/spc:1.9 .'
                

            }
        }
        }
        stage('push the image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'JFROG', passwordVariable: 'JFROG_PWD', usernameVariable: 'JFROG_NAME')]) {
                sh "docker login sonarnew.jfrog.io -u ${JFROG_NAME}  -p ${JFROG_PWD}"
                sh 'docker image push sonarnew.jfrog.io/spc-docker/spc:1.9 '

            }
                
            }
        }
        
        }
    }
 

