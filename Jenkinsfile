pipeline {
  agent {
    kubernetes {
      yaml '''
apiVersion: v1
kind: Pod
metadata:
  name: buildah
spec:
  containers:
  - name: buildah
    image: quay.io/buildah/stable:v1.23.1
    command:
    - cat
    tty: true
    securityContext:
      privileged: true
    volumeMounts:
      - name: varlibcontainers
        mountPath: /var/lib/containers
    volumes:
      - name: varlibcontainers
  '''   
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    disableConcurrentBuilds()
  }
  environment {
    DH_CREDS=credentials('dh-creds')
  }
  stages {
    stage('Build with Buildah') {
      steps {
        container('buildah') {
          sh 'buildah build -t rtprosa315/jenkins:$BUILD_NUMBER .'
        }
      }
    }
    stage('Login to Docker Hub') {
      steps {
        container('buildah') {
          sh 'echo $DH_CREDS_PSW | buildah login -u $DH_CREDS_USR --password-stdin docker.io'
        }
      }
    }
    stage('tag image') {
      steps {
        container('buildah') {
          sh 'buildah tag rtprosa315/jenkins:$BUILD_NUMBER rtprosa315/jenkins:latest'
        }
      }
    }
    stage('push image') {
      steps {
        container('buildah') {
          sh 'buildah push rtprosa315/jenkins:$BUILD_NUMBER'
          sh 'buildah push rtprosa315/jenkins:latest'
        }
      }
    }
    stage('Git Push') {
      steps {
        container('buildah') {
          sh 'git clone https://github.com/robthross/jenkins.git'
          sh 'sed -i s/xxx/"${BUILD_NUMBER}"/g /nginx/nginx.yaml'
          sh 'cd jenkins'
          sh 'git add .'
          sh 'git commit -m "Commit Pipeline"'
          withCredentials([usernamePassword(credentialsId: 'githubtoken', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/robthross/jenkins.git')
          }
        }
      }
    }
  }
  post {
    always {
      container('buildah') {
        sh 'buildah logout docker.io'
      }
    }
  }
}