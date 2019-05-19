# Part 1
## Start from: https://github.com/SAP/cloud-bulletinboard-ads
### Branch: solution-11-Develop-Custom-Queries
### Demo for this branch after deployed to CF:
* List all [GET] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads>
* Add one [POST] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads>

  ```json
  {
    "title": "test"
  }
  ````
* Update one [PUT] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads/{id}>

  ```json
  {
      "title": "test3update",
      "id": "3",
      "metadata": {
          "version": "2"
      }
  }
  ```
* Delete one [DELETE] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads/{id}>
## Target 1: Debug it on CF
Reference
---
* [JDWP](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/introclientissues005.html)
* [JPDA](https://docs.oracle.com/javase/8/docs/technotes/guides/jpda/conninv.html#Invocation)
* [Java HotSpot VM Options](https://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html)
* [-X Command-line Options](https://docs.oracle.com/cd/E13150_01/jrockit_jvm/jrockit/jrdocs/refman/optionX.html)
* [New Cloud Foundry Java Buildpack Improves Developer Diagnostic Tools](https://content.pivotal.io/blog/new-cloud-foundry-java-buildpack-improves-developer-diagnostic-tools)
* [What are Java command line options to set to allow JVM to be remotely debugged?](https://stackoverflow.com/questions/138511/what-are-java-command-line-options-to-set-to-allow-jvm-to-be-remotely-debugged)
* [How do I use the JAVA_OPTS environment variable?](https://stackoverflow.com/questions/5241743/how-do-i-use-the-java-opts-environment-variable)
* [Accessing Apps with SSH](https://docs.cloudfoundry.org/devguide/deploy-apps/ssh-apps.html)
---
We <span style="color:red;">cannot</span> debug use the same process on CF.

We need use <span style="color:blue;">remote debug</span>.
1. CF provide an easy way

set environment variable ***JBP_CONFIG_DEBUG*** to ***{enabled: true}***

cf set-env bill-bulletinboard-ads JBP_CONFIG_DEBUG '{enabled: true}'

cf ssh -L ***8000:localhost:8000*** bill-bulletinboard-ads

2. Use original way

add arguments ***-Xdebug -Xrunjdwp*** to jvm

cf set-env bill-bulletinboard-ads JAVA_OPTS '-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8999'
## Target 2: Debug it on local
**Exclusion**

How does docker design, work and implement
### What is docker
Docker is a computer **program** that performs **operating-system-level virtualization**. It was first released in 2013 and is developed by Docker, Inc.

Docker is used to run **software packages** called ***containers***. Containers are **isolated** from each other and bundle their **own** application, tools, libraries and configuration files; they can **communicate** with each other through well-defined channels. All containers are run by a single operating-system kernel and are thus more **lightweight** than virtual machines. Containers are created from ***images*** that specify their precise contents. Images are often created by *combining and modifying standard images* downloaded from public repositories.

![Virtual Machine](https://raw.githubusercontent.com/trulliandloeb/docker-cf-local-hands-on/master/resource/VM%402x.png)

![Container](https://raw.githubusercontent.com/trulliandloeb/docker-cf-local-hands-on/master/resource/Container%402x.png)
---
**History**

Solomon Hykes started Docker in France as an internal project within dotCloud, a platform-as-a-service company, with initial contributions by other dotCloud engineers including Andrea Luzzardi and Francois-Xavier Bourlet. Jeff Lindsay also became involved as an independent collaborator. Docker represents an evolution of dotCloud's proprietary technology, which is itself built on earlier open-source projects such as Cloudlets.

The software debuted to the public in Santa Clara at PyCon in 2013.

Docker was released as open source in March 2013. On March 13, 2014, with the release of version 0.9, Docker dropped *LXC* as the default execution environment and replaced it with its *own libcontainer library written in the Go programming language*.

* On September 19, 2013, Red Hat and Docker announced a collaboration around Fedora, Red Hat Enterprise Linux, and OpenShift.
* In November 2014 Docker container services were announced for the Amazon Elastic Compute Cloud (EC2).
* On November 10, 2014, Docker announced a partnership with Stratoscale.
* On December 4, 2014, IBM announced a strategic partnership with Docker that enables Docker to integrate more closely with the IBM Cloud.
* On June 22, 2015, Docker and several other companies announced that they are working on a new vendor and operating-system-independent standard for software containers.
* As of October 24, 2015, the project had over 25,600 GitHub stars (making it the 20th most-starred GitHub project), over 6,800 forks, and nearly 1,100 contributors.
* In April 2016, Windocks, an independent ISV released a port of Docker's open source project to Windows, supporting Windows Server 2012 R2 and Server 2016, with all editions of SQL Server 2008 onward.
* A May 2016 analysis showed the following organizations as main contributors to Docker: The Docker team, Cisco, Google, Huawei, IBM, Microsoft, and Red Hat.
* On October 4, 2016, Solomon Hykes announced InfraKit as a new self-healing container infrastructure effort for Docker container environments.
* A January 2017 analysis of LinkedIn profile mentions showed Docker presence grew by 160% in 2016.
---
```shell
docker version
```
Hyper-v: use on Windows
### Image
> *If need* \<docker image rm hello-world\>
```shell
docker image pull hello-world
docker image ls -a
```
### Container
```shell
docker run hello-world
docker container ls -a
docker container start -i {container-id}
docker container rm {container-id}
```
### Start from [PostgreSQL](https://hub.docker.com/_/postgres)
```shell
docker run \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    postgres:9.4-alpine
```
Expose the port
```shell
docker run --rm \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    -p 127.0.0.1:5432:5432 \
    postgres:9.4-alpine
```
Use psql client in Docker
```shell
docker run --rm \
    --name some-postgres-client \
    -it \
    --network host \
    postgres:9.4-alpine psql \
    -h localhost -U testuser -d test
```
```SQL
\c
\d
CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);
INSERT INTO user_tbl(name, signup_date) VALUES('张三', '2013-12-22');
SELECT * FROM user_tbl;
\q
```
Better way to use psql
```shell
#if need
#docker network rm bill-network
docker network ls
docker network create bill-network
docker run --rm \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    --network bill-network \
    postgres:9.4-alpine
docker run --rm \
    --name some-postgres-client \
    -it \
    --network bill-network \
    postgres:9.4-alpine psql \
    -h some-postgres -U testuser -d test
```
Debug the app directly from local, expose the port

Debug from maven:
```shell
export MAVEN_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:8000'
mvn tomcat7:run
```
Debug from Tomcat:
```shell
cd path/to/tomcat
export CATALINA_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:8000'
./bin/catalina.sh start
tail -f ./logs/catalina.out
./bin/catalina.sh stop
```
### Reference
* <https://docs.docker.com/engine/reference/run/>
* <http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html>
* <https://labs.play-with-docker.com/>
* <https://docs.cloudfoundry.org/devguide/deploy-apps/push-docker.html>
## Target 3: Make a image and run local
What about make our app as a Docker image and run it?

---
1. Package app
2. Dockerfile
3. Build own image
4. Run
---
Dockerfile
```
FROM tomcat:8.5-alpine
COPY ./bulletinboard-ads.war /usr/local/tomcat/webapps/
```
```shell
docker image build -t bill-demo:0.0.1 .
```
```shell
docker run --rm -it \
    --network bill-network \
    -p 127.0.0.1:8080:8080 \
    -e VCAP_APPLICATION={} \
    -e USER_ROUTE=https://opensapcp5userservice.cfapps.eu10.hana.ondemand.com \
    -e APPENDER=STDOUT \
    -e LOG_APP_LEVEL=INFO \
    -e VCAP_SERVICES='{"postgresql-9.3":[{"name":"postgresql-lite","label":"postgresql-9.3","credentials":{"dbname":"test","hostname":"some-postgres","password":"test123!","port":"5432","uri":"postgres://testuser:test123!@some-postgres:5432/test","username":"testuser"},"tags":["relational","postgresql"],"plan":"free"}]}' \
    bill-demo
```
Make it root
```
FROM tomcat:8.5-alpine
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ./bulletinboard-ads.war /usr/local/tomcat/webapps/ROOT.war
```
Publish the image
```shell
docker image tag bill-demo:0.0.1 trulliandloeb/bill-demo:0.0.1
docker image push trulliandloeb/bill-demo:0.0.1
#another way
docker image build -t trulliandloeb/bill-demo:0.0.1 .
```
Push it to cloud foundry
```shell
# cf push APP-NAME --docker-image MY-PRIVATE-REGISTRY.DOMAIN:PORT/REPO/IMAGE:TAG
cf push bill-bulletinboard-ads-docker --docker-image trulliandloeb/bill-demo:0.0.1
cf bind-service bill-bulletinboard-ads-docker postgreSQLv9.4-dev
cf restage bill-bulletinboard-ads-docker
```
