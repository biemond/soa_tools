
set ORACLE_HOME=C:\oracle\MiddlewareJdev11gR1PS3
set ANT_HOME=%ORACLE_HOME%\jdeveloper\ant
set PATH=%ANT_HOME%\bin;%PATH%
set JAVA_HOME=%ORACLE_HOME%\jdk1.6.0_23

set CURRENT_FOLDER=%CD%

ant -f build.xml export
