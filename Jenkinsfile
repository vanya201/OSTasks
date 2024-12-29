pipeline {
    agent any

    environment {
        SCRIPT_PATH = '/usr/local/bin/count_files.sh'
        RPM_PACKAGE_URL = 'https://github.com/vanya201/OSTasks/releases/download/v25/FileCounter-1.0-1.x86_64.rpm'
    }

    stages {
        stage('Run in Docker') {
            steps {
                script {
                    docker.image('ubuntu:latest').inside('-u root') {
                        // Install necessary tools
                        sh '''
                        apt-get update && apt-get install -y wget curl dpkg rpm alien
                        '''
                        // Download Artifact
                        sh '''
                        curl -L -o count_files.rpm $RPM_PACKAGE_URL || wget -O count_files.rpm $RPM_PACKAGE_URL
                        '''
                        // Install RPM Package (Using alien if necessary for Ubuntu)
                        sh '''
                        alien --to-deb count_files.rpm
                        apt-get install -f -y
                        dpkg -i count_files.deb
                        '''
                        // Run Script
                        sh '''
                        if [ -f "$SCRIPT_PATH" ]; then
                            chmod +x "$SCRIPT_PATH"
                            "$SCRIPT_PATH"
                        else
                            echo "Script not found at $SCRIPT_PATH"
                            exit 1
                        fi
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for details.'
        }
    }
}
