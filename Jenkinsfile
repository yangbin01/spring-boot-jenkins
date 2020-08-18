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
      stage('deploy'){
           steps{
              script{
                  sh '''
                    rm -rf /opt/app/spring-boot-jenkins/*.jar
                    cp ${WORKSPACE}/target/*.jar /opt/app/spring-boot-jenkins
                    cd /opt/app/spring-boot-jenkins
                    ./start.sh
                  '''
              }
           }
      }
   }
}