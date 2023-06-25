#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line
export TARGET_HOST="https://wploadtests.roconpaas.com/wp-admin/"
export TARGET_PORT="80"
#export TARGET_PATH=""
export NUM_THREADS="50"
#test run time  duration in secounds (ramp_time) 
export RAMP_TIME="500"
export DISPLAY=:0.0
#export TARGET_KEYWORD="test"

T_DIR=tests/trivial
cd /home/jmeter/docker-jmeter/
echo "I am from This directory running ls"
ls -la

# Reporting dir: start fresh
R_DIR='/home/jmeter/docker-jmeter/tests/trivial/report'
who am i
sudo rm -rf ${R_DIR}
mkdir -p ${R_DIR}

rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} -JTARGET_PORT=${TARGET_PORT} \
	-JNUM_THREADS=${NUM_THREADS} -JRAMP_TIME=${RAMP_TIME} \
	-n -t ${T_DIR}/test-plan.jmx -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log \
	-e -o ${R_DIR}


echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
