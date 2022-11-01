pipeline {
  agent any
  environment {
       PACKER_ACTION = 'YES'
       ACTION = 'DEPLOY'
    }
  stages {
    stage('Perform Packer Build') {
      when {
        expression {
          env.PACKER_ACTION != 'YES'
        }

      }
      steps {
        sh 'pwd'
        sh 'ls -al'
        sh 'packer build -var-file ./packer-vars.json ./packer.json | tee output.txt'
        sh 'tail -2 output.txt | head -2 | awk \'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }\' > ami.txt'
        sh 'echo $(cat ami.txt) > ami.txt'
        script {
          def AMIID = readFile('ami.txt').trim()
          sh 'echo "" >> variables.tf'
          sh "echo variable \\\"imagename\\\" { default = \\\"$AMIID\\\" } >> variables.tf"
        }

      }
    }

    stage('No Packer Build') {
      when {
        expression {
          env.PACKER_ACTION == 'YES'
        }

      }
      steps {
        sh 'pwd'
        sh 'ls -al'
        sh 'echo "" >> variables.tf'
        sh 'echo variable \\"imagename\\" { default = \\"ami-065ce7665c3c7a748\\" } >> variables.tf'
      }
    }

    stage('Terraform Plan') {
      when {
        expression {
          env.ACTION == 'DEPLOY'
        }

      }
      steps {
        sh 'terraform init'
        sh 'terraform validate'
        sh 'terraform plan'
      }
    }

    stage('Terraform Apply') {
      when {
        expression {
          env.ACTION == 'DEPLOY'
        }

      }
      steps {
        sh 'terraform init'
        sh 'terraform apply --auto-approve'
      }
    }

    stage('Terraform Destroy') {
      when {
        expression {
          env.ACTION != 'DEPLOY'
        }

      }
      steps {
        sh 'terraform init'
        sh 'terraform destroy --auto-approve'
      }
    }

    stage('Ansible Check') {
      steps {
        sh 'ansible-playbook -i hosts.cfg nginx-play-remote.yml --syntax-check'
        sh 'ansible-playbook -i hosts.cfg nginx-play-remote.yml --check'
      }
    }

  }
}
