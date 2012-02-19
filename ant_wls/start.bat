set ORACLE_HOME=C:\oracle\JDev11114PS
set JAVA_HOME=C:\oracle\jrockit-jdk1.6.0_26-R28
set ANT_HOME=%ORACLE_HOME%\jdeveloper\ant
set ANT_OPTS=%ANT_OPTS% -XX:MaxPermSize=128m  
set CLASSPATH=%CLASSPATH%;%ORACLE_HOME%\wlserver_10.3\server\lib\weblogic.jar 

set CURRENT_FOLDER=%CD%

set PATH=%ANT_HOME%\bin;%PATH%
ant -f build.xml help
