pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '''# Create python virtual Environment
pip3 install virtualenv --user
python3 -m venv repo. repo/bin/activate

# Install python requirements
pip3 install -r requirements.txt'''
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