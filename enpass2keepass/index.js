const fs = require('fs')
const foo = fs.readFileSync('enpass.json')
const enpass = JSON.parse(foo);
const items = enpass.items;

const keepass = [];
items.map((item) => {
    const keepassdata = {
        Group: 'Root/',
        Title: '',
        Username: '',
        Password: '',
        URL: '',
        Notes: ''
    }

    keepassdata.Group += item.category || '';
    keepassdata.Title = item.title || '';

    item.fields = item.fields || [];
    username = item.fields.find((f) => f.type === 'username') || {
        value: ''
    }

    email = item.fields.find((f) => f.type === 'email') || {
        value: ''
    }
    password = item.fields.find((f) => f.type === 'password') || {
        value: ''
    }
    url = item.fields.find((f) => f.type === 'url') || {
        value: ''
    }

    if (!username.value.length && email.value.length) {
        username.value = email.value
        email.value = '';
    }

    if (!username.value.length) {
        username.value = item.subtitle;
    }

    if (!username.value.length) {
        username.value = 'MissingUsername'
    }

    keepassdata.Username = username.value;
    keepassdata.Password = password.value;
    keepassdata.URL = url.value;

    if (email.value.length) {
        keepassdata.Notes += `E-Mail: ${email.value}`;
    }

    sections = item.fields.filter((f) => f.type === 'section')
    texts = item.fields.filter((f) => f.type === 'text')
    fields = [...sections, ...texts]

    fields.map((f) => {
        if (!f.value) {
            return;
        }

        keepassdata.Notes += ` ${f.label}: ${f.value}`
    })

    keepass.push(keepassdata)
})

const data = JSON.stringify(keepass);
const handler = fs.openSync('keepass.json', 'w', '600');
fs.writeSync(handler, data, 0, 'utf-8');