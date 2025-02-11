job('Seed Job') {
    description('Creates Jenkins pipeline jobs from DSL scripts')

    scm {
        git {
            remote {
                url('git@github.com:kalbyimanie/devops.git')
            }
            branch('master')
        }
    }

    steps {
        jobDsl {
            targets: [
              'docker/jenkins/pipelines/env/*/folders/*.groovy',
              'docker/jenkins/pipelines/env/*/pipelines/*.groovy',
            ]
            removedJobAction('DELETE')
            removedViewAction('DELETE')
            lookupStrategy('SEED_JOB')
        }
    }
}