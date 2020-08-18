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
                    pid=`ps -ef | grep java | grep spring-boot-jenkins | grep -v "grep" | awk '{print $2}'`
                    if [ "$pid" != "" ]
                    then
                      kill -9 $pid
                    fi
                    nohup java -jar /opt/app/spring-boot-jenkins/spring-boot-jenkins-0.0.1-SNAPSHOT.jar > /opt/app/spring-boot-jenkins/logs/app.log 2>&1 &

                  '''
              }
           }
      }
   }
}