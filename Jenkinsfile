def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: label, serviceAccount: "jenkins", cloud: "example", yaml: """
apiVersion: v1 
kind: Pod 
metadata: 
    name: jenkins-slave-nodejs 
spec: 
    containers: 
      - name: jnlp 
        image: tlitovsk/jenkins-jnlp:latest
        imagePullPolicy: Always
        env: 
          - name: DOCKER_HOST 
            value: tcp://localhost:2375 
      - name: dind-daemon 
        image: docker:18-dind 
        resources: 
            requests: 
                cpu: 20m 
                memory: 512Mi 
        securityContext: 
            privileged: true 
        volumeMounts: 
          - name: docker-graph-storage 
            mountPath: /var/lib/docker 
    volumes: 
      - name: docker-graph-storage 
        emptyDir: {}
"""
)
{
    node(label) {
        try {
            stage('Checkout'){
                checkout scm
            }

            stage('Lint Dockerfiles')
            {
                sh 'dockerlint Dockerfile'
            }

            stage('Build'){
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub'){
                        def hello_image = docker.build("tlitovsk/k8sdebug:latest")
                        currentBuild.result = "SUCCESS"
                        if (env.BRANCH_NAME == 'master') {
                            hello_image.push()
                        }
                    }
            }
        }
        catch (err) {

            currentBuild.result = "FAILURE"
            throw err
        }

    }
}