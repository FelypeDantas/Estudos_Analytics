const fs = require('fs');
const bancoCSV = 'database.csv';
const banco = fs.readFileSync(bancoCSV, "utf-8");

const regex = /Anna/;

const matchRegex = banco.match(regex);
console.log(matchRegex);