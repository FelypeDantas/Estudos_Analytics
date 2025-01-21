const fs = require('fs');
const bancoCSV = 'database.csv';
const banco = fs.readFileSync(bancoCSV, "utf-8");

const regex = /\d{3}[.-]?\d{3}[.-]?\d{3}[.-]?\d{2}/g

const matchCPF = banco.match(regex);
console.log(matchCPF);
