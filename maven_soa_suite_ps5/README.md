Maven SOA build, release POM for Oracle Soa Suite PS5 patch set 5
===================================================================


main pom ( /pom.xml ) which build the Soa Suite workspaces

2 parent poms   
1 for building SOA project ( /parent/soa/project/pom.xml )  
1 for building SOA project with MDS dependency  ( /parent/soa/project_mds/pom.xml )  

workspace MetaDataServices ( /MetaDataServices/pom.xml ) --> MetaData MDS workspace parent pom  
project BPEL1 pom ( /source2/bpel1/pom.xml ) --> Soa Suite project pom  
project BPEL2 pom ( /source2/bpel1/pom.xml ) --> Soa Suite MDS project pom  


Usage
-----

__. soa.sh__  ( sets maven, java environment variables )

__mvn package__, builds all or 1 project depends on the location in the source2 folder  
__mvn deploy -Dtarget-env=dev-soa__, deploy to the dev OSB folder  
__mvn release:prepare__, prepare a release  
__mvn release:perform -Dtarget-env=dev-soa -DconnectionUrl=scm:git:git@github.com:biemond/soa_tools.git__  


my mds config in adf-config.xml, with ${mds.home} which points to file mds location 
maven with replace ${mds.home} with own local location.     

    <adf-mds-config xmlns="http://xmlns.oracle.com/adf/mds/config">
      <mds-config xmlns="http://xmlns.oracle.com/mds/config">
        <persistence-config>
          <metadata-namespaces>

            <namespace metadata-store-usage="mstore-usage_1" path="/soa/shared"/>
            <namespace metadata-store-usage="mstore-usage_2" path="/apps"/>

          </metadata-namespaces>
          <metadata-store-usages>

            <metadata-store-usage id="mstore-usage_1">
              <metadata-store class-name="oracle.mds.persistence.stores.file.FileMetadataStore">
                <property value="${oracle.home}/integration"
                          name="metadata-path"/>
                <property value="seed" name="partition-name"/>
              </metadata-store>
            </metadata-store-usage>

            <metadata-store-usage id="mstore-usage_2">
              <metadata-store class-name="oracle.mds.persistence.stores.file.FileMetadataStore">
                <property value="${mds.home}"
                          name="metadata-path"/>
                <property value="seed" name="partition-name"/>
              </metadata-store>
            </metadata-store-usage>

          </metadata-store-usages>
        </persistence-config>
      </mds-config>
    </adf-mds-config>
  



My Environment settings
-----------------------

Oracle SOA PS6 or 11.1.1.6

middleware home   /opt/wls/Middleware11gR1  
SOA & Oracle home /opt/wls/Middleware11gR1/Oracle_SOA1  
WebLogic home     /opt/wls/Middleware11gR1/wlserver_10.3  



Maven Settings.xml
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
      <id>soa-default</id>
      <properties>
        <sca.home>/opt/jdeveloper11gR1PS5/jdeveloper/bin</sca.home>
        <java.home>/usr/java/latest</java.home>
      </properties>
     </profile>

     <profile>
      <id>env-dev-soa</id>
 
      <activation>
        <property>
          <name>target-env</name>
          <value>dev-soa</value>
        </property>
      </activation>
 
      <properties>
        <wls.username>weblogic</wls.username>
        <wls.password>weblogic1</wls.password>
        <wls.server>http://devagent1.alfa.local:8001</wls.server>
      </properties>

    </profile>
    </profiles>
    
    <activeProfiles>
      <activeProfile>soa-default</activeProfile>
    </activeProfiles>