Maven OSB build, release POM for Oracle Service Bus PS5 patch set 5
===================================================================


Usage
-----

. osb.sh  ( sets maven, java environment variables )

mvn package, builds all or 1 project depends on the location in the source folder ( OEPE Workspace )  
mvn deploy -Dtarget-env=dev , deploy to the dev OSB folder  
mvn release:prepare         , prepare a release  
mvn release:perform -Dtarget-env=dev -DconnectionUrl=scm:git:git@github.com:biemond/soa_tools.git  


for an export of the OSB projects from the OSB Server run "mvn deploy -Dtarget-env=dev" in the export folder

for an build + export of a specific OSB project run "mvn deploy -Dtarget-env=dev" in a OSB project folder

My Environment settings
-----------------------

Oracle OSB PS6 or 11.1.1.6

middleware home   /opt/oracle/wls/wls11g  
OSB & Oracle home /opt/oracle/wls/wls11g/Oracle_OSB1  
WebLogic home     /opt/oracle/wls/wls11g/wlserver_10.3  
Oepe home         /opt/oracle/wls/wls11g/oepe11.1.1.8  


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


    <profile>
      <id>env-default</id>

      <properties>
        <fmw.home>/opt/oracle/wls/wls11g</fmw.home>
        <eclipse.home>/opt/oracle/wls/wls11g/oepe11.1.1.8</eclipse.home>
        <weblogic.home>/opt/oracle/wls/wls11g/wlserver_10.3</weblogic.home>
        <osb.home>/opt/oracle/wls/wls11g/Oracle_OSB1</osb.home>        
      </properties>
            <repositories>
                  <repository>
                        <id>central</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <snapshots>
                              <enabled>false</enabled>
                        </snapshots>
                  </repository>
                  <repository>
                        <id>snapshots</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <releases>
                              <enabled>false</enabled>
                        </releases>
                  </repository>
            </repositories>
            <pluginRepositories>
                  <pluginRepository>
                        <id>central</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <snapshots>
                              <enabled>false</enabled>
                        </snapshots>
                  </pluginRepository>
                  <pluginRepository>
                        <id>snapshots</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <releases>
                              <enabled>false</enabled>
                        </releases>
                  </pluginRepository>
            </pluginRepositories>

    </profile>


    <profile>
      <id>env-dev</id>

      <activation>
        <property>
          <name>target-env</name>
          <value>dev</value>
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
            <repositories>
                  <repository>
                        <id>central</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <snapshots>
                              <enabled>false</enabled>
                        </snapshots>
                  </repository>
                  <repository>
                        <id>snapshots</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <releases>
                              <enabled>false</enabled>
                        </releases>
                  </repository>
            </repositories>
            <pluginRepositories>
                  <pluginRepository>
                        <id>central</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <snapshots>
                              <enabled>false</enabled>
                        </snapshots>
                  </pluginRepository>
                  <pluginRepository>
                        <id>snapshots</id>
                        <url>http://localhost:8081/artifactory/repo</url>
                        <releases>
                              <enabled>false</enabled>
                        </releases>
                  </pluginRepository>
            </pluginRepositories>


    </profile>
    </profiles>
  
    <activeProfiles>
      <activeProfile>env-default</activeProfile>
    </activeProfiles>
  


Important
---------
with java as goal for the exec-maven-plugin does not seems to work because you are running inside 
the maven jvm ( no fork ) and need to set MAVEN_OPTS parameters to pass on -D parameters but all this
Also adding dependecies libraries and using includeProjectDependencies does also work.

need to use exec as goal to start a new process and use commandlineArgs, you can't use arguments


manual export from workspace amd run without maven with a java command

     java -classpath "/opt/oracle/wls/wls11g/Oracle_OSB1/modules/com.bea.common.configfwk_1.6.0.0.jar:
                 /opt/oracle/wls/wls11g/Oracle_OSB1/modules/com.bea.core.xml.xmlbeans_2.2.0.0_2-5-1.jar:
                 /opt/oracle/wls/wls11g/Oracle_OSB1/lib/alsb.jar:
                 /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-wls.jar:
                 /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-impl.jar:
                 /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-api.jar:
                 /opt/oracle/wls/wls11g/wlserver_10.3/server/lib/weblogic.jar:
                 /opt/oracle/wls/wls11g/wlserver_10.3/server/lib/wls-api.jar:
                 /opt/oracle/wls/wls11g/oepe11.1.1.8/plugins/org.eclipse.equinox.launcher_1.2.0.v20110502.jar" 
       -Dsun.lang.ClassLoader.allowArraySyntax=true 
       -Dweblogic.home=/opt/oracle/wls/wls11g/wlserver_10.3 
       -Dharvester.home=/opt/oracle/wls/wls11g/Oracle_OSB1/harvester 
       -Dosb.home=/opt/oracle/wls/wls11g/Oracle_OSB1 
       -Dosgi.bundlefile.limit=750 
       -Dosgi.nl=en_US 
       -Dmiddleware.home=/opt/oracle/wls/wls11g 
       org.eclipse.equinox.launcher.Main 
       -data /home/oracle/projects/soa_tools/maven_osb_ps5/source 
       -application com.bea.alsb.core.ConfigExport 
       -configProject "OSB Configuration" 
       -configJar /home/oracle/projects/soa_tools/maven_osb_ps5/export/Rel_XSD.jar 
       -configSubProjects  "ReliableMessageWS,XSDvalidation" 
       -includeDependencies true 
     
     
or do a manual import with java ( deployment with WLST)

      java -classpath /opt/oracle/wls/wls11g/wlserver_10.3/server/lib/weblogic.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/modules/com.bea.core.xml.xmlbeans_2.2.0.0_2-5-1.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/lib/alsb.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-wls.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-impl.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/lib/sb-kernel-api.jar:
                      /opt/oracle/wls/wls11g/Oracle_OSB1/modules/com.bea.common.configfwk_1.6.0.0.jar 
                      weblogic.WLST import.py 
                      weblogic 
                      weblogic1 
                      t3://devagent1.alfa.local:7001 
                      None 
                      /home/oracle/projects/soa_tools/maven_osb_ps5/export/Rel_XSD.jar 
                      None
      

