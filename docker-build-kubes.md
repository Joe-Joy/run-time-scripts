```Jenkinsfile

node {   
    def remote = [:]
    remote.name = "linux"
    remote.host = "dodonotdo.in"
    remote.allowAnyHosts = true

    stage('Checkout the dockefile from GitHub') {            
      git branch: 'main', credentialsId: 'fourtimesId', url: 'https://github.com/FourTimes/demo-build.git'        
    }
     
    stage('Build the Image and Push to Docker hub') {                
      app = docker.build('jjino/demo')                
      withDockerRegistry([credentialsId: 'acr_credentials']) {                
      app.push("${env.BUILD_NUMBER}")                
      app.push('latest')
     }        
    }    

    stage('Build the Kubernetes YAML Files for New App') {
    withCredentials([usernamePassword(credentialsId: 'sshUserAcct', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Depolyment") {
            sshCommand remote: remote, command: 'ls'

        }
    }  
    } 
}




```
