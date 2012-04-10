set ORACLE_HOME=C:\oracle\MiddlewarePS5
set JAVA_HOME=C:\oracle\jrockit-jdk1.6.0_29-R28.2.2-4.1.0
set ANT_HOME=%ORACLE_HOME%\modules\org.apache.ant_1.7.1
set PATH=%ANT_HOME%\bin;%PATH%

ant -f build.xml createResourceAdapterEntries