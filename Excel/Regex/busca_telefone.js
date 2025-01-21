const fs = require('fs');
const bancoCSV = 'database.csv';
const banco = fs.readFileSync(bancoCSV, "utf-8");

const regexTelefone = /\(\d{2}\)\s\d+{4,5}-\d{4}/g

const matchTelefone = banco.match(regexTelefone);
console.log(matchTelefone);

const patternCell =  /\(\d{2}\)\s\d{5}-\d{4}/g

const matchCelular = banco.match(patternCell);
console.log(matchCelular);