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
                    deployerId : "MAVEN_DEFAULT"
                    
                )
          
            }
        }
        stage('artifactory configuaration') {
             steps {
                rtMavenDeployer(
                   id : "MVN_DEFAULT",
                   releaseRepo : "spc10-libs-release-local",
                   snapshotRepo : "spc10-libs-snapshot-local",
                   serverId : "JFROG-SPC"
                )

           }
        }
         stage('publish build info') {
             steps {
               rtPublishBuildInfo(
                serverId : "JFROG-SPC"
              )
           }
        }
      
    }
    
}




