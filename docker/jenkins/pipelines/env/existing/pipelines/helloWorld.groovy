def project_dir = "EXISTING"
def project_name = "DSL"
pipelineJob("${project_dir}/${project_name}") {
    configure {
        (it / 'concurrentBuild').setValue('false')
    }

    parameters {
        radioactiveParameter {
            name('Mode')
            description('RESYNC or INDIVIDUAL COMPONENT RESTART')
            selectedOption("RESYNC")
            options {
                // option RESYNC
                option {
                    optionName("RESYNC")
                    enabledParameters("RESYNC")
                }

                // option BULK_RESTART
                // option {
                //     optionName("BULK_RESTART")
                //     enabledParameters("BULK_RESTART")
                // }

                // option INDIVIDUAL_COMPONENT_RESTART
                option {
                    optionName("INDIVIDUAL_COMPONENT_RESTART")
                    enabledParameters("INDIVIDUAL_COMPONENT_RESTART")
                }
            }
        }

        choiceParam('INDIVIDUAL_COMPONENT_RESTART', ['airflow-webserver', 'airflow-scheduler', 'airflow-worker'], 'Select Airflow Component To Be Restarted')
        choiceParam('RESYNC', ['Reync'], 'Resync')


        // activeChoiceReactiveParam('INDIVIDUAL_COMPONENT_RESTART') {
        //     description('Select Airflow Component')
        //     filterable()
        //     choiceType('SINGLE_SELECT')
        //     groovyScript {
        //       script('''
        //           import groovy.json.JsonSlurper
        //           import jenkins.model.Jenkins

        //           def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
        //               com.cloudbees.plugins.credentials.common.StandardCredentials.class,
        //               Jenkins.instance,
        //               null,
        //               null
        //           );

        //           def getJakartaTime(input) {
        //             def pattern = "yyyy-MM-dd'T'HH:mm:ssX"
        //             def date = Date.parse(pattern, input)
        //             def date_jakarta = date.format(pattern, TimeZone.getTimeZone("Asia/Jakarta"))
        //             return date_jakarta
        //           }

        //           //Secret Strings
        //           for (c in creds) {
        //             if (c.id == "argocd-token") {
        //               secret = c.secret
        //             }
        //           }

        //           def rollback_version = []
        //           response = ["bash", "-c", "curl -k https://argocd-server.argocd.svc.cluster.local/api/v1/applications/''' + full_app_name + ''' --cookie argocd.token=${secret}"].execute().text
        //           def list = new JsonSlurper().parseText( response )
        //           list.status.history.each {
        //             rollback_version.push(it.id + " | " + getJakartaTime(it.deployedAt) + " | " + it.source.kustomize.images)
        //           }
        //           return rollback_version.reverse()
        //       ''')
        //       fallbackScript('return ["Script error!"]')
        //     }
        //     referencedParameter('')
        // }



        // Rotate jenkins build when reached 10 jobs in total
        logRotator {
            numToKeep(10)
        }
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
