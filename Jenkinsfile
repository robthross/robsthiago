
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
          sh "sed -i 's/1.20.2/$VersaoNginx/g' nginx/nginx.yaml"
          sh "cat nginx/nginx.yaml"
          sh 'git config --global user.email "robson.rosa@vr.com.br"'
          sh 'git config --global user.name "Robson Thiago"'
          sh 'git config --global --add safe.directory /home/jenkins/agent/workspace/gitlab-house'
          withCredentials([usernamePassword(credentialsId: 'gitlabpass1', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh 'git checkout -b main'
            sh 'git add .'
            sh 'git commit -m "MeuTest"'
            sh('git push http://${GIT_USERNAME}:${GIT_PASSWORD}@git@github.com:robthross/jenkins.git')
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