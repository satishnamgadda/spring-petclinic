pipeline {
    agent { label 'JDK11'} 
    stages {
        stage('vcs') {
            steps {    
                git branch: "REL_INT_1.0", url: 'https://github.com/satishnamgadda/spring-petclinic.git'
            }

        }
      
        stage('Exec Maven') {
            steps {
                rtMavenRun(
                    pom : "pom.xml",
                    goals : "clean install",
                    tool : "mvn",
                    deployerId : "mvn"
                )
          
            }
        }
      
    }
    
}




 //    stage('Build the Code') {
 //           steps {
 //              withSonarQubeEnv('SONAR') {
 //                   sh script: 'mvn clean package sonar:sonar'
 //              }
 //           }
 //       }
 //     mail subject: 'build started',
 //                    body: 'build started',
 //                    to: 'qtdevops@gmail.com'
 //      stage('artifactory configuaration') {
 //           steps {
  //              rtMavenDeployer(
   //                id : "mvn",
  //                 releaseRepo : "spc-libs-release-local",
  //                 snapshotRepo : "spc-libs-snapshot-local",
 //                  serverId : "JFROG_SPC"
 //               )
//
 //           }
 //       }
 //        stage('publish build info') {
  //          steps {
  //             rtPublishBuildInfo(
  //              serverId : "JFROG_SPC"
   //            )
   //        }
    //    }