node('jenkins-slave') {
  try {
    // notifyBuild('STARTED')
    stage('Checkout SCM') {
      checkout scm
    }

    stage('Create a Project') {
        jobDsl targets: [
          'docker/jenkins/pipelines/env/*/folders/*.groovy',
          'docker/jenkins/pipelines/env/*/pipelines/*.groovy',
        ].join('\n'),
        // removedJobAction: 'IGNORE',
        // removedViewAction: 'IGNORE',
        removedJobAction: 'DELETE',
        removedViewAction: 'DELETE',
        lookupStrategy: 'SEED_JOB'

    failFast: true|false
    }
  } catch (e) {
    currentBuild.result = "FAILED"
    throw e
  } finally {
    // notifyBuild(currentBuild.result)
    currentBuild.result = "SUCCESS"
  }
}

// def notifyBuild(String buildStatus = 'STARTED') {

//   wrap([$class: 'BuildUser']) {
//     def user = "${BUILD_USER}"
//     def subject = ""
//     def summary = ""
//     def colorName = 'RED'
//     def colorCode = '#FF0000'
//     def channel = "#testchannel"
//     def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
//       < p > Check console output at & QUOT; <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a> & QUOT;</p > """


//     buildStatus = buildStatus ?: 'SUCCESS'


//     if (buildStatus == 'STARTED') {
//       subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Started by ${user}"
//       summary = "${subject} (${env.BUILD_URL})"
//     } else {
//       subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
//       summary = "${subject} (${env.BUILD_URL})"
//     }

//     if (buildStatus == 'STARTED') {
//       color = 'YELLOW'
//       colorCode = '#FFFF00'
//     } else if (buildStatus == 'SUCCESS') {
//       color = 'GREEN'
//       colorCode = '#00FF00'
//     } else if (buildStatus == 'ROLLING UPDATE SUCCESS') {
//       color = 'Middle Blue'
//       colorCode = '#80D2DE'
//     } else if (buildStatus == 'ROLLING UPDATE FAILED') {
//       color = 'Razzmatazz'
//       colorCode = '#E51670'
//     } else {
//       color = 'RED'
//       colorCode = '#FF0000'
//     }

//     slackSend(color: colorCode, channel: channel, message: summary)
//   }
// }
