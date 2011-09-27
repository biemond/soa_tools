
set ORACLE_HOME=C:\oracle\MiddlewareJdev11gR1PS3
set JAVA_HOME=%ORACLE_HOME%\jdk1.6.0_23
rem set ORACLE_HOME=D:\Oracle\MiddlewareJDevPS5
rem set JAVA_HOME=%ORACLE_HOME%\jdk160_24

set ANT_HOME=%ORACLE_HOME%\jdeveloper\ant
set PATH=%ANT_HOME%\bin;%PATH%

set CURRENT_FOLDER=%CD%

ant -f build.xml deployAll
