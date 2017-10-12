pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building'
		sh 'python --version'
            }
        }
        stage('Test') {
            steps {
                input "Does the staging environment look ok?"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
}
