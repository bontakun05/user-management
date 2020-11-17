pipeline {
    agent {
        node {
            label 'master'
            customWorkspace "workspace/${env.BRANCH_NAME}/src/git.bluebird.id/logistic/user-management"
        }
    }
    environment {
        SERVICE = 'user-management'
    }
    options {
        buildDiscarder(logRotator(daysToKeepStr: env.BRANCH_NAME == 'master' ? '90' : '30'))
    }
    stages {
        stage('Checkout') {
            when {
                anyOf { branch 'master'; branch 'develop'; branch 'staging' }
            }
            steps {
                echo 'Checking out from Git'
                checkout scm
            }
        }
        stage('Code review') {
            environment {
                scannerHome = tool 'sonarQubeScanner'
            }
            when {
                anyOf { branch 'master'; branch 'develop'; branch 'staging' }
            }
            steps {
                withSonarQubeEnv('sonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Build and Deploy') {
            environment {
                KUBECONFIG = "${env.JENKINS_HOME}/workspace/${env.BRANCH_NAME}/kube-logistic/config"
                GOPATH = "${env.JENKINS_HOME}/workspace/${env.BRANCH_NAME}"
                PATH = "${env.GOPATH}/bin:${env.PATH}"
                VERSION_PREFIX = '1.3'
            }
            stages {
                stage('Deploy to development') {
                    when {
                        branch 'develop'
                    }
                    environment {
                        ALPHA = "${env.VERSION_PREFIX}-alpha${env.BUILD_NUMBER}"
                        NAMESPACE="logistic-dev-0304"
                    }
                    steps {
                        sh 'chmod +x build.sh'
                        sh './build.sh $ALPHA'
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh $ALPHA $NAMESPACE default'
                    }
                }
                stage('Deploy to staging') {
                    when {
                        branch 'staging'
                    }
                    environment {
                        BETA = "${env.VERSION_PREFIX}-beta${env.BUILD_NUMBER}"
                        NAMESPACE="logistic-dev-0304"
                    }
                    steps {
                        sh 'chmod +x build.sh'
                        sh './build.sh $BETA'
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh $BETA $NAMESPACE staging'
                    }
                }
                stage('Deploy to production') {
                    when {
                        branch 'master'
                    }
                    environment {
                        VERSION = VersionNumber([
                            versionNumberString: '${BUILDS_ALL_TIME}',
                            worstResultForIncrement: 'SUCCESS',
                            versionPrefix : '1.3.'
                        ]);
                        NAMESPACE="logistic-prd-0304"
                    }
                    steps {
                        sh 'chmod +x build.sh'
                        sh './build.sh $VERSION'
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh $VERSION $NAMESPACE default'
                    }
                }
            }
        }
    }
    post {
        success {
            slackSend color: '#00FF00', message: "Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} SUCCESS (<${env.BUILD_URL}|Open>)"
        }
        failure {
            slackSend color: '#FF0000', message: "Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} FAILED (<${env.BUILD_URL}|Open>)"
        }
    }
}
