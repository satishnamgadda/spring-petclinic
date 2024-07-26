/*node {
    try {
        stage('checkout') {
            echo 'check out the code'
            checkout scm
        }
    } 
    catch (exc) {
            echo 'Something failed, I should sound the klaxons!'
            
    }    
        
}*/
node {
    stage('Branch') {
        sh 'git checkout main'
    }
    stage('build') {
        sh 'mvn package'
    }
    stage('artifact') {
        sh '*/target/*.jar'
    }
  
}
