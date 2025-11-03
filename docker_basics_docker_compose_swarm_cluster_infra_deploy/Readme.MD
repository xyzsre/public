

Basics Fundamentals of ...
Docker + 
Docker Compose + 
Docker Swarm and Cluster Infrastructure Deployment
for Network / System / Cloud / DevOps / SRE Engineers

Topics:
- What is Docker?
- Docker Advantages
- Docker Compose
- Docker Swarm
- How to Install Docker on Windows?
- How to Install Docker on Linux?
- How to List Containers?
- How to Start Stop Remove Containers in Docker?
- How to Search Docker Images Download Run Interactive Mode Detach Attach & Stop?
- How to Run Nginx Container in Docker and Expose HTTP Port?
- How to Run PHP Container Using Data Volume in Docker?
- How to Build Dockerfile HTML Application Container Using Node JS?
- How to Execute Commands in Running Container in Docker?
- How to Install Docker Compose on Ubuntu?
- Docker Compose Example - Wordpress and MySQL
- How to Install Docker Swarm Cluster? and Deploy Application Replicas & Scaling?


Docker is a containerization platform that enables developers to package applications and their dependencies into lightweight, portable containers. These containers can run consistently across various environments, facilitating efficient development, testing, and deployment processes.

Docker Swarm, an orchestration tool integrated into Docker, extends these capabilities by allowing the management of multiple Docker hosts as a single virtual system. In a Docker Swarm cluster infrastructure deployment, multiple machines, or nodes, collaborate to form a unified cluster.

Docker Swarm employs a manager-worker architecture, where the manager node orchestrates the deployment and scaling of applications, distributing tasks across worker nodes. This cluster infrastructure enhances application availability, scalability, and resilience by seamlessly managing containerized services across the network. It automates load balancing, service discovery, and rolling updates, simplifying the complexities of deploying and maintaining containerized applications at scale. Docker Swarm thus empowers organizations to harness the full potential of containerization, streamlining the development and operation of distributed applications in a reliable and scalable manner.



![Alt text](image_01.png)

What is Docker?

Docker is a platform designed to make it easier to develop, deploy, and run applications by using containers. Containers allow a developer to package up an application with all parts it needs, such as libraries and other dependencies, and ship it all out as one package. This ensures that the application will run on any Linux machine, regardless of any customized settings that machine might have that could differ from the machine used for writing and testing the code.

Key components and concepts of Docker include:

1. **Containerization:** Docker uses container technology, which encapsulates the application and its dependencies into a lightweight, portable container. Containers provide consistency across different environments and ensure that the application runs the same way in development, testing, and production.

2. **Docker Engine:** The Docker Engine is the core software responsible for building and running containers. It includes a daemon process (`dockerd`) that manages containers, images, networks, and volumes. Users interact with the Docker Engine through the Docker CLI (Command Line Interface) or a GUI.

3. **Docker Image:** A Docker image is a lightweight, standalone, and executable package that includes the application code, runtime, libraries, and system tools required to run an application. Images are used to create containers.

4. **Docker Container:** A Docker container is an instance of a Docker image. It runs as a standalone, isolated process, and it encapsulates the application and its dependencies. Containers provide consistency and reproducibility across different environments.

5. **Docker Hub:** Docker Hub is a cloud-based registry service where you can share and distribute Docker images. It serves as a central repository for storing and managing Docker images, making it easy for developers to share and collaborate on containerized applications.

https://hub.docker.com/

6. **Docker Compose:** Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file to configure application services, networks, and volumes, enabling developers to define complex application stacks and deploy them easily.

7. **Orchestration:** Docker provides orchestration features for managing and scaling containerized applications. Docker Swarm and Kubernetes are popular tools for orchestrating containers in a cluster, ensuring high availability, load balancing, and efficient resource utilization.

Docker simplifies the process of building, shipping, and running applications, making it a widely used technology in the world of software development and deployment.




![Alt text](image_02.png)

Docker Advantages?!

Docker offers several advantages for software development, deployment, and operations. Here are some key benefits:

1. **Portability:**
   - Containers encapsulate applications and their dependencies, ensuring consistency across different environments. This portability makes it easy to develop, test, and deploy applications in various settings, from a developer's laptop to a production server.

2. **Isolation:**
   - Containers provide process and file system isolation, allowing applications to run independently without interfering with each other. This isolation improves security, reduces conflicts between dependencies, and enables the coexistence of multiple applications on the same host.

3. **Efficiency:**
   - Containers share the host OS kernel and use resources more efficiently compared to traditional virtualization. They have a lower overhead, resulting in faster startup times, reduced memory footprint, and improved overall system performance.

4. **Consistency:**
   - Docker ensures consistency between development, testing, and production environments. Developers can create a container image containing the application and its dependencies, and this same image can be used across different stages of the development lifecycle.

5. **Rapid Deployment:**
   - Containers can be started or stopped quickly, facilitating rapid application deployment and scaling. This agility is particularly valuable in dynamic and fast-paced development environments where quick iteration and release cycles are essential.

6. **Versioning and Rollback:**
   - Docker images can be versioned, enabling developers to track changes and roll back to previous versions if needed. This versioning capability supports easier collaboration, troubleshooting, and the ability to revert to a known working state.

7. **DevOps and Continuous Integration/Continuous Deployment (CI/CD):**
   - Docker facilitates DevOps practices by providing a consistent environment throughout the development and deployment pipeline. Containers can be seamlessly integrated into CI/CD workflows, enabling automated testing, deployment, and continuous delivery.

8. **Resource Optimization:**
   - Containers share the host OS kernel and utilize resources more efficiently than traditional virtual machines. Multiple containers can run on the same host without the need for separate OS instances, leading to better resource utilization and cost savings.

9. **Ecosystem and Community Support:**
   - Docker has a large and active community, contributing to a rich ecosystem of pre-built images and tools. Docker Hub serves as a centralized repository for sharing and discovering container images, streamlining the distribution of software components.

10. **Microservices Architecture:**
    - Docker is well-suited for microservices architectures, where applications are decomposed into smaller, independently deployable services. Containers make it easier to manage and scale individual microservices, promoting flexibility and scalability.

11. **Orchestration and Scaling:**
    - Docker provides orchestration tools like Docker Swarm and Kubernetes for managing and scaling containerized applications. These tools automate tasks such as load balancing, service discovery, and container scaling, simplifying the management of complex deployments.

Docker's advantages lie in its ability to enhance consistency, portability, efficiency, and collaboration throughout the software development and deployment lifecycle.







Install Docker on Windows?!

Solution 1: Install Docker on Windows
1. Download Docker Desktop From >> https://www.docker.com/products/docker-desktop/
2. Install Docker Desktop On Windows
3. More Information >> https://docs.docker.com/desktop/install/windows-install/
4. Test and Verify >> Docker Commands

Solution 2: Install VMware Workstation Player on Windows and Install Docker on Ubuntu 22.04 VM
1. Download VMware Workstation Player From >> https://www.vmware.com/nl/products/workstation-player/workstation-player-evaluation.html
2. Install VMware Workstation Player on Windows
3. Download Ubuntu Dekstop ISO File From >> https://releases.ubuntu.com/jammy/
4. Install Ubuntu 22.04 >> VMware Workstation Player
5. Install Docker on Ubuntu 22.04 VM
6. Test and Verify >> Docker Commands

Solution 3: Install Virtual Box on Windows and Install Docker on Ubuntu 22.04 VM
1. Download Virtual Box From >> https://www.virtualbox.org/wiki/Downloads
2. Install Virtual Box on Windows
3. Download Ubuntu Dekstop ISO File From >> https://releases.ubuntu.com/jammy/
4. Install Ubuntu 22.04 >> Virtual Box
5. Install Docker on Ubuntu 22.04 VM
6. Test and Verify >> Docker Commands

Solution 4 (Recommended): Install Virtual Box and Vagrant on Windows and Install Docker on Ubuntu 22.04 VM
Why? Because Easy to Install Multiple Servers and Docker + Docker Swarm and Cluster Infrastructure
1. Download Virtual Box From >> https://www.virtualbox.org/wiki/Downloads
2. Install Virtual Box on Windows
3. Download Vagrant From >> https://developer.hashicorp.com/vagrant/install
4. Install Vagrant on Windows
5. Start Ubuntu 22.04 VM >> Vagrant
6. Install Docker on Ubuntu 22.04 VM
7. Test and Verify >> Docker Commands
8. Destroy Ubuntu VM >> If You Do Not Need Anymore!
9. Check Other OS Images >> Vagrant Cloud >> https://app.vagrantup.com/boxes/search


****************************************
Vagrant Commands >>>>

vagrant help

vagrant global-status

vagrant init

vagrant up

vagrant ssh ubuntu1

vagrant destroy ubuntu1


****************************************
Ubuntu Commands & Docker Installation Commands on Ubuntu 22.04 >>>

ip addr

sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce -y

systemctl status docker

sudo usermod -aG docker ${USER}

newgrp docker


****************************************
Docker Test Commands >>>>

docker ps -a

docker run hello-world








Install Docker on Linux?!


Solution 1: Install Docker on Linux
1. Install Docker on Ubuntu 22.04 Desktop (Example)
4. Test and Verify >> Docker Commands

Solution 2: Install VMware Workstation Player on Linux and Install Docker on Ubuntu 22.04 VM
1. Download VMware Workstation Player From >> https://www.vmware.com/nl/products/workstation-player/workstation-player-evaluation.html
2. Install VMware Workstation Player on Linux
3. Download Ubuntu Dekstop ISO File From >> https://releases.ubuntu.com/jammy/
4. Install Ubuntu 22.04 >> VMware Workstation Player
5. Install Docker on Ubuntu 22.04 VM
6. Test and Verify >> Docker Commands

Solution 3: Install Virtual Box on Linux and Install Docker on Ubuntu 22.04 VM
1. Download Virtual Box From >> https://www.virtualbox.org/wiki/Downloads
2. Install Virtual Box on Linux
3. Download Ubuntu Dekstop ISO File From >> https://releases.ubuntu.com/jammy/
4. Install Ubuntu 22.04 >> Virtual Box
5. Install Docker on Ubuntu 22.04 VM
6. Test and Verify >> Docker Commands

Solution 4 (Recommended): Install Virtual Box and Vagrant on Linux and Install Docker on Ubuntu 22.04 VM
Why? Because Easy to Install Multiple Servers and Docker + Docker Swarm and Cluster Infrastructure
1. Download Virtual Box From >> https://www.virtualbox.org/wiki/Downloads
2. Install Virtual Box on Linux
3. Download Vagrant From >> https://developer.hashicorp.com/vagrant/install
4. Install Vagrant on Linux
5. Start Ubuntu 22.04 VM >> Vagrant
6. Install Docker on Ubuntu 22.04 VM
7. Test and Verify >> Docker Commands
8. Destroy Ubuntu VM >> If You Do Not Need Anymore!
9. Check Other OS Images >> Vagrant Cloud >> https://app.vagrantup.com/boxes/search


****************************************
Solution 4 Commands >>>>

sudo apt update -y

wget https://www.virtualbox.org/download/oracle_vbox_2016.asc 

cat oracle_vbox_2016.asc | gpg --dearmor | sudo tee /usr/share/keyrings/virtualbox.gpg > /dev/null 2>&1

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib' | sudo tee -a /etc/apt/sources.list.d/virtualbox.list

sudo apt update && sudo apt install virtualbox-7.0 -y

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install vagrant -y


****************************************
Vagrant Commands >>>>

vagrant help

vagrant global-status

vagrant init

vagrant up

vagrant ssh ubuntu1

vagrant destroy ubuntu1


****************************************
Ubuntu Commands & Docker Installation Commands on Ubuntu 22.04 >>>

ip addr

sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce -y

systemctl status docker

sudo usermod -aG docker ${USER}

newgrp docker


****************************************
Docker Test Commands >>>>

docker ps -a

docker run hello-world






How to List Containers in Docker? 
How to Start Stop Remove Containers? 
How to Remove All Containers not Running in Docker?

Commands for listing containers, starting/stopping/removing containers, and removing all containers that are not running in Docker:

### List Containers:

To list all running containers:

```bash
docker ps
```

To list all containers (including stopped ones):

```bash
docker ps -a
```

### Start, Stop, Remove Containers:

#### Start a Container:

```bash
docker start <container_id_or_name>
```

#### Stop a Container:

```bash
docker stop <container_id_or_name>
```

#### Remove a Container:

To remove a stopped container:

```bash
docker rm <container_id_or_name>
```

To forcefully remove a running container, you can use the `-f` flag:

```bash
docker rm -f <container_id_or_name>
```

### Remove All Containers not Running:

To remove all stopped containers:

```bash
docker container prune
```

This command will prompt you to confirm the removal of all stopped containers.

If you want to remove all containers (both running and stopped) without confirmation, you can use the `-f` flag:

```bash
docker container prune -f
```

Be cautious when using the `-f` flag, as it removes all containers without confirmation.






How to Search Docker Images for Alpine and Download Image? 
How to Run Alpine Container in Interactive Mode? 
How to Detach from Alpine Container? 
How to Stop Alpine Container? 

Commands to search for, download, run, detach from, and stop an Alpine container in Docker:

### Search Docker Images for Alpine and Download Image:

To search for Alpine images on Docker Hub:

```bash
docker search alpine
```

To download the latest Alpine image:

```bash
docker pull alpine
```

### Run Alpine Container in Interactive Mode:

To run an Alpine container in interactive mode:

```bash
docker run -it alpine /bin/sh
```

This command starts an Alpine container and opens an interactive shell (`/bin/sh`). The `-it` flags allow you to interact with the container.

### Detach from Alpine Container:

To detach from the running Alpine container without stopping it, you can press `Ctrl + P` followed by `Ctrl + Q`. This will leave the container running in the background.

### Stop Alpine Container:

To stop a running Alpine container:

```bash
docker stop <container_id_or_name>
```

Replace `<container_id_or_name>` with the actual ID or name of your Alpine container.

### Notes:

- When you run the Alpine container in interactive mode (`/bin/sh`), you are dropped into the shell within the container. You can execute commands and interact with the Alpine environment.

- If you want to run a specific command and then exit, you can provide that command as an argument. For example, to run a simple `echo` command:

  ```bash
  docker run alpine echo "Hello, Alpine!"
  ```

To attach to a running container in Docker, you can use the `docker attach` command. Here's how you can do it:

1. **Get the Container ID or Name:**
   First, you need to know the ID or name of the running container. You can find this information using the `docker ps` command:

   ```bash
   docker ps
   ```

   This command will display a list of running containers along with their IDs, names, and other details.

2. **Attach to the Container:**
   Use the `docker attach` command to attach to the running container. Replace `<container_id_or_name>` with the actual ID or name of your container:

   ```bash
   docker attach <container_id_or_name>
   ```

   For example:

   ```bash
   docker attach my_running_container
   ```

3. **Detach from the Container:**
   To detach from the attached container without stopping it, you can press `Ctrl + P` followed by `Ctrl + Q`. This will leave the container running in the background.

Keep in mind that when you attach to a running container, you are connected to the primary process in that container. If the process exits, the container will stop.

If you want to run additional commands in the container or interact with a different shell, consider using the `docker exec` command. For example:

```bash
docker exec -it <container_id_or_name> /bin/sh
```

This command opens an interactive shell (`/bin/sh`) in the specified container. Replace `<container_id_or_name>` with the actual ID or name of your container.




How to Run Nginx Container Sample in Docker and Expose HTTP Port?


To run an Nginx container in Docker and expose the HTTP port, you can use the following steps:

1. **Pull the Nginx Image:**
   If you haven't already, pull the official Nginx image from Docker Hub:

   ```bash
   docker pull nginx
   ```

2. **Run Nginx Container:**
   Run a new Nginx container and expose the default HTTP port (port 80) on the host:

   ```bash
   docker run -d -p 80:80 --name my_nginx nginx
   ```

   - `-d`: Run the container in the background (detached mode).
   - `-p 80:80`: Map port 80 on the host to port 80 in the container.
   - `--name my_nginx`: Assign a name to the container (replace "my_nginx" with your preferred name).
   - `nginx`: The name of the image.

3. **Access Nginx:**
   Open a web browser or use a tool like curl to access Nginx at `http://localhost`. If you specified a different container name or used a remote host, replace `localhost` with the appropriate hostname or IP address.

   ```bash
   curl http://localhost
   ```

   You should see the default Nginx welcome page.

4. **Stop and Remove the Container (Optional):**
   If you want to stop and remove the Nginx container when you're done:

   ```bash
   docker stop my_nginx
   docker rm my_nginx
   ```

   Replace "my_nginx" with the actual name you used when running the container.





How to Run PHP Container Using Data Volume?


To run a PHP container with a simple "Hello, World!" example using a data volume for the container and expose port 80, you can follow these steps:

1. **Create a Directory for PHP Files:**
   Create a directory on your host machine where you'll store your PHP files. For example, let's create a directory named `php-app`:

   ```bash
   mkdir php-app
   ```

2. **Create index.php:**
   Inside the `php-app` directory, create a file named `index.php` with the following content:

   ```php
   <?php
   echo "Hello, World!";
   ?>
   ```

3. **Run PHP Container:**
   Run a PHP container, mounting the `php-app` directory as a data volume and exposing port 80:

   ```bash
   docker run -d -p 80:80 -v $(pwd)/php-app:/var/www/html --name my_php_container php:apache
   ```

   - `-d`: Run the container in the background (detached mode).
   - `-p 80:80`: Map port 80 on the host to port 80 in the container.
   - `-v $(pwd)/php-app:/var/www/html`: Mount the `php-app` directory as a data volume at `/var/www/html` in the container.
   - `--name my_php_container`: Assign a name to the container (replace "my_php_container" with your preferred name).
   - `php:apache`: Use the official PHP image with Apache.

4. **Access PHP Application:**
   Open a web browser or use a tool like curl to access the PHP application at `http://localhost`. If you specified a different container name or used a remote host, replace `localhost` with the appropriate hostname or IP address.

   ```bash
   curl http://localhost
   ```

   You should see "Hello, World!" displayed.

5. **Stop and Remove the Container (Optional):**
   If you want to stop and remove the PHP container when you're done:

   ```bash
   docker stop my_php_container
   docker rm my_php_container
   ```

   Replace "my_php_container" with the actual name you used when running the container.

This example uses the official PHP image with Apache and mounts the `php-app` directory as a data volume, allowing changes in the host's `php-app` directory to be reflected inside the container. 




How to Build Dockerfile Simple HTML Application Container Using Node JS?


To build a Dockerfile that runs a simple HTML "Hello, World!" application and exposes port 80, follow these steps:

1. **Create an HTML File:**
   Create a simple HTML file named `index.html` with the following content:

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Hello, World!</title>
   </head>
   <body>
       <h1>Hello, World!</h1>
   </body>
   </html>
   ```

2. **Create a Dockerfile:**
   Create a Dockerfile in the same directory as your HTML file with the following content:

   ```Dockerfile
   # Use an official lightweight Node.js image
   FROM node:14-alpine

   # Set the working directory to /app
   WORKDIR /app

   # Copy index.html file into the container at /app
   COPY index.html /app

   # Expose port 80 to the outside world
   EXPOSE 80

   # Define environment variable
   ENV NAME World

   # Run a simple HTTP server to serve the HTML file
   CMD ["npx", "http-server", "-p", "80"]
   ```

   This Dockerfile uses the Node.js Alpine image, copies index.html file, exposes port 80, and runs the `http-server` command to serve the HTML file.

3. **Build and Run Docker Container:**
   Build the Docker image and run the container:

   ```bash
   docker build -t hello-html .
   docker run -d -p 80:80 hello-html
   ```

4. **Access HTML Application:**
   Open a web browser or use a tool like curl to access the HTML application at `http://localhost`. If you specified a different container name or used a remote host, replace `localhost` with the appropriate hostname or IP address.

   ```bash
   curl http://localhost
   ```

   You should see "Hello, World!" displayed.

5. **Stop and Remove the Container (Optional):**
   If you want to stop and remove the Docker container when you're done:

   ```bash
   docker stop <container_id_or_name>
   docker rm <container_id_or_name>
   ```

   Replace `<container_id_or_name>` with the actual ID or name of your Docker container.

This example uses a lightweight Node.js image to serve a simple HTML file. 





How to Execute Commands in Running Container in Docker?


Here's an example to execute commands in a container:

1. **Run an Nginx Container:**
   First, run an Nginx container in the background:

   ```bash
   docker run -d -p 80:80 --name my_nginx nginx
   ```

   This command starts an Nginx container in detached mode with the name "my_nginx."

2. **Run Commands:**
   Use `docker exec` to run commands inside the Nginx container.

   - To create an empty file named `test.txt` using the `touch` command:

     ```bash
     docker exec -it my_nginx sh -c 'touch /usr/share/nginx/html/test.txt'
     ```

   - To list the files in the Nginx container's HTML directory using the `ls` command:

     ```bash
     docker exec -it my_nginx sh -c 'ls /usr/share/nginx/html'
     ```

   - To view the contents of the `test.txt` file using the `cat` command:

     ```bash
     docker exec -it my_nginx sh -c 'cat /usr/share/nginx/html/test.txt'
     ```

3. **Cleanup (Optional):**
   If you no longer need the containers, you can stop and remove them:

   ```bash
   docker stop my_nginx
   docker rm my_nginx
   ```




![Alt text](image_03.png)

Docker Compose?!

Docker Compose is a tool that allows you to define and run multi-container Docker applications. With Docker Compose, you can describe the services, networks, and volumes required for your application in a single YAML file, making it easy to manage and deploy complex, multi-container setups.

Key features and concepts of Docker Compose include:

1. **Docker Compose YAML File:**
   - Docker Compose configurations are defined in a YAML file (`docker-compose.yml`). This file specifies the services, networks, and volumes required for your application, as well as their configurations and relationships.

2. **Services:**
   - Each service in a Docker Compose file represents a containerized application component. For example, you might define services for a web application, a database, and a message queue. Each service is configured with its own image, ports, environment variables, and other settings.

3. **Networks:**
   - Docker Compose allows you to define custom networks that connect your services. This enables communication between containers while providing isolation. By default, Docker Compose creates a default network for all services in a Compose file.

4. **Volumes:**
   - Volumes in Docker Compose enable persistent data storage. You can define named volumes or bind mounts for services that require data persistence, ensuring that data is retained even if the containers are stopped or removed.

5. **Environment Variables:**
   - Docker Compose supports the definition of environment variables for services. This allows you to parameterize your application configurations, making it easier to manage different deployment environments.

6. **Command Line Interface (CLI):**
   - Docker Compose provides a command-line interface (`docker-compose`) that allows you to manage the entire lifecycle of your multi-container application. Common commands include `up` (start services), `down` (stop and remove services), `ps` (list services), and `logs` (view container logs).

7. **Scaling:**
   - Docker Compose enables easy scaling of services. You can specify the desired number of replicas for each service, and Docker Compose will create and manage the specified number of container instances.

8. **Health Checks:**
   - Docker Compose supports defining health checks for services. Health checks allow Docker Compose to verify the health of a service based on custom conditions, helping to ensure the availability of your application.

9. **Extensibility:**
   - Docker Compose can be extended through the use of plugins. Plugins can add additional functionality or integrate with external services, enhancing the capabilities of Docker Compose.

Docker Compose simplifies the process of managing and orchestrating multi-container applications, making it easier for developers and operators to define, deploy, and scale complex environments. It is particularly valuable for local development, testing, and small to medium-sized production deployments.




How to Install Docker Compose on Ubuntu?


sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

docker-compose --version







Docker Compose Example for Wordpress using HTTP with MySQL

An example `docker-compose.yml` file for setting up WordPress with MySQL using HTTP. This example uses official Docker images for WordPress and MySQL.

Create a file named `docker-compose.yml` with the following content:

```yaml
version: '3.8'

services:
  wordpress:
    image: wordpress
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress:/var/www/html

  mysql:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
      MYSQL_ROOT_PASSWORD: rootpassword
    volumes:
      - mysql:/var/lib/mysql

volumes:
  wordpress:
  mysql:
```

This `docker-compose.yml` file defines two services: `wordpress` and `mysql`. It also declares two volumes to persist data for WordPress and MySQL.

Explanation:

- The `wordpress` service uses the official WordPress image. It exposes port 80, and environment variables are set to configure the WordPress database connection.

- The `mysql` service uses the official MySQL 5.7 image. Environment variables are set to configure the MySQL database, user, and password.

- Volumes are used to persist data for WordPress and MySQL so that data is not lost when containers are stopped or removed.

To deploy the WordPress application, navigate to the directory where the `docker-compose.yml` file is located and run the following command:

```bash
docker-compose up -d
```

This command will download the necessary images and start the containers in the background. Once the containers are running, you can access the WordPress site by visiting `http://localhost` in your web browser.

To stop the containers, run:

```bash
docker-compose down
```

In a production environment, you should consider using secure passwords, configuring additional settings, and possibly using a reverse proxy with HTTPS for secure communication.




Docker Swarm?!

Docker Swarm is a native clustering and orchestration solution for Docker. It enables you to create and manage a swarm of Docker nodes, turning them into a single, virtual Docker host. This virtual host can be used to deploy and manage distributed, multi-container applications at scale.

Key features and concepts of Docker Swarm include:

1. **Node:**
   - A node in Docker Swarm is an individual Docker host that participates in the swarm. Nodes can be physical machines or virtual machines. They work together to form a unified cluster.

2. **Manager Node:**
   - In a Docker Swarm, one or more nodes are designated as manager nodes. Manager nodes are responsible for handling the orchestration of services, managing the swarm state, and ensuring the overall health and availability of the cluster.

3. **Worker Node:**
   - Nodes that are not manager nodes are classified as worker nodes. Worker nodes run containers and execute the tasks assigned to them by the manager nodes. Worker nodes do not participate in the orchestration decisions but execute the workload.

4. **Service:**
   - A service in Docker Swarm is a definition for a containerized application, including the image, configuration, and desired scale. Services allow you to define the characteristics of your application and let Docker Swarm manage the deployment and scaling.

5. **Task:**
   - A task is the smallest unit of work in Docker Swarm. Each task represents a running container on a worker node. The manager nodes schedule and distribute tasks to worker nodes based on the defined service specifications.

6. **Load Balancing:**
   - Docker Swarm provides built-in load balancing for services. Traffic directed to a service is automatically load-balanced across all available replicas of the service.

7. **Overlay Network:**
   - Docker Swarm uses overlay networks to enable communication between containers running on different nodes. Overlay networks provide multi-host connectivity, allowing containers to communicate seamlessly as if they were on the same host.

8. **Swarm Mode:**
   - Docker Swarm operates in "Swarm mode," a built-in orchestration mode that simplifies the management of containerized applications across a cluster. Swarm mode introduces new commands (`docker swarm`) and capabilities for creating and managing swarms.

9. **Stack Deployment:**
   - Docker Swarm supports the deployment of entire applications, including multiple services, using Docker Compose files. This allows you to define and deploy complex, multi-service applications in a consistent manner.

10. **High Availability:**
    - Docker Swarm provides high availability by distributing manager nodes across multiple hosts. If a manager node fails, another manager node takes over, ensuring the continued operation of the swarm.

11. **Security:**
    - Swarm incorporates security features such as mutual TLS authentication for communication between nodes, ensuring that communication within the swarm is secure.

Docker Swarm simplifies the deployment and scaling of containerized applications across a cluster of machines, making it a suitable solution for organizations looking to manage containers in a production environment. While Docker Swarm is a powerful and easy-to-use orchestration tool, it's worth noting that Kubernetes has gained significant popularity and is another popular choice for container orchestration in more complex scenarios.





How To Install Docker Swarm On Ubuntu? 
And Create Docker Swarm Cluster? 
And Deploy Application in the Cluster! 
And Replicas and Scaling the Service!


Docker swarm is a tool used to create a cluster of docker hosts. With docker swarm, we can create a high availability and high performance cluster where applications are distributed among the hosts. Docker swarm consists of a manager and worker nodes and operations are performed from the manager.


********************
Step 1 >> Configure 3 Ubuntu VMs
1. Configure Vagrantfile
2. vagrant global-status
3. vagrant up
4. vagrant ssh ubuntu1
5. vagrant ssh ubuntu2
6. vagrant ssh ubuntu3


********************
Step 2 >> Prepare Your Nodes

** In my set up, I have one manager node and two worker nodes. On each host, configure hosts file to include all the other nodes.

sudo vim /etc/hosts

** Add the following content to the file (example - replace with your ubuntu vm IP addresses)

192.168.1.10	manager

192.168.1.11	worker-01

192.168.1.12	worker-02

** Save the file. Ensure that you can ping all the hosts from each host using hostname and not IP address.


********************
Step 3 >> Install Docker Container Engine >> on 3 Ubuntu VMs

sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update -y

apt-cache policy docker-ce

sudo apt install docker-ce -y

systemctl status docker

sudo usermod -aG docker ${USER}

newgrp docker


********************
Step 4 >> Create Docker Swarm Cluster

** To set up swarm cluster, we first need to initialize Docker Swarm mode on the manager node then add the worker nodes to the cluster.

** Get interface IP address

ip address

** For me the interface for which Docker manager will advertise on is enp1s0

INT_NAME="enp1s0" #replace accordingly

HOST_IP=$(ip addr show $INT_NAME | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

** Confirm IP address is saved correctly

echo $HOST_IP

** Run the below command to initialize Docker swarm node on the manager.

sudo docker swarm init --advertise-addr $HOST_IP


********************
Step 5 >> Join Worker Nodes to the Cluster

** We are now going to add the worker-01 and worker-02 nodes to the cluster manager using the join-token from the cluster manager node.

** Run the command printed in the init command output.

** Example Below (Replace token and IP with your own config)

sudo docker swarm join --token SWMTKN-1-13xo81gxpb3ttjh5e335pfrmz9fbnliikgfys7u8l4r8k4m575-2gsjwjs3y1i4kgeua2yu840hw 192.168.1.10:2377

** Check if the worker nodes are successfully added to the cluster by running the below command on the manager:

sudo docker node ls


********************
Step 6 >> Deploy application in the Cluster - Replicas and Scaling the Service

** Let’s create a service Nginx web server to run on default http port 80, and then expose it to the port 80 on the host.

sudo docker service create --name web-server --publish 80:80 nginx:1.13-alpine

** Confirm the created service by running the below command:

sudo docker service ls

** We are going to make 3 replicas of the web-server service so that it is accessible on the manager and the two worker nodes.

sudo docker service scale web-server=3

** Confirm created service replicas

sudo docker service ls

** Access the service from your browser using all the nodes IPs: http://192.168.1.10:80, http://192.168.1.11:80 and http://192.168.1.12:80 and you should get a nginx welcome page (this is an example - replace IP addresses with your own IP addresses)



