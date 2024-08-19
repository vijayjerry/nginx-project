
NGINX Application Deployment

STEP 1 
Cloning repository
Cloned the given repository.

STEP 2
Files creation
Created the required files, such as:  
●	Dockerfile  
●	Docker-compose.yaml file  
●	Build.sh
●	Deploy.sh
      (File permissions were set.)

STEP 3
Check the image and container creation (locally)
Executed the files:  
- Docker image was created.  
- The container ran successfully.  
- Verified that the container is accessible via a browser using the host IP address.

STEP 4
GitHub
All the files were pushed to the GitHub dev and main branches.

STEP 5 
DOCKER HUB
●	Logged in to Docker Hub and created 2 repositories (dev, prod).
●	Dev is public repository prod is a private repository

STEP 6
JENKINS
●	Installed Jenkins on Ubuntu and accessed it via the host IP on port 8080.
●	The Jenkins file has been created for the pipeline.
●	The Jenkins file has been moved to the GitHub repository where I have the source file.
●	Installing the Jenkins plugins.
●	I configured the environment variables based on my Jenkins files

STEP 7
Creating new pipeline
●	Created an NGINX pipeline
●	Configured all the necessary configuration files

STEP 8
Pipeline Construction
●	The pipeline was built successfully.

STEP 9
Checking the pipeline output in Docker Hub
●	When code is fetched from the GitHub main branch, the image is successfully built and pushed to the Docker Hub prod (private) repository.
●	When code is fetched from the GitHub dev branch, the image is successfully built and pushed to the Docker Hub dev (public) repository.

STEP 10
Monitoring
The application is being monitored using a monitoring tool called Prometheus.



Url and image name
GitHub URL : https://github.com/vijayjerry/nginx-project.git
Docker hub URL: https://hub.docker.com/repositories/vijayjerry
Image Name: vijayjerry/prod:latest & vijayjerry/dev:latest

















