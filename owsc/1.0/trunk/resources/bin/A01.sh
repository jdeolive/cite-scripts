#! /bin/sh
PID=$$
file="../../web/examples/meris_borders_users.atom"


echo "OGC Context Conformance Test Classes (OGC 12-084)" >&2
echo "A.1 Conformance Test Class: core " >&2
echo "To test requirement http://www.opengis.net/spec/owc/1.0/conf/atom/atomRules" >&2
sh run.sh $file "owc10_new2" >&2
res=$?
if [ $res  != "0" ] 
then 
	exit $res
fi

exit 0

echo "A.1 Conformance Test Class: owcencoding " >&2
echo "To test requirement http://www.opengis.net/spec/owc/1.0/conf/atom/owcencoding" >&2
sh run.sh $file "atomrules2" >&2
res=$?
if [ $res  != "0" ] 
then 
	exit $res
fi

exit 0 
