pipeline{
   agent any
   stages{
      stage('checkout'){
         steps{
            script{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/yangbin01/spring-boot-jenkins.git']]])
            }
         }
      }
      stage('build'){
         steps{
            script{
                sh "mvn clean package -Dmaven.test.skip=true"
            }
         }
      }
      stage('copy'){
           steps{
              script{
                  sh '''
                    rm -rf /opt/app/spring-boot-jenkins/*
                    cp ${WORKSPACE}/target/*.jar /opt/app/spring-boot-jenkins
                  '''
              }
           }
      }
   }
}