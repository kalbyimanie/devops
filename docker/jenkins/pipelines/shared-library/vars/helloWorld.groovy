def call(Map args) {
    // !!! IMPORTANT !!! SECTION variables
    def param1 = args.param1
    def param2 = args.param2

    // !!! IMPORTANT !!! SECTION pipeline
    pipeline {
        stage ('FROM SHARED LIBRARY') {
            sh """
                echo "${param1} ${param2}"
            """
        }
    }
}