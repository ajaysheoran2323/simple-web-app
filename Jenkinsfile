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
          kubeConfig: [path: '/var/lib/jenkins/workspace/.kube/rancher'],
          configs: 'k8s-deploy.yml',
          enableConfigSubstitution: false,
          dockerCredentials: [
            [credentialsId: 'dockerhub', url: 'https://registry.hub.docker.com']
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