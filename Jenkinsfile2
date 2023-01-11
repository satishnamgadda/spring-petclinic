pipeline {
    agent { label ('JDK11') }
    parameters {
        choice(name: "IMAGE_TYPE", choices: ['none','base_image','infra_image','test_image'], description: 'choose one')

    }
    stages {
        stage('docker') {
            environment {
                def REG= "sonarnew.jfrog.io/spc-docker"
                def IMAGE_NAME1= "nginx"
                def IMAGE_NAME2= "alpine"
                def IMAGE_NAME3= "httpd"
            }
            steps {
                script {
                    if (params['IMAGE_TYPE']=='base_image') {
                        sh """
                           docker image pull ${env.IMAGE_NAME1}
                           docker image tag ${env.IMAGE_NAME1} ${env.REG}/${env.IMAGE_NAME1}:${params.IMAGE_TYPE}-${BUILD_NUMBER}
                           echo image tagging done for base image
                           docker image ls
                           docker image push  ${env.REG}/${env.IMAGE_NAME1}:${params.IMAGE_TYPE}-${BUILD_NUMBER}
                           """
                    }
                    else if (params['IMAGE_TYPE']=='infra_image') {
                        sh """
                           docker image pull ${env.IMAGE_NAME2}
                           docker image tag ${env.IMAGE_NAME2} ${env.REG}/${env.IMAGE_NAME2}:${params.IMAGE_TYPE}-${BUILD_NUMBER}
                           echo image tagging done for infra image
                           docker image ls
                           """
                    }
                    else if (params['IMAGE_TYPE']=='test_image') {
                        sh """
                           docker image pull ${env.IMAGE_NAME3}
                           docker image tag ${env.IMAGE_NAME3} ${env.REG}/${env.IMAGE_NAME3}:${params.IMAGE_TYPE}-${BUILD_NUMBER}
                           echo image tagging done for test image
                           docker image ls
                           """

                    }
                    else if (params['IMAGE_TYPE']=='none') {
                        sh "echo image type is none"
                    }
                    else {
                        sh " echo image tagging failed"
                    }
                    }
                }
            }
                      
            }
        post {
             always {
            echo 'build completed'
            mail to: 'qtdevops@gmail.com',
                 subject: 'Job summary',
                 body: """Build is completed for $env.BUILD_URL"""
        }
        failure{
            echo 'build failed'
            mail to: 'qtdevops@gmail.com',
                 subject: 'Job summary',
                 body: """Build is failed for $env.BUILD_NUMBER
                          $env.BUILD_URL
                          $env.BUILD_ID"""
        }
        success{
            echo 'build is success'
            mail to: 'qtdevops@gmail.com',
                 subject: 'Job summary',
                 body: """Build is successfully completed for $env.BUILD_NUMBER
                          $env.BUILD_URL"""
        }
    }
}
                
    

    
