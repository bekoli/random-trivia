#!/bin/bash
#Use at your own risk!

if test -z "$1" -o -z "$2"; then
	echo "Usage: $0 csv2contacts.csv FRITZ.Box-Phonebook-csv2contacts.xml"
	exit 0
fi

if [ ! -f "$1" ]; then
	echo "$1 not found"
	exit 1
fi

if [ -f "$2" ]; then
	echo "$2 exists already"
	exit 1
fi

#trim leading and trailing whitespaces and all doublequotes
trim(){

	varTrim=${1#"${1%%[![:space:]]*}"}
	varTrim=${varTrim%"${varTrim##*[![:space:]]}"}
	varTrim=${varTrim//\"/ }
	echo $varTrim
}

#trims all whitespaces and doublequotes
trimAll(){
	varTrimAll=${1//[[:space:]]/}
	varTrimAll=${varTrimAll//\"/ }
	echo $varTrimAll
}

echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<phonebooks>
	<phonebook>" > $2

i=1
while IFS=$',' read -r -a rs; do
	if [ "${rs[0]}" == "given_name" ];then
		continue
	fi

	echo -e "		<contact>
			<person>
				<realName>$(trim "${rs[0]} ${rs[1]}")</realName>
			</person>
			<telephony>
				<number id=\"0\" prio=\"1\" type=\"home\">$(trimAll "${rs[8]}")</number>
				<number id=\"1\" prio=\"2\" type=\"mobile\">$(trimAll "${rs[11]}")</number>
				<number id=\"2\" prio=\"3\" type=\"work\">$(trimAll "${rs[7]}")</number>
				<number id=\"3\" prio=\"4\" type=\"fax_home\">$(trimAll "${rs[9]}")</number>
			</telephony>
			<services nid=\"1\">
				<email classifier=\"private\" id=\"0\">$(trimAll "${rs[4]}")</email>
				<email classifier=\"private\" id=\"1\">$(trimAll "${rs[5]}")</email>		
			</services>
			<uniqueid>$i</uniqueid>
		</contact>" >> $2
	((i++))
done < "$1"
echo -e "	</phonebook>
</phonebooks>" >> $2
exit 0

