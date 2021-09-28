```Jenkins

def remote = [:]
remote.name = "linux"
remote.host = "dodonotdo.in"
remote.allowAnyHosts = true

node {
    withCredentials([usernamePassword(credentialsId: 'sshUserAcct', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("SSH Steps Rocks!") {
            sshCommand remote: remote, command: 'bash test.sh'
        }
    }
}


```
