# docker-compose-ghost-quickstart
Ghost blogging platform quick start with docker compose

Quick start docker composition of Ghost blog with Node, NGINX proxy with SSL and mysql database.

## Operating ENV
- **Operating System** RHEL 5.7 

- **docker** version 1.12.2

- **docker-compose** version 1.9.0

## The Stack
- Node.js
    - Ghost blog software
- NGINX
    - proxying port 80 calls to the Node web server on port 2368
- MySQL database
    - using UTFMB4 encoding (MySQL's UTF8 implementation was limited. UTFMB4 includes Emoji)

## Preparation
- A server somewhere, like Amazon EC2 , Google Compute Cloud or a virutal machine connected to your own network
- Register a domain name (either public or within your own network).
- A pair of SSL certificate and key for your domain.
- Access to your domain's DNS.

## How to Use It
0. Clone this project to the server's filesystem.
0. Edit environment settings in docker-compose.yml
    - WEB-DOMAIN in ghost service (Your registered domain)
    - Database settings - in 2 places - under ghost, and under mysql.
0. Add your SSL certificate and key to ./nginx/ssl 
0. Set the domain (server_name) in ./nginx/conf/ghost.conf (must match the common name in your SSL certificate)
0. Run from within your Linux environment or Docker Toolbox environment: 
    0. docker-compose build
    0. docker-compose up -d  (you can remove the -d if you want to see logs, then Ctrl+C to stop all containers)
0. Switch your domain's DNS to point to the address. Go to the domain in our browser and you'll see your new blog.
0. Go to https://YOUR_DOMAIN/admin to set up your blog.
0. Once you've made your admin account using that wizard, go back to: https://YOUR_DOMAIN/admin
0. Log in and enjoy.

## How to back up your database
0. Run "docker-compose ps" to get a list of running containers.
0. Locate the name of the mysql container.
0. Run this command to get the container's internal IP: docker inspect --format='{{.NetworkSettings.IPAddress}}' THAT_CONTAINER-NAME
0. In your favorite database GUI tool (like Navicat or DataGrip), create a new connection via SSH tunnel to the host machine
0. Use the internal IP address and database user and password to connect to database once SSH tunnel is established to host.
0. You'll have access to the data so you can view data and run backups.


### To install another theme

Stop docker-compose with:
```docker-compose stop```

Copy the new theme to ./ghost/content/theme

so that your theme folder sits next to the casper folder in the themes directory

Now run:
```docker-compose up -d```

Log in to the Ghost admin, go to Settings > General, and at the bottom is the Theme dropdown. Select your theme and click Save.

### How does that work?

The ./ghost/content directory (on docker host machine) gets mounted inside your ghost container at /var/lib/ghost when the container runs. See the docker-compose.yml to see where this mount is happening.

## Security

- Only NGINX's ports (443) are exposed at host level.

## License 
[MIT LICENSE ](https://github.com/robincher/docker-compose-ghost-quickstart/blob/master/LICENSE)

## References:
+ [Docker Compose for Ghost by John Washam](https://github.com/jwasham/docker-ghost-template)
+ [Ghost @ Dockerhub](https://hub.docker.com/_/ghost/)

