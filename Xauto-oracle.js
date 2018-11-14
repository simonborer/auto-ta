const fs = require('fs');
const oracle = require('./oracle');
const config = require('./config');
const dirCont = fs.readdirSync('assignments');
const getQuestions = require('./get-questions');
const getAssignments = require('./get-assignments');

dirCont.forEach(folder => {

    const fold = fs.readdirSync('assignments/' + folder);

    fold.forEach(file => {

        const filename = file.split('.').slice(0, -1).join('.');

        if (filename == 'key') {

            const contents = fs.readFileSync('assignments/' + folder + '/' + file, 'utf8');
            const contentsArr = getQuestions(contents);
            const answerObject = Object.create(null);

            answerObject.assignment = folder;

            const oraclePromises = [];

            for (let content of contentsArr) {
                const oraclePromise = oracle(content);
                oraclePromises.push(oraclePromise);
            }

            Promise.all(oraclePromises)
                .then((values) => {

                    let contentIndex = 0;

                    for (let content of contentsArr) {
                        answerObject[folder + ', Q' + (contentIndex + 1)] = content;
                        answerObject[folder + ', A' + (contentIndex + 1)] = values[contentIndex];
                        contentIndex++;
                    }

                    // console.log(answerObject);
                })
                .catch((e) => {
                    console.log(e)
                });
        }
    })
});
