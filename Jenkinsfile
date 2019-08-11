pipeline {
  agent any
  stages {
    stage('start') {
      steps {
        echo 'Start'
      }
    }
    stage('docker-build&push') {
      steps {
        script {
          dockerImage = docker.build("ajaysheoran2323/mynewimage:latest", "-f Dockerfile .")
          docker.withRegistry('', 'dockerhub'){
            dockerImage.push()
          }
        }

      }
    }
    stage('deployToK8s') {
      steps {
        script {
          kubernetesDeploy(kubeconfigId: 'rancher',
          configs: 'k8s-deploy.yml',
          enableConfigSubstitution: false,
          secretNamespace: 'devx',
          secretName: 'devx',
          dockerCredentials: [
            [credentialsId: 'dockerhub', url: '']
          ]
        )
      }

    }
  }
  stage('runTest') {
    steps {
      sh '''#!/bin/bash
if [ "`npm run test`" == *\'passed\'* ]; then
  echo "Test passed"
else
  echo " test failed"
fi
'''
    }
  }
  stage('END') {
    steps {
      echo 'END'
    }
  }
}
}