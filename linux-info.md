```Jenkinsfile

node {   
    stage ('kubernetes') {
        steps{
            sh '''
                ssh -o StrictHostKeyChecking=no username@ip-address 'du -sh /backup'
            '''
        }
    }
}


```
