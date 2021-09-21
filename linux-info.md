```Jenkinsfile

node {   
    stage ('info') {
        sh '''
            #!/bin/bash +x
            ssh -o StrictHostKeyChecking=no username@ip-address 'du -sh /backup'
        '''
    }
}


```
