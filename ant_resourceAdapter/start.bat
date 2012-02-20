#set ORACLE_HOME=C:\oracle\JDev11114PS
#set JAVA_HOME=C:\oracle\jrockit-jdk1.6.0_26-R28
#set ANT_HOME=%ORACLE_HOME%\jdeveloper\ant
set ORACLE_HOME=C:\oracle\MiddlewarePS3
set JAVA_HOME=C:\oracle\jrockit-jdk1.6.0_26-R28
set ANT_HOME=%ORACLE_HOME%\modules\org.apache.ant_1.7.1
set PATH=%ANT_HOME%\bin;%PATH%

ant -f build.xml createResourceAdapterEntries