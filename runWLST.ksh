#!/bin/ksh
cd $(cd `dirname $0`; pwd)

PSCRIPT=$1
PPROP=$2
PACTION=$3

ENV_SCRIPT=`ls ./setDomainEnv.sh ./bin/setDomainEnv.sh 2>/dev/null`
ENV_SCRIPT_COUNT=`ls ./setDomainEnv.sh ./bin/setDomainEnv.sh 2>/dev/null|wc -l`
if [[ $ENV_SCRIPT_COUNT -eq 1 ]]; then
  . $ENV_SCRIPT > /dev/null
  cd -
else
    JAVA_HOME=`dirname $(ps -ef |grep java |grep -v grep |sed "s/^\ *//g" |grep ^$USER | tr " " "\n" |grep /opt|grep /java$| tail -1)`/..
    CLASSPATH=$(ps -ef|grep -v grep |sed "s/^\ *//g" |grep ^$USER | tr " " "\n"|grep '/weblogic.jar' | tail -1)
    DOMAIN_HOME=`pwd`
    echo "# JAVA_HOME: $JAVA_HOME"
    echo "# CLASSPATH: $CLASSPATH"
    echo "# DOMAIN_HOME: $DOMAIN_HOME"
fi 

[[ -z $CLASSPATH ]] && export CLASSPATH=$WEBLOGIC_CLASSPATH

$JAVA_HOME/bin/java -Djava.security.egd=file:/dev/./urandom \
                    -Dweblogic.security.SSL.ignoreHostnameVerification=true \
                    -Dweblogic.security.TrustKeyStore=DemoTrust \
                    -cp $CLASSPATH \
                    -Dpython.cachedir=/tmp/$$.wlst \
                    weblogic.WLST -skipWLSModuleScanning $PSCRIPT $PPROP $PACTION 2>&1 | tee $0.log
                 
rm -rf /tmp/$$.wlst

