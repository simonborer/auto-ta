const autoPlagiarism = require('./auto-plagiarism'),
    oracle = require('./auto-oracle.js'),
    colors = require('colors'),
    config = require('./config'),
    puppet = require('./puppet');

const args = process.argv.slice(2);

switch (args[0]) {
    case 'plagiarism':
        if (args[1]) {
            autoPlagiarism(args[1]);
        } else {
            autoPlagiarism(60);
        };
        console.log("Plagiarism report generated.".green)
        break;
    case 'oracle':
        oracle();
        console.log("Oracle report generated.".green)
        break;
    case 'puppet':
        if (args[1] && args[2]) {
            puppet(args[1], args[2], config.courseId, config.cvid);
        } else {
            console.log("Please append your Humber username and password".red);
        }
        break;
    default:
        console.log("Sorry, I don't understand.".red)
}