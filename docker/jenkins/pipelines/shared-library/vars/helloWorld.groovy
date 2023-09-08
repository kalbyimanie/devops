def call(Map args) {
    // !!! IMPORTANT !!! SECTION variables
    def hello = args.hello

    // !!! IMPORTANT !!! SECTION pipeline
    pipeline {

        // options {

        // }

        // agent {
        //     docker {
        //         yaml """
        //             """
        //     }
        // }
        stage ('abc') {

            steps {
                script {
                    """
                        sh "echo ${hello}"
                    """
                }
            }
        }

        // stages {
        //     stage ('[shared library]—init stage') {
        //         steps {
        //             script {
        //                 """
        //                     sh "echo ${hello}"
        //                 """
        //             }
        //         }
        //     }
        // }
    }
}