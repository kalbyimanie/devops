// NOTE: import json library
import groovy.json.JsonSlurper
// NOTE: loading the json file
def inputFile = readFileFromWorkspace("docker/jenkins/pipelines/env/sandbox/
pipelines/config.json")
// NOTE: parsing json file into Groovy data structures (objects)
def InputJSON = new JsonSlurper().parseText(inputFile)
def project_env = "SANDBOX"

for(i=0; i<InputJSON.project.size(); i++ ) {
    def project_name = InputJSON.project[i].project_name

    pipelineJob("${project_env}/${project_name}") {
        configure {
            (it / 'concurrentBuild').setValue('false')
        }

        definition {
            cps {
                sandbox()
                script(
                    """
                        node (master) {
                            stage('Init') {
                                sh "echo "hello world""
                            }
                        }

                    """.stripIndent()
                )
            }
        }
    }
}
