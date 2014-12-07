csv2contacts2fritz
=====
csv2contacts2fritz.sh is a very crude bash script to convert contacts exported as CSV from Zarafa (using [process-contacts.php](https://github.com/zarafagroupware/zarafa-tools/tree/9d5483f786888625de565343d06427cec91b6f32/contacts/csv2contacts/process-contacts.php) from [csv2contacts](https://github.com/zarafagroupware/zarafa-tools/tree/master/contacts/csv2contacts)) to XML. This XML can be imported as phonebook to [FRITZ!Box](http://en.avm.de/products/fritzbox/).

It *assumes* that your CSV file is valid, UTF-8 encoded and has DOS line endings.

Usage: ./csv2contacts2fritz.sh csv2contacts.csv FRITZ.Box-Phonebook-csv2contacts.xml

Tested with Bash 4.3.11 for [FRITZ!Box 7390](http://en.avm.de/products/fritzbox/fritzbox-7390/) with FRITZ!OS 06.20

Attention: Your existing phonebook on your FRITZ!Box will be overwritten when you "import" (recover) the new XML. Use an empty phonebook to be safe.

