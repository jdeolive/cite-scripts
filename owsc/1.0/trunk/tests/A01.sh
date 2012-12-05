#! /bin/sh
PID=$$
file="../examples/meris_borders_users.atom"
conformance="../conformance/A1-core"

echo "OGC Context Conformance Test Classes (OGC 12-084)" >&2
echo "A.1 Conformance Test Class: core " >&2
echo "To test requirement http://www.opengis.net/spec/owc/1.0/conf/atom/atomRules" >&2
sh run.sh $file "atomrules" >&2
res=$?
if [ $res  != "0" ] 
then 
	exit $res
fi



echo "A.1 Conformance Test Class: owcencoding " >&2
echo "To test requirement http://www.opengis.net/spec/owc/1.0/conf/atom/owcencoding" >&2

java -jar ../utils/bin/trang.jar -I rnc -O rng $conformance/owcencoding.rnc $conformance/owcencoding.rng
res=`java -jar ../utils/relames/relames.jar $conformance/owcencoding.rng $file`
if [ "$?"  != "0" ] 
then 
	echo "FAILED:$res"
	exit 1
fi
echo "PASSED"

exit 0 
