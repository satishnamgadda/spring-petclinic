pipeline {
    agent none
    stages {
        stage('checkout') {
            agent { label 'JDK11'} 
            steps { 
                mail subject: 'build started',
                     body: 'build started',
                     to: 'qtdevops@gmail.com'   
                git branch: "main", url: 'https://github.com/satishnamgadda/spring-petclinic.git'
            }

        }
         stage('artifactory configuaration') {
            agent { label 'JDK11'} 
             steps {
                rtMavenDeployer(
                   id : "MAVEN_DEPLOYER",
                   releaseRepo : "default-libs-release",
                   snapshotRepo : "default-libs-snapshot",
                   serverId : "JFROG_ID"
                )

           }
        }
        stage('Exec Maven') {
            agent { label 'JDK11'} 
           steps {
                rtMavenRun(
                    pom : "pom.xml",
                    goals : "clean install",
                    tool : "mvn",
                    deployerId : "MAVEN_DEPLOYER"
                    
                )
          
            }
        }
        stage('sonar scan') {
            agent { label 'JDK11'} 
            steps {
               withSonarQubeEnv('SONAR_SH') {
                    sh script: 'mvn clean package sonar:sonar'
               }
            }
        }
        // create webhooks: <jenkins_url:8080/sonarqube-webhook/>
        stage('Quality Gate') {
            agent { label 'JDK11'} 
            steps {
              timeout(time: 20, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        stage('publish build info') {
            agent { label 'JDK11'} 
            steps {
               rtPublishBuildInfo(
                serverId : "JFROG_ID"
              )
           }
        }
        stage('build the docker image') {
            agent { label 'JDK11'} 
            steps {
                withCredentials([usernamePassword(credentialsId: 'JFROG', passwordVariable: 'JFROG_PWD', usernameVariable: 'JFROG_NAME')]) {
                sh "docker login spcnew.jfrog.io -u ${JFROG_NAME}  -p ${JFROG_PWD}"
                sh 'docker image build -t spcnew.jfrog.io/spc-docker/spc:1.9 .'
                

            }
            }
        }
        stage('push the image') {
            agent { label 'JDK11'} 
            steps {
               // withCredentials([usernamePassword(credentialsId: 'JFROG', passwordVariable: 'JFROG_PWD', usernameVariable: 'JFROG_NAME')]) {
              //  sh "docker login sonarnew.jfrog.io -u ${JFROG_NAME}  -p ${JFROG_PWD}"
                sh 'docker image push sonarnew.jfrog.io/spc-docker/spc:1.9'
                sh 'docker pull sonarnew.jfrog.io/spc-docker/spc:1.9'
            //}
                
            }
        }
        stage('awseks') {
            agent { label 'awseks' }
            steps {
                git url: 'https://github.com/satishnamgadda/learn-terraform-provision-eks-cluster.git',
                    branch: 'main'
                sh """
                   terraform init
                   terraform apply -auto-approve
                   aws eks --region $(terraform output -raw region) update-kubeconfig  --name $(terraform output -raw cluster_name)
                   """
            }
        }
        
        }
    }
 

