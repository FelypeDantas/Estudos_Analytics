const fs = require('fs');
const bancoCSV = 'database.csv';
const banco = fs.readFileSync(bancoCSV, "utf-8");

const patternData = /\d{2}[./ ]?\d{2}[./ ]?\d{4}$/gm;

const matchData = banco.match(patternData);
console.log(matchData);
