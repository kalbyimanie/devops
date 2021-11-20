timestamps {
  node("jenkins-slave") {
    stage("start") {
      sh "echo 'hello'"
    }
  }
}
