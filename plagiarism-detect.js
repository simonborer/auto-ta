// Import node modules
const fs = require('fs'),
    jsdiff = require('diff');

// Import custom modules
const getAssignments = require('./get-assignments'),
    util = require('./util');

util.mkdirSync('./output/pla');

// getAssignments.forEach(assn => {

//     const wstream = fs.createWriteStream('./output/pla/' + assn.assignment + '-output.md');

//     wstream.write("\n# " + assn.assignment + "\n");

//     // Put key first
//     const obj = assn.submissions.find(obj => obj.key === true);
//     const index = assn.submissions.indexOf(obj);

//     if (index !== -1) {
//         assn.submissions.splice(index, 1);
//         assn.submissions.unshift(obj);
//     }

//     // Get the sum total of answered questions for all submissions
//     // in each assignment, so they can be mapped to the results
//     // returned by the oracle promises

//     let sumAnswers = 0;
//     assn.submissions.forEach((subm, index) => {
//         assn.submissions[index]["startAt"] = sumAnswers;
//         Object.keys(subm).map(function(objectKey) {
//             if (objectKey.match(/(\d{1,2})/)) {
//                 sumAnswers++;
//             }
//         })
//     });

//     let keySubm;

//     assn.submissions.forEach(subm => {

//         Object.keys(subm).map(function(objectKey, index) {
//             const value = subm[objectKey];

//             if (objectKey.match(/(\d{1,2})/)) {

//                 const oraclePromise = oracle(value);
//                 oraclePromises.push(oraclePromise);
//             }
//         });

//         Promise.all(oraclePromises)
//             .then((values) => {

//                 Object.keys(subm).map(function(objectKey, index) {

//                     if (objectKey.match(/(\d{1,2})/)) {
//                         const query = subm[objectKey];
//                         const qa = Object.create(null);
//                         const startAt = subm["startAt"];

//                         qa["answer"] = query;
//                         qa["response"] = values[startAt + index];
//                         subm[objectKey] = qa;
//                     }

//                 });

//                 if (subm.key === true) {
//                     keySubm = subm;
//                 }

//                 return subm;
//             })
//             .then((values) => {
//                 // console.log(keySubm);

//                 wstream.write("\n\n---\n");
//                 wstream.write("\n## " + values.filename + "\n");

//                 // jsdiff against key, then write diff result

//                 Object.keys(values).map(function(objectKey) {
//                     if (objectKey.match(/(\d{1,2})/)) {
//                         wstream.write("\n### Question " + objectKey);
//                         wstream.write("\n#### Answer\n<code>" + values[objectKey].answer + "</code>\n");
//                         wstream.write("\n#### Response\n<code>" + JSON.stringify(values[objectKey].response) + "</code>\n");
//                         if (values.key !== true) {
//                             const diff = jsdiff.diffChars(JSON.stringify(values[objectKey].response), JSON.stringify(keySubm[objectKey].response), { ignoreCase: true });


//                             const diffArr = [];
//                             diff.forEach(function(part) {
//                                 if (part.removed === undefined && part.added === undefined) {
//                                     diffArr.push(true);
//                                     // wstream.write("\nResponse matches key");
//                                 } else {
//                                     diffArr.push(false);
//                                     // wstream.write("\nResponse does not match key");
//                                 }
//                             });

//                             const isTrue = function(val) {
//                                 return val === true;
//                             }
//                             if (diffArr.every(isTrue)) {
//                                 wstream.write("\nResponse matches key");
//                             } else {
//                                 wstream.write("\nResponse does not match key");
//                             }
//                         }
//                     }
//                 })

//             })
//             .catch((e) => {
//                 console.log(e)
//             });
//     })

// })