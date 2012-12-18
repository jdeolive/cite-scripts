#! /bin/sh
PID=$$
file=$1
rule=$2
conformance="../relaxng/"
echo "java -jar ../lib/trang/trang.jar -I rnc -O rng $conformance/$rule.rnc $conformance/$rule.rng"
java -jar ../lib/trang/trang.jar -I rnc -O rng $conformance/$rule.rnc $conformance/$rule.rng
if [ "$?"  != "0" ] 
then 
	echo "FAILED to validate RelaxNG"
	exit 2
fi 
echo "java -jar ../lib/relames/relames.jar $conformance/$rule.rng $file"
res=`java -jar ../lib/relames/relames.jar $conformance/$rule.rng $file`
#if [ ! -z "`echo "$res" | grep "NOT valid"`" ] 
if [ "`printf %s "$res" | tail -1 `" != "valid" ] 
then 
	echo "`echo "$res" `" #| grep -A 1 "Error at"`"
	echo "FAILED"
	exit 1
fi
echo "PASSED"
echo " "
exit 0 
