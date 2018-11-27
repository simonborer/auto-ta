// Import node modules
const fs = require('fs'),
    jsdiff = require('diff');

require('colors');

// Import custom modules
const getAssignments = require('./get-assignments'),
    oracle = require('./oracle'),
    util = require('./util'),
    htmlSnippets = require('./html-snippets');

const oraclePromises = [];

util.mkdirSync('./output/oracle');

const getOracle = function(){
    getAssignments.forEach(assn => {

        const wstream = fs.createWriteStream('./output/oracle/' + assn.assignment + '-output.html');

        wstream.write(htmlSnippets.header(assn.assignment));
        wstream.write("<h1>" + assn.assignment + "</h1>");

        // Put key first
        const obj = assn.submissions.find(obj => obj.key === true);
        const index = assn.submissions.indexOf(obj);

        if (index !== -1) {
            assn.submissions.splice(index, 1);
            assn.submissions.unshift(obj);
        }

        // Get the sum total of answered questions for all submissions
        // in each assignment, so they can be mapped to the results
        // returned by the oracle promises

        let sumAnswers = 0;
        assn.submissions.forEach((subm, index) => {
            assn.submissions[index]["startAt"] = sumAnswers;
            Object.keys(subm).map(function(objectKey) {
                if (objectKey.match(/(\d{1,2})/)) {
                    sumAnswers++;
                }
            })
        });

        let keySubm;

        assn.submissions.forEach(subm => {

            Object.keys(subm).map(function(objectKey, index) {
                const value = subm[objectKey];

                if (objectKey.match(/(\d{1,2})/)) {

                    const oraclePromise = oracle(value);
                    oraclePromises.push(oraclePromise);
                }
            });

            Promise.all(oraclePromises)
                .then((values) => {

                    Object.keys(subm).map(function(objectKey, index) {

                        if (objectKey.match(/(\d{1,2})/)) {
                            const query = subm[objectKey];
                            const qa = Object.create(null);
                            const startAt = subm["startAt"];

                            qa["answer"] = query;
                            qa["response"] = values[startAt + index];
                            subm[objectKey] = qa;
                        }

                    });

                    if (subm.key === true) {
                        keySubm = subm;
                    }

                    return subm;
                })
                .then((values) => {

                    wstream.write("<hr>");
                    wstream.write("<h2>" + values.filename + "</h2>");

                    // jsdiff against key, then write diff result

                    Object.keys(values).map(function(objectKey) {
                        wstream.write("<table class='unstriped results-table'><tbody>");

                        if (objectKey.match(/(\d{1,2})/)) {
                            wstream.write("<tr><td><strong>Question " + objectKey + "</strong></tr>");
                            wstream.write("<tr><td><code class='language-sql'>" + values[objectKey].answer + "</code></td></tr>");
                            wstream.write("<tr><td><label class='toggle__label button' for='toggle" + values.filename + objectKey + "'>Show response</label><input class='toggle__input' type='checkbox' id='toggle" + values.filename + objectKey + "'><div class='toggle__target'><code class='language-sql'>" + JSON.stringify(values[objectKey].response) + "</code></div></td></tr>");

                            if (values.key !== true) {

                                const keyDiff = jsdiff.diffChars(JSON.stringify(keySubm[objectKey].answer), JSON.stringify(values[objectKey].answer), { ignoreCase: true });
                                const keyDiffOrigin = jsdiff.diffChars(JSON.stringify(values[objectKey].answer), JSON.stringify(keySubm[objectKey].answer), { ignoreCase: true });

                                let color;

                                const keyDiffArr = [];
                                const keyDiffOriginArr = [];

                                keyDiff.forEach(function(part) {
                                    if ((part.added && part.added !== 'undefined') || (!part.added && !part.removed)) {
                                        color = part.added ? 'green' :
                                            part.removed ? 'red' : 'grey';
                                        keyDiffArr.push('<span class="' + color + '">' + part.value + '</span>')
                                    }
                                });

                                keyDiffOrigin.forEach(function(part) {
                                    if ((part.added && part.added !== 'undefined') || (!part.added && !part.removed)) {
                                        color = part.added ? 'red' :
                                            part.removed ? 'green' : 'grey';
                                        keyDiffOriginArr.push('<span class="' + color + '">' + part.value + '</span>')
                                    }
                                });

                                wstream.write("<tr><td><label class='toggle__label button' for='toggleKeyDiff" + values.filename + objectKey + "'>Show diff with key</label><input class='toggle__input' type='checkbox' id='toggleKeyDiff" + values.filename + objectKey + "'><div class='toggle__target'><table><thead><tr><th>Answer</th><th>Key</th></thead><tbody><tr><td><code>" + keyDiffArr.join('') + "</code></td><td><code>" + keyDiffOriginArr.join('') + "</code></td></tbody></table></div></td></tr>");

                                const diff = jsdiff.diffChars(JSON.stringify(values[objectKey].response), JSON.stringify(keySubm[objectKey].response), { ignoreCase: true });

                                let diffArr = [];

                                diff.forEach(function(part) {
                                    if (part.removed === undefined && part.added === undefined) {
                                        diffArr.push(true);
                                    } else {
                                        diffArr.push(false);
                                    }
                                });

                                if (JSON.stringify(values[objectKey].response).match(/^"ORA/)) {
                                    diffArr = [];
                                    diffArr.push('error');
                                }

                                const isTrue = function(val) {
                                    return val === true;
                                }

                                if (diffArr.every(isTrue)) {
                                    wstream.write("<tfoot><tr><td><div class='callout success' data-callout-for='" + values.filename + "/question-" + objectKey + "'>Response matches key</div></td></tr></tfoot></tbody></table>");
                                } else if (diffArr[0] === 'error') {
                                    wstream.write("<tfoot><tr><td><div class='callout warning' data-callout-for='" + values.filename + "/question-" + objectKey + "'>Response returns an error</div></td></tr></tfoot></tbody></table>")
                                } else {
                                    wstream.write("<tfoot><tr><td><div class='callout alert' data-callout-for='" + values.filename + "/question-" + objectKey + "'>Response does not match key</div></td></tr></tfoot></tbody></table>");
                                }
                            }
                        }
                    });

                    return values;
                })
                .catch((e) => {
                    console.log(e)
                })
        })
    });
};

module.exports = getOracle;