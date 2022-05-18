pipeline {
    environment { 
        registry = "rtprosa315/jenkins" 
        registryCredential = 'docker-build' 
        // dockerImage = 'rancher/dind-alpine' 
    }
    agent {
      kubernetes {
        yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          volumes:
            - name: docker-socket
              emptyDir: {}
          containers:
          - name: docker
            image: docker:20.10.16-alpine3.15
            command:
            - sleep
            args:
            - 99d
            volumeMounts:
            - name: docker-socket
              mountPath: /var/run/docker.sock
          - name: docker-daemon
            image: docker:20.10.16-dind-alpine3.15
            securityContext:
              privileged: true
            volumeMounts:
            - name: docker-socket
              mountPath: /var/run/docker.sock
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
                  container('docker'){
                    dockerImage = docker.build("$registry:$BUILD_NUMBER")
                  }
                }
            } 
        }
        stage('Push da image') { 
            steps {
              container('docker'){
                script { 
                    docker.withRegistry( 'https://hub.docker.com', "$registryCredential" ) { 
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