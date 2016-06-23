FROM tomcat:8.0

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV LOGS /usr/local/logs
ENV PATH $LOGS:$PATH
ENV JOBS /usr/local/jobs
ENV PATH $JOBS:$PATH
ENV MYSQL_HOST 127.0.0.1
ENV MYSQL_PORT 3306
ENV MYSQL_DB talend_administrator
ENV MYSQL_USER tisadmin
ENV MYSQL_PASSWORD tisadmin
RUN mkdir -p "$CATALINA_HOME"/database
RUN mkdir -p "$CATALINA_HOME"
RUN bash -c 'mkdir -p "$LOGS"/{audit,logging,conductor/{jobs,tasks}}'
RUN mkdir -p "$JOBS"
RUN mkdir -p "$CATALINA"/endorsed
RUN mkdir -p "$CATALINA"/conf/Catalina/localhost
RUN rm -rf "$CATALINA_HOME"/webapps/ROOT

WORKDIR $CATALINA_HOME

# Talend Administration Console
COPY /webapps/org.talend.administrator-6.1.1.war $CATALINA_HOME/webapps/ROOT.war
# Talend Datastewardship Console
COPY /webapps/Talend-DSC-20151214_1327-V6.1.1.war $CATALINA_HOME/webapps/org.talend.datastewardship.war
# Talend AMC Monitoring Console
COPY /webapps/amc.war $CATALINA_HOME/webapps/amc.war
# Talend Data Quality Portal
COPY /webapps/tdqportal.war $CATALINA_HOME/webapps/tdqportal.war
COPY /conf/server.xml $CATALINA_HOME/conf/server.xml
COPY /tdqportal/webapps $CATALINA_HOME/webapps
COPY /tdqportal/lib $CATALINA_HOME/lib
COPY /tdqportal/resources $CATALINA_HOME/
COPY /tdqportal/scripts $CATALINA_HOME/database/
# Talend Drools (BRMS)
COPY /webapps/talend-brms-6.1.1.war $CATALINA_HOME/webapps/kie-drools-wb.war
COPY /brms/lib $CATALINA_HOME/lib
COPY /brms/conf $CATALINA_HOME/conf
COPY /brms/setenv.sh $CATALINA_HOME/bin/setenv.sh
# tomcat-users.xml - tomcat user roles
COPY /conf/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml
# MySQL jdbc driver
COPY /endorsed/mysql-connector-java-5.1.38-bin.jar $CATALINA_HOME/endorsed/mysql-connector-java-5.1.38-bin.jar
# Talend endoresed URL Mave
COPY /endorsed/talend-url-mvn-1.0.0.jar $CATALINA_HOME/endorsed/talend-url-mvn-1.jar
# Launch script
COPY dockerentry-point.sh $CATALINA_HOME/bin/dockerentry-point.sh

VOLUME ${LOGS}

EXPOSE 7890 8050 8080 9419

CMD ["dockerentry-point.sh"]
