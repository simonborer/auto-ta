// Returns:
// [{
//     assignment: {string},
//     submissions: [{
//          key: {boolean},
//          1: {string},
//          2: {string},
//          ...
//     }]
// }]

const fs = require('fs'),
    dirCont = fs.readdirSync('assignments');
    
const getQuestions = require('./get-questions')

// all the assignments
const assignmentArray = [];

// For each folder in /assignments/
dirCont.forEach(folder => {

    // Create an object for each assignment
    const fold = fs.readdirSync('assignments/' + folder);
    const logIndex = fold.indexOf('logs');
    if (logIndex > -1) {
      fold.splice(logIndex, 1);
    }
    const assignmentObject = Object.create(null);
    assignmentObject["assignment"] = folder;
    assignmentObject["submissions"] = [];


    // For each file in the assignment subfolder
    fold.forEach(file => {

        const filename = file.split('.').slice(0, -1).join('.');
        const contents = fs.readFileSync('assignments/' + folder + '/' + file, 'utf8');
        const questions = getQuestions(contents);

        const submissionObject = Object.create(null);

        submissionObject["filename"] = filename;
        
        if (filename == 'key') {
            submissionObject['key'] = true;
        } else {
            submissionObject['key'] = false;
        }

        const outputObj = Object.assign(submissionObject, questions);
        assignmentObject["submissions"].push(submissionObject);

    });

    assignmentArray.push(assignmentObject);

});


module.exports = assignmentArray;