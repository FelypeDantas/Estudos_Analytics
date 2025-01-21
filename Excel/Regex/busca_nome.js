const fs = require('fs');
const bancoCSV = 'database.csv';
const banco = fs.readFileSync(bancoCSV, "utf-8");

const patternNomes = /^([A-Za-zÀ-ÿ]+)(\s(?:[A-Za-zÀ-ÿ]+))+/gm;

const matchNomes = banco.match(patternNomes);
console.log(matchNomes);