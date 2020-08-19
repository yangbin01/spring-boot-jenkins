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
      stage('创建docker镜像'){
         steps{
            script{
                sh "tar -zxvf target/spring-boot-jenkins-distribution.tar.gz -C /opt/soft"
                sh "sh /opt/soft/spring-boot-jenkins/docker.sh spring-boot-jenkins"
            }
         }
      }
   }
}