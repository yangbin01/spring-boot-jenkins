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
                sh "tar -zxvf spring-boot-jenkins.tar.gz -C /opt/soft"
                sh "cd /opt/soft/spring-boot-jenkins"
                sh "./docker.sh spring-boot-jenkins"
            }
         }
      }
   }
}