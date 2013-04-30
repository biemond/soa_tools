Maven OSB build, release POM for Oracle Service Bus PS6 Tool export
===================================================================

main pom ( /pom.xml ) which build the OSB workspace and its 2 projects
 
parent pom /parent/pom.xml   
1 for building OSB workspace  
1 for building OSB project  

workspace pom ( /source/pom.xml )  
project XSDvalidation pom ( /source/XSDvalidation/pom.xml )  
project ReliableMessageWS pom ( /source/ReliableMessageWS/pom.xml )  


Usage
-----

__. osb.sh__  ( sets maven, java environment variables )

__mvn package__, builds all or 1 project depends on the location in the source folder ( OEPE Workspace )  
__mvn deploy -Dtarget-env=dev-osb__, deploy to the dev OSB folder  
__mvn release:prepare__, prepare a release  
__mvn release:perform -Dtarget-env=dev-osb -DconnectionUrl=scm:git:git@github.com:biemond/soa_tools.git__  


for an export of the OSB projects from the OSB Server run "mvn deploy -Dtarget-env=dev-osb" in the export folder

for an build + export of a specific OSB project run "mvn deploy -Dtarget-env=dev-osb" in a OSB project folder

My Environment settings
-----------------------

Oracle OSB PS6 or 11.1.1.7

middleware home   /opt/wls/Middleware11gR1  
OSB & Oracle home /opt/wls/Middleware11gR1/Oracle_OSB1  
WebLogic home     /opt/wls/Middleware11gR1/wlserver_10.3  
configjar home    /opt/wls/Middleware11gR1/Oracle_OSB1/tools/configjar 


Settings.xml
------------
    <servers>
    	<server>
        <id>central</id>
        <username>admin</username>
        <password>password</password>
      </server>
    	<server>
        <id>snapshots</id>
        <username>admin</username>
        <password>password</password>
      </server>
    </servers>

    <profiles>
    <profile>
      <id>osb-default</id>

      <properties>
        <mw.home>/opt/wls/Middleware11gR1</mw.home>
        <bea.home>${mw.home}</bea.home>
        <osb.home>${mw.home}/Oracle_OSB1</osb.home>        
        <wl.home>${mw.home}/wlserver_10.3</wl.home>
        <common.components.home>${mw.home}/oracle_common</common.components.home>
        <modules.dir>${mw.home}/modules</modules.dir>
        <configjar.home>${osb.home}/tools/configjar</configjar.home>
				<osb.tool.classpath>${mw.home}/modules/features/weblogic.server.modules_10.3.6.0.jar:${wl.home}/server/lib/weblogic.jar:${common.components.home}/modules/oracle.http_client_11.1.1.jar:${common.components.home}/modules/oracle.xdk_11.1.0/xmlparserv2.jar:${common.components.home}/modules/oracle.webservices_11.1.1/orawsdl.jar:${common.components.home}/modules/oracle.wsm.common_11.1.1/wsm-dependencies.jar:${osb.home}/modules/features/osb.server.modules_11.1.1.7.jar:${osb.home}/soa/modules/oracle.soa.common.adapters_11.1.1/oracle.soa.common.adapters.jar:${osb.home}/lib/external/log4j_1.2.8.jar:${osb.home}/lib/alsb.jar:${configjar.home}/configjar.jar:${configjar.home}/L10N</osb.tool.classpath>	
				<osb.deploy.classpath>${wl.home}/server/lib/weblogic.jar:${osb.home}/lib/alsb.jar:${osb.home}/lib/sb-kernel-wls.jar:${osb.home}/lib/sb-kernel-impl.jar:${osb.home}/lib/sb-kernel-api.jar:${osb.home}/modules/com.bea.common.configfwk_1.7.0.0.jar</osb.deploy.classpath>	
      </properties>

    </profile>


    <profile>
      <id>env-dev-osb</id>

      <activation>
        <property>
          <name>target-env</name>
          <value>dev-osb</value>
        </property>
      </activation>

      <properties>
        <wls.username>weblogic</wls.username>
        <wls.password>weblogic1</wls.password>
        <wls.server>t3://devagent1.alfa.local:7001</wls.server>

        <osb.all.import.projects>None</osb.all.import.projects>
        <osb.all.import.plan>None</osb.all.import.plan>
        <osb.all.export.projects>None</osb.all.export.projects>
        <osb.all.export.plan>all_plan.xml</osb.all.export.plan>
      </properties>

    </profile>
    </profiles>
  
    <activeProfiles>
      <activeProfile>osb-default</activeProfile>
    </activeProfiles>
  


Important
---------
with java as goal for the exec-maven-plugin does not seems to work because you are running inside 
the maven jvm ( no fork ) and need to set MAVEN_OPTS parameters to pass on -D parameters but all this
Also adding dependecies libraries and using includeProjectDependencies does also work.

need to use exec as goal to start a new process and use commandlineArgs, you can't use arguments
