def project_dir = "EXISTING"
def project_name = "DSL"
pipelineJob("${project_dir}/${project_name}") {
    configure {
        (it / 'concurrentBuild').setValue('false')
    }

    definition {
        cps {
            sandbox()
            script(
                """
                    node ('jenkins-slave') {
                        stage('Init') {
                            sh "echo 'hello world'"
                        }
                    }

                """.stripIndent()
            )
        }
    }
}
