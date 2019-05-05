properties([
	parameters([
		string(name: 'NAMESPACES', defaultValue: 'alpha beta gamma', description: 'NAMESPACES'),
		string(name: 'RESOURCETYPES', defaultValue: 'ingress deployment configmap svc rc ds networkpolicy statefulset cronjob pvc', description: 'RESOURCETYPES'),
		string(name: 'GLOBALRESOURCES', defaultValue: 'namespace storageclass clusterrole clusterrolebinding customresourcedefinition', description: 'GLOBALRESOURCES'),
		string(name: 'CLIENT', defaultValue: 'CLIENT 1', description: 'CLIENT')
	])
])

//CLIENT 1
def KUBE_CONFIG_LIST = ["A,B,C"]
def SANDBOX = "${KUBE_CONFIG_LIST[0]}"
def DEV = "${KUBE_CONFIG_LIST[1]}"
def PROD = "${KUBE_CONFIG_LIST[2]}"

//CLIENT 2
def KUBE_CONFIG_LIST_CLIENT_2 = ["A,B"]
def CLIENT_2_DEV="${KUBE_CONFIG_LIST_CLIENT_2[0]}"
def CLIENT_2_PROD="${KUBE_CONFIG_LIST_CLIENT_2[1]}"



def label = "documentation-${UUID.randomUUID().toString()}"
podTemplate(name: label, label: label, yaml: """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: jenkins-slave
spec:
  containers:
    - name: jnlp
      image: odavid/jenkins-jnlp-slave
      securityContext:
        runAsUser: 0
      tty: true
      volumeMounts:
        - name: dockersock
          mountPath: "/var/run/docker.sock"
    - name: jenkins-slave
      image: IMAGE:VERSION
      command:
      - cat
      tty: true
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
)
{
  node(label){
    stage("Doing checkout SCM"){checkout scm}
    stage("Client 1 Backup"){
      container('jenkins-slave'){
        GPG_PASSPHRASE = "JENKINS_PARAMETER_PASSPHRASE"
        withAWS(credentials:'AWS_CREDS_ID_FROM_JENKINS'){
          withCredentials([
            string(credentialsId:"${GPG_PASSPHRASE}", variable: 'GPG_KEY')]){
              for(item in KUBE_CONFIG_LIST){
                withEnv(["KUBE_CONFIG_URL=${item}"]){
                  if(item == "${SANDBOX}"){
                    withEnv(["K8S_ENV=sandbox"]){sh ''' cd ${PWD}/path/;chmod +x script.sh;bash script.sh '''}
                }else if(item == "${DEV}"){
									withEnv(["K8S_ENV=sandbox"]){sh ''' cd ${PWD}/path/;chmod +x script.sh;bash script.sh '''}
                }else if(item == "${PROD}"){
									withEnv(["K8S_ENV=sandbox"]){sh ''' cd ${PWD}/path/;chmod +x script.sh;bash script.sh '''}
                }
              }
            }
          }
        }
      }
    }
    stage("Client 2 Backup"){
      container('jenkins-slave'){
        withAWS(credentials:'AWS_CREDS_ID_FROM_JENKINS'){
          for(item in KUBE_CONFIG_LIST_CLIENT_2){
            if(item == "${CLIENT_2_DEV}"){
              GPG_PASSPHRASE = "Client_Name-Dev-Kubeconfig-GPG-Phrase"
              withCredentials([
                string(credentialsId:"${GPG_PASSPHRASE}", variable:'GPG_KEY')]){
                  withEnv(["KUBE_CONFIG_URL=${item}","K8S_ENV=client-dev","CLIENT=Client_Name"]){
                    sh ''' cd ${PWD}/path/;chmod +x script.sh;bash script.sh '''
                }
              }
            }else if(item == "${CLIENT_2_PROD}"){
              GPG_PASSPHRASE = "JENKINS_PARAMETER_PASSPHRASE"
              withCredentials([
                string(credentialsId:"${GPG_PASSPHRASE}", variable:'GPG_KEY')]){
                  withEnv(["KUBE_CONFIG_URL=${item}","K8S_ENV=Client1Prod","CLIENT=asd"]){
                    sh ''' cd ${PWD}/kubernetes-cluster/;chmod +x backup.sh;bash backup.sh '''
                }
              }
            }
          }
        }
      }
    }
    stage("Push BitBucket"){
      container('jenkins-slave'){
        GPG_PASSPHRASE = "JENKINS_PARAMETER_PASSPHRASE"
        BITBUCKET_SSH_KEY = "JENKINS_PARAMETER_SSH_KEY_CREDS"
        withCredentials([
          sshUserPrivateKey(credentialsId:"${BITBUCKET_SSH_KEY}", keyFileVariable: 'id_rsa'),
          string(credentialsId:"${GPG_PASSPHRASE}", variable: 'GPG_KEY')]){
              sh '''
    						apk update && apk add openssh
    						ssh-agent
    						eval $(ssh-agent) && ssh-add ${id_rsa} && ssh-add -l
    						ssh -v -o "StrictHostKeyChecking no" git@bitbucket.org
    						git config --global user.name "jenkins"
    						git config --global user.email "operations@example.net"
    						git status
    						git add .
    						git commit -m "Automatic backup at $(date)"
    						git status
    						git tag "$(date +%Y%m%d_%H%M)"
    						git push origin "$(date +%Y%m%d_%H%M)"
    						echo "Finished push to bitbucket"
    					'''
        }
      }
    }
  }
}
