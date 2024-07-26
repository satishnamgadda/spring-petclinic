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
    try {
    stage('Branch') {
        sh 'git checkout main'
    }
    stage('build') {
        sh 'mvn package'
    }
    }
    catch (exc) {
            echo 'Something failed, I should sound the klaxons!'
            
    } 
    
}
