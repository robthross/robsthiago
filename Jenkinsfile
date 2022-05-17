pipeline { 
2
    environment { 
        registry = "rtprosa315/jenkins" 
        registryCredential = 'docker-build' 
        dockerImage = '' 
    }
    agent any 
    stages { 
        stage('Clonando o Git') { 
            steps { 
                git 'https://github.com/robthross/robsthiago.git' 
            }
        } 
        stage('Building da imagem') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Push da image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        stage('Limpando imagem') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}