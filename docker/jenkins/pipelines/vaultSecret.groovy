def configuration = [
  vaultUrl: 'http://vault-url.com',
  vaultCredentialId: 'my-vault-cred-id',
  engineVersion: 1
]

def secrets = [
  [path: 'secret/testing', engineVersion: 1,
    secretValues: [
      [envVar: 'testing', vaultKey: 'value_one'],
      [envVar: 'testing_again', vaultKey: 'value_two']
    ]
  ],
  [path: 'secret/another_test', engineVersion: 2,
    secretValues: [
      [vaultKey: 'another_test']
    ]
  ]
]

timestamps{
  node("jenkins-slave"){
    stage("getVaultSecrets"){
      withVault([configuration: configuration, vaultSecrets: secrets]) {
        sh 'echo $testing'
        sh 'echo $testing_again'
        sh 'echo $another_test'
      }
    }
  }
}
