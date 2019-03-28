# enpass2keepass

This is just a crude _quick_ script to convert _most_ of an enpass JSON export to a CSV file that can be imported to keepass again. In fact writing this README took me more time.

It has no sanity checks in place. If it breaks you get to keep the pieces.

**Your mileage will vary!**

Read the source to get an idea!

## Requirments

* NodeJS :)

## Install

Install required node modules:

* `npm install`

## Usage

**Use at your own risk!**

1. Put `enpass.json` (exported from Enpass) in this folder. Name the file exactly like this.
2. Run: `node index.js` to convert nested enpass structure to flat json
3. Run: `./node_modules/.bin/json2csv -F -i keepass.json  > keepass.csv` to convert flattened json to csv (that's right - the hard work is done by `json2csv`)
4. Import `keepass.csv` to _new_ database in KeePassXC
5. Cleanup (you don't want to leave your passwords in plain text on your disk, don't you?): `rm keepass.csv keepass.json enpass.json`

## Disclaimer

This fiddle uses 3rd party libraries. If you're as paranoid as me disable at least your network while working with password databases in plain text files on disk.