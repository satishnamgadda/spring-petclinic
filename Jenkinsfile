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
    stage('Example') {
        git branch: "main",
        git url: "https://github.com/satishnamgadda/spring-petclinic.git"
        sh 'im in main'
    }
}
