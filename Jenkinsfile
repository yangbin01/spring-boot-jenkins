pipeline{
   agent any
   environment {
         CC = 'clang'
   }
   stages{
      stage('checkout'){
         steps{
            echo "${sshHosts}"
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
                    export BUILD_ID=dontKillMe
                    ./start.sh
                  '''
              }
           }
      }
      stage('ssh deploy'){
         steps{
            script{
                 for(host in "$sshHosts".split(",")){
                     def remote = [:]
                     remote.name = host
                     remote.host = host
                     remote.user = "root"
                     remote.password = "111111"
                     remote.allowAnyHosts = true
                     sshCommand remote: remote, command: "if [ ! -d '/opt/app/spring-boot-jenkins2' ]; then mkdir -p /opt/app/spring-boot-jenkins2;fi"
                     sshPut remote: remote, from: '/opt/app/spring-boot-jenkins', into: '/opt/app',override: true
                     sshCommand remote: remote, command: "sh /opt/app/spring-boot-jenkins/start.sh"
                 }
            }
         }
      }
   }
}