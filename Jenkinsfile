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
                script { 
                    sh 'echo "$BUILD_NUMBER"'
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            } 
        }
        stage('Push da image') { 
            steps {
              container('docker'){
                script { 
                    docker.withRegistry( 'https://hub.docker.com', registryCredential ) { 
                        dockerImage.push()
                      }
                    }
                } 
            }
        } 
        stage('Limpando imagem') { 
            steps {
              container('docker'){ 
                sh "docker rmi $registry:$BUILD_NUMBER" 
              }
            }
        } 
    }
}