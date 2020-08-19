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
      stage('ssh deploy'){
         steps{
            script{
                 for(host in "$sshHosts".split(",")){
                     remote = getRemote(host)
                     sshCommand remote: remote, command: "if [ ! -d '/opt/app/spring-boot-jenkins' ]; then mkdir -p /opt/app/spring-boot-jenkins;fi"
                     sshPut remote: remote, from: 'target/spring-boot-jenkins-0.0.1-SNAPSHOT.jar', into: '/opt/app/spring-boot-jenkins',override: true
                     sshCommand remote: remote, command: "sh /opt/app/spring-boot-jenkins/start.sh"
                 }
            }
         }
      }
   }
}

def getRemote(host){
    def remote = [:]
     remote.name = host
     remote.host = host
     remote.user = "root"
     remote.password = "111111"
     remote.allowAnyHosts = true
     return remote
}