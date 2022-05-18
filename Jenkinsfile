pipeline {
    environment { 
        registry = "rtprosa315/jenkins" 
        registryCredential = 'docker-build' 
        dockerImage = 'rancher/dind-alpine' 
    }
    agent {
      kubernetes {
        yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: docker
            image: rancher/dind-alpine
            command:
            - cat
            tty: true
        '''
      }
    }
    stages { 
        // stage('Clonando o Git') { 
        //     steps { 
        //       containers('docker'){
        //         git 'https://github.com/robthross/robsthiago.git'
        //       }
        //     }
        // } 
        stage('Building da imagem') { 
            steps { 
              container('docker'){
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                  }
                }
            } 
        }
        stage('Push da image') { 
            steps {
              containers('docker'){
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push()
                      }
                    }
                } 
            }
        } 
        stage('Limpando imagem') { 
            steps {
              containers('docker'){ 
                sh "docker rmi $registry:$BUILD_NUMBER" 
              }
            }
        } 
    }
}