#!/bin/sh

export MW_HOME=/Users/edwin/Oracle/Middleware11.1.1.7_OSB
export OSB_HOME=$MW_HOME/Oracle_OSB1
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home

export BEA_HOME=$MW_HOME
export WL_HOME=$MW_HOME/wlserver_10.3
export WLS_VER=10.3
export COMMON_COMPONENTS_HOME=$MW_HOME/oracle_common
export MODULES_DIR=$MW_HOME/modules

export PATH=$WL_HOME/server/bin:$JAVA_HOME/jre/bin:$JAVA_HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
export MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"

export CONFIGJAR_HOME="$OSB_HOME/tools/configjar"
export JAVA_OPTS="-Dosb.home=$OSB_HOME -Dweblogic.home=$WL_HOME"
export JAVA_OPTIONS=" -Xverify:none"

CLASSPATH=$MW_HOME/modules/features/weblogic.server.modules_10.3.6.0.jar
CLASSPATH=$CLASSPATH:$WL_HOME/server/lib/weblogic.jar
CLASSPATH=$CLASSPATH:$MW_HOME/oracle_common/modules/oracle.http_client_11.1.1.jar:$MW_HOME/oracle_common/modules/oracle.xdk_11.1.0/xmlparserv2.jar:$MW_HOME/oracle_common/modules/oracle.webservices_11.1.1/orawsdl.jar:$MW_HOME/oracle_common/modules/oracle.wsm.common_11.1.1/wsm-dependencies.jar
CLASSPATH=$CLASSPATH:$OSB_HOME/modules/features/osb.server.modules_11.1.1.7.jar:$OSB_HOME/soa/modules/oracle.soa.common.adapters_11.1.1/oracle.soa.common.adapters.jar:$OSB_HOME/lib/external/log4j_1.2.8.jar:$OSB_HOME/lib/alsb.jar
CLASSPATH=$CLASSPATH:$CONFIGJAR_HOME/configjar.jar:$CONFIGJAR_HOME/L10N
export CLASSPATH

cd $OSB_HOME/tools/configjar


$JAVA_HOME/bin/java $JAVA_OPTS com.bea.alsb.tools.configjar.ConfigJar -settingsfile /Users/edwin/projects/soa_tools/maven_osb_ps6_tool/osb_export_projects.xml
