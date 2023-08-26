def sendTelegram(message) {
    def encodedMessage = URLEncoder.encode(message, "UTF-8")

    withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
    string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {

        response = httpRequest (consoleLogResponseBody: true,
                contentType: 'APPLICATION_JSON',
                httpMode: 'GET',
                url: "https://api.telegram.org/bot$TOKEN/sendMessage?text=$encodedMessage&chat_id=$CHAT_ID&disable_web_page_preview=true",
                validResponseCodes: '200')
        return response
    }
}

def secrets = [
  [path: 'dev/github/user.secret', engineVersion: 2,
    secretValues: [
      [envVar: 'username', vaultKey: 'username'],
      [envVar: 'password', vaultKey: 'password']
    ]
  ]
]

timestamps {
  node("jenkins-slave") {
    stage("start") {
      sh "echo 'hello'"
    }
    stage("checkout") {
        withVault([vaultSecrets: secrets]) {
            sh "echo ${username}"
        }
    }
    stage("send notif"){
      sendTelegram("Build Successful")
    }
  }
}
