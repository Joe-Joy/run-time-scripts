```Jenkinsfile

node {   
    stage ('kubernetes') {
        steps{
            sh '''
                ssh -o StrictHostKeyChecking=no username@ip-address 'find /backup -type f -mtime +60 delete'
            '''
        }
    }
}

```
