node {
    try {
        stage('checkout') {
            echo 'check out the code'
            checkout scm
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
}