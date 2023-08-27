@Library('library_name')_

properties([
  buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')),
  pipelineTriggers([
    GenericTrigger(causeString: 'Generic Cause', genericVariables: [[
      defaultValue: 'master',
      key: 'TAG',
      regexpFilter: '[\\[""\\]]',
      value: '$.push.changes[?(@.new.type == "branch")].new.name'
    ]],
    regexpFilterExpression: '',
    regexpFilterText: '',
    token: 'vAqVXvrmnOtWaBrqQ01Hk0XHoojl43GascsacsaOlghY1s2QU4W69izXTKw6fOthUhfu5vtki6Xj7MmhTg5httiAGN1A0dawu9MGpIUR7i0wBqwsy5rant1EK')
    ]),
  parameters([
    string(name: 'TAG',
      defaultValue: 'master',
      description: 'input branch name or tag',
      trim: false),
    choice(
      name: 'targetRealm',
      choices: ['dev'],
      description: 'Choose target realm')
    ])
])


def devConfig = [
  "key":"value",
]

def ecrUri = ""
def repositoryName = ""

nodePod(name:"buildImage",type:"builder"){
  try {
    stage('Checkout Repo') {
      checkoutRepo(repositoryName,params.TAG)
    }
    stage('Build image') {
      withAWS(credentials:'credential_name', region:'region_name') {
        container('builder') {
          tagVersion = versioning(false)
          def version = tagVersion.version
          imageTag = "${ecrUri}/${repositoryName}:${version}-${BUILD_NUMBER}"
          switch(params.targetRealm) {
          case "dev":
            devConfig.each{ k, v -> env."${k}"="${v}" }
            break
          default:
            echo "parameter not valid, exiting"
            sh "exit 1"
            break
          }
          sh """
            dockerd &
            export REVISION_ID=${version}
            export BUILD_DATE=\$(date -u -Iseconds)
            \$(aws ecr get-login --no-include-email)
            make build
            docker tag ${repositoryName}:${version} ${imageTag}
            docker push ${imageTag}
          """
        }
      }
    }
    stage('Tag, Deploy'){
        // Trigger Deploy
        deployJobStatus = build(job: 'deploy', wait: true, propagate: false, parameters: [
          [$class: 'StringParameterValue', name: 'TAG', value: params.TAG],
          [$class: 'StringParameterValue', name: 'imageTag', value: imageTag],
          [$class: 'StringParameterValue', name: 'targetRealm', value: target]
        ])
    }
  } catch (err) {
    echo "Exception thrown:\n ${err}"
    currentBuild.result = "FAILURE"
  }
}

