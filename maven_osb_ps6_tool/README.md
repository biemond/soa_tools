Maven OSB build, release POM for Oracle Service Bus PS6 patch set 6
===================================================================

main pom ( /pom.xml ) which build the OSB workspace and its 2 projects
 
2 parent poms   
1 for building OSB workspace ( /parent/workspace/pom.xml )  
1 for building OSB project ( /parent/project/pom.xml )  

workspace pom ( /source/pom.xml ) --> OSB workspace parent pom  
project XSDvalidation pom ( /source/XSDvalidation/pom.xml ) --> OSB project parent pom  
project ReliableMessageWS pom ( /source/ReliableMessageWS/pom.xml ) --> OSB project parent pom  


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
Oepe home         /opt/wls/Middleware11gR1/oepe11.1.1.8  


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
        <fmw.home>/opt/wls/Middleware11gR1</fmw.home>
        <eclipse.home>/opt/wls/Middleware11gR1/oepe11.1.1.8</eclipse.home>
        <weblogic.home>/opt/wls/Middleware11gR1/wlserver_10.3</weblogic.home>
        <osb.home>/opt/wls/Middleware11gR1/Oracle_OSB1</osb.home>        
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
