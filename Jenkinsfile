
def VersaoNginx = "1.20"
def RepoUrl = "http://gitlab.casa.com/root/argocd.git"
pipeline {
  agent {
    kubernetes {
      yaml ''' 
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: git
            image: bitnami/git
            command:
            - cat
            tty: true
        '''
    }
  }

  stages {
    stage("Alterar Yaml"){
      steps {
        container("git") {
          sh "sed -i 's/1202/$VersaoNginx/g' nginx/nginx.yaml"
          sh "cat nginx/nginx.yaml"
          sh 'git clone https://github.com/robthross/jenkins.git'
          sh 'ls -lha'
          sh 'mkdir jenkins/nginx'
          sh 'mv nginx/* jenkins/nginx/'
          sh 'git config --global user.email "rtech.thiago@gmail.com"'
          sh 'git config --global user.name "robthross"'
          sh 'git config --global --add safe.directory /home/jenkins/agent/workspace/gitlab-house'
          withCredentials([usernamePassword(credentialsId: 'gitlabpass1', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh 'git checkout -b main'
            sh 'git status'
            sh 'git add .'
            sh 'git commit -m "commit pipeline"'
            sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com:robthross/jenkins.git')
        }
        }
      }
    }
    stage("Git Push"){
      steps {
        container("git") {
          sh "cat nginx/nginx.yaml"
        }
      }
    }
  }
}