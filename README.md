# TALEND ADMINISTRATION SETUP

## Documentation
* [Building Talend Adminstration Center (TAC)](#build-instructions)
* [Running TAC](#running)

## [Building Talend Administration Center (TAC)](#build-instructions)
Building TAC requires the following:
* `license` file in root directory
* `amc.war, org.talend.administrator-6.1.1.war, Talend-DSC-20151214_1327-V6.1.1.war, talend-brms-6.1.1.war, tdqportal.war` placed in the `/webapps` directory.

## [Running TAC](#running)
### TAC Instructions
* [Run Options](#tac-options)
* [Requirements](#tac-requirements)
* [Ports](#tac-ports)
* [Environment Variables](#tac-vars)
* [Volumes](#tac-volumes)
* [Directory Structure](#tree)

### [Run Options](#tac-options)
TAC can be run in two different ways.

### `docker-compose`
To run TAC and all of its required containers using docker-compose simply download the docker-compose.yml
file to some arbitrary directory and execute the following command: `docker-compose up -d`.

```bash
    $ docker-compose up -d
    > Creating tac_nexus_1
    > Creating tac_elasticsearch_1
    > Creating tac_db_1
    > Creating tac_kibana_1
    > Creating tac_tac_1
```

### Manual/Individual Containers
TAC can also be started by starting each container manually.  Continue to [Requirements](#tac-requirements) for further information on this process.

### [Requirements](#tac-requirements)
Running TAC requires a few additional containers.  The containers are listed in
their required startup order.

`mysql:5.7.11`  
`{TAC IMAGE NAME}`  
`sontatype/nexus:2.12.0-01`  
`elasticsearch:2.2.0`  
`kibana:4.4.1`  

**NOTE:** Versions may be upgraded as required.

MySQL Run Command:

`docker run -td -v {exposed data dir/:/var/lib/mysql} -p 3306:3306 -e MYSQL_ROOT_PASSWORD='somepassword' -e MYSQL_DATABASE='talend_administrator' -e MYSQL_USER='tisadmin' -e MYSQL_PASSWORD='somepassword' mysql:5.7.11`


TAC Run Command:

`docker run -td -v {exposed log dir}:/logs -p 80:8080 -p 8050:8050 -p 9419:9419 -p 7890:7890 -e MYSQL_HOST="{MYSQL IP}" {TAC IMAGE NAME}`

Sonatype Nexus Run Command:

`docker run -td -p 8081:8081 sonatype/nexus:2.12.0-01`

Elasticsearch Run Command:

`docker run -td -v {exposed data dir}/:/usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 elasticsearch:2.2.0`

Kibana Run Command:

`docker run -td -p 5601:5601 --link {elasticsearch container name} kibana:4.4.1`

**NOTE**: Kibana requires that elastisearch be started first. Once elasticsearch is started you can link kibana to the running container.

### [Ports](#tac-ports)
The following is a list of containers and their exposed ports:

* tac:[7890, 80->8080, 8050, 9419]
* mysql:[3306]
* sonatype/nexus:[8081]
* elasticsearch:[9200, 9300]
* kibana:[5601]

### [Environment Variables](#tac-vars)
The following is a list of environment variables used with the TAC container.

####`MYSQL_HOST`
The IP of the MySQL server.  Default is `127.0.0.1`, this should be overridden at runtime if MySQL is not linked to TAC.

####`MYSQL_PORT`
The port to connect to on MySQL server.  Default is `3306`

####`MYSQL_DB`
The database to be used by TAC.  Default is `talend_administrator`

####`MYSQL_USER`
The user to connect to the db denoted by the `MYSQL_DB` variable.  Default is `tisadmin`.

####`MYSQL_PASSWORD`
The password to connect to the db denoted by the `MYSQL_DB` variable.  Default is `tisadmin`.

### [Volumes](#tac-volumes)
The following is a list of volumes that are exposed in the containers and should be mapped back to the system for ease of access.

* tac: /logs
* mysql: /var/lib/mysql
* sonatype/nexus: none
* elasticsearch: /usr/share/elasticsearch/data
* kibana: none

When executing TAC via docker-compose all volumes are mapped to user directory `~/{logs,data}`.  
If these directories do not exist they can be created by executing the following command: `sudo mkdir -p ~/{logs,data}`  

### [Directory Structure](#tree)
```bash
.
├── Dockerfile
├── README.md
├── brms
│   ├── conf
│   │   ├── btm-config.properties
│   │   └── resources.properties
│   ├── lib
│   │   ├── btm-2.1.4.jar
│   │   ├── btm-tomcat55-lifecycle-2.1.4.jar
│   │   ├── h2-1.3.161.jar
│   │   ├── javax.security.jacc-api-1.5.jar
│   │   ├── jta-1.1.jar
│   │   ├── kie-tomcat-integration-6.2.0.Final.jar
│   │   ├── slf4j-api-1.7.2.jar
│   │   └── slf4j-jdk14-1.7.2.jar
│   └── setenv.sh
├── conf
│   ├── server.xml
│   └── tomcat-users.xml
├── docker-compose.yml
├── dockerentry-point.sh
├── endorsed
│   ├── mysql-connector-java-5.1.38-bin.jar
│   └── talend-url-mvn-1.0.0.jar
├── license
├── scripts
│   └── tdqportal.sql
├── tdqportal
│   ├── lib
│   │   ├── casclient.jar
│   │   ├── commonj-twm.jar
│   │   ├── commons-logging-1.1.1.jar
│   │   ├── commons-logging-api-1.1.jar
│   │   ├── concurrent.jar
│   │   ├── foo-commonj.jar
│   │   ├── hsqldb.jar
│   │   ├── iijdbc.jar
│   │   └── sqltool.jar
│   ├── resources
│   │   ├── birt_messages
│   │   │   ├── messages.properties
│   │   │   ├── messages_en_US.properties
│   │   │   ├── messages_fr_FR.properties
│   │   │   └── messages_it_IT.properties
│   │   ├── idx
│   │   │   ├── _5i.cfs
│   │   │   ├── segments.gen
│   │   │   └── segments_2t
│   │   ├── img
│   │   │   ├── Logo_SpagoBI.gif
│   │   │   ├── domainAdministrationIcon.png
│   │   │   └── spagobgimg.jpg
│   │   ├── jasper_messages
│   │   │   ├── messages.properties
│   │   │   ├── messages_en_US.properties
│   │   │   ├── messages_fr_FR.properties
│   │   │   └── messages_it_IT.properties
│   │   ├── logo_images
│   │   │   └── logotalend.jpg
│   │   ├── olap
│   │   │   ├── MDX
│   │   │   │   ├── olap_simple_stats_analysis_v2
│   │   │   │   ├── olap_summary_stats_analysis_v2
│   │   │   │   └── olap_text_stats_analysis_v2
│   │   │   ├── dqportal_olap_indicator_value.xml
│   │   │   ├── dqportal_olap_match.xml
│   │   │   ├── dqportal_olap_overview.xml
│   │   │   ├── tdq_olap_simpl_indicator_value.xml
│   │   │   ├── tdq_olap_summary_indicator_value.xml
│   │   │   └── tdq_olap_textstat_indicator_value.xml
│   │   ├── qbe
│   │   │   ├── datamarts
│   │   │   │   ├── Inventory_HSQL
│   │   │   │   │   └── datamart.jar
│   │   │   │   ├── Sales_HSQL
│   │   │   │   │   └── datamart.jar
│   │   │   │   ├── resources
│   │   │   │   │   └── idx
│   │   │   │   │       ├── _0.cfs
│   │   │   │   │       ├── _0.cfx
│   │   │   │   │       ├── segments.gen
│   │   │   │   │       └── segments_2
│   │   │   │   └── tdqdatamart
│   │   │   │       └── datamart.jar
│   │   │   ├── groovy
│   │   │   │   ├── customerlnk.groovy
│   │   │   │   ├── customerlnk.groovy.2009-01-20
│   │   │   │   ├── customername.groovy
│   │   │   │   └── customername.groovy.2009-01-20
│   │   │   └── worksheet
│   │   │       └── images
│   │   │           └── Logo_SpagoBI.gif
│   │   └── static_menu
│   │       ├── home.html
│   │       ├── homePageWithLinks.html
│   │       ├── talend_drools.html
│   │       ├── talend_tac.html
│   │       ├── talendmdm.html
│   │       ├── tdq_links.html
│   │       └── whatif.html
│   ├── scripts
│   │   ├── set_ip.sh
│   │   ├── shutdown.sh
│   │   ├── sqltool.rc
│   │   ├── startup.sh
│   │   ├── tdqportal.properties
│   │   └── tdqportal.script
│   └── webapps
│       ├── SpagoBIAccessibilityEngine.war
│       ├── SpagoBIBirtReportEngine.war
│       ├── SpagoBIChartEngine.war
│       ├── SpagoBICockpitEngine.war
│       ├── SpagoBICommonJEngine.war
│       ├── SpagoBIConsoleEngine.war
│       ├── SpagoBIJPivotEngine.war
│       ├── SpagoBIJasperReportEngine.war
│       ├── SpagoBIQbeEngine.war
│       └── SpagoBITalendEngine.war
└── webapps
    ├── Talend-DSC-20151214_1327-V6.1.1.war
    ├── amc.war
    ├── org.talend.administrator-6.1.1.war
    ├── talend-brms-6.1.1.war
    └── tdqportal.war

30 directories, 94 files
```
