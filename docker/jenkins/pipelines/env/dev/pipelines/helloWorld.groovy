// NOTE: import json library
import groovy.json.JsonSlurper
// NOTE: loading the json file
def inputFile = readFileFromWorkspace("docker/jenkins/pipelines/env/sandbox/pipelines/config.json")
// NOTE: parsing json file into Groovy data structures (objects)
def InputJSON = new JsonSlurper().parseText(inputFile)
def project_env = "DEV"

for(i=0; i<InputJSON.project.size(); i++ ) {
    def project_name = InputJSON.project[i].project_name
    // !!! IMPORTANT !!! sample linear job
    pipelineJob("${project_env}/${project_name}") {
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
    // !!! IMPORTANT !!! END OF sample linear job
    // !!! IMPORTANT !!! sample parallel job
    pipelineJob("${project_env}/SAMPLE-PARALLEL-JOB") {
        configure {
            (it / 'concurrentBuild').setValue('false')
        }

        definition {
            cps {
                sandbox()
                script(
                    """
                        stage('parallel') {
                            parallel slave1: {
                                node ('jenkins-slave') {
                                    stage('Init') {
                                        sh "echo 'hello world'"
                                    }
                                }
                            },
                            slave2: {
                                node ('jenkins-slave') {
                                    stage('Init') {
                                        sh "echo 'hello world'"
                                    }
                                }
                            }
                        }

                    """.stripIndent()
                )
            }
        }
    }
    // !!! IMPORTANT !!! END OF sample parallel job

    // !!! IMPORTANT !!! shared library job
    pipelineJob("${project_env}/SAMPLE-SHARED-LIBRARY-JOB") {
        configure {
            (it / 'concurrentBuild').setValue('false')
        }

        definition {
            cps {
                sandbox()
                script(
                    """
                        // import shared lib
                        @Library('helloWorld@master')_

                        def params = [
                            param1: "hello",
                            param2: "world"
                        ]

                        node ('jenkins-slave') {
                            stage('Init') {
                                sh "echo 'hello world'"
                            }
                            helloWorld(params)
                        }
                    """.stripIndent()
                )
            }
        }
    }
    // !!! IMPORTANT !!! END OF shared library job
}
