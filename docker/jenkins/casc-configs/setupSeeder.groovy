theScript = new File('/var/jenkins_home/casc_configs/jobSeeder.groovy').getText("UTF-8")
pipelineJob('Pipeline-Seeder') {
  definition {
    cps {
      script(theScript)
      sandbox()
    }
  }
}