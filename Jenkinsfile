pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '''# Create Python Virtual Env
pip3 install virtualenv --user
python3 -m venv repo

# Install
pip install -r requirements.txt'''
      }
    }
    stage('Test') {
      steps {
        sh '''# Activate python virtual environment
. repo/bin/activate
#Run pytest and export coverage report
pytest --cov-report xml --cov-report term --cov ./lib/'''
        cobertura(failNoReports: true, failUnhealthy: true, failUnstable: true, coberturaReportFile: 'whatisthis')
      }
    }
  }
}