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
     catch (exc) {
            echo 'Something failed, I should sound the klaxons!'
            
    } 
}
}
