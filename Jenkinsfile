
def VersaoNginx = "1.20.2"
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
          sh 'git config --global --add safe.directory /home/jenkins/agent/workspace/gitlab-house'
          sh 'git checkout -b main'
          sh 'git config --global user.email "rtech.thiago@gmail.com"'
          sh 'git config --global user.name "robthross"'
          withCredentials([usernamePassword(credentialsId: 'tokengit', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh 'git status'
            sh 'git add .'
            sh 'git commit -m "commit pipeline"'
            sh 'git merge dev'
            // sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/robthross/robsthiago.git')
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