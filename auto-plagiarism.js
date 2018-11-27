// Import node modules
const fs = require('fs'),
    jsdiff = require('diff');

require('colors');

// Import custom modules
const getAssignments = require('./get-assignments'),
    util = require('./util'),
    htmlSnippets = require('./html-snippets');

util.mkdirSync('./output/plagiarism');

const detect = function(threshold) {
    getAssignments.forEach(assn => {

        const wstream = fs.createWriteStream('./output/plagiarism/' + assn.assignment + '-output.html');
        wstream.write(htmlSnippets.header(assn.assignment));
        wstream.write("<h1><small>Assignment:</small> " + assn.assignment + "</h1>");


        // Remove the answer key from the diff'd files
        const obj = assn.submissions.find(obj => obj.key === true);
        const index = assn.submissions.indexOf(obj);

        if (index !== -1) {
            assn.submissions.splice(index, 1);
        }

        // Table of contents
        wstream.write("<hr><ul class='no-bullet'>");
        assn.submissions.forEach(asnmnt => {
            wstream.write("<li><a href='#" + asnmnt.filename + "'>" + asnmnt.filename + "</a></li>")
        });
        wstream.write("</ul>");

        // For each submission, initialize an array
        // This array will hold the flagged diffs
        assn.submissions.map((obj) => {
            obj.hits = [];
            return obj;
        });

        // Loops to create a match for each possible combination
        // of assignments
        for (let i = 0; i < assn.submissions.length; i++) {
            for (let j = i + 1; j < assn.submissions.length; j++) {

                // The two assignments being compared
                const initSubm = assn.submissions[i],
                    compSubm = assn.submissions[j];

                // For each numbered question in the assignment
                Object.keys(initSubm).forEach(qNum => {
                    if (qNum.match(/(\d{1,2})/)) {

                        // For each question in the assignment being compared
                        Object.keys(compSubm).forEach(compQNum => {
                            if (compQNum.match(/(\d{1,2})/)) {

                                // Stringify the responses in the two compared documents
                                // and run the diff
                                const initString = JSON.stringify(initSubm[qNum]),
                                    compString = JSON.stringify(compSubm[compQNum]);
                                const answerDiff = jsdiff.diffChars(initString, compString, { ignoreCase: true });
                                const compDiff = jsdiff.diffChars(compString, initString, { ignoreCase: true });

                                // Keep a tally of the unchanged characters
                                let sameSum = 0;

                                answerDiff.forEach(comparison => {
                                    if (!comparison.added && !comparison.removed) {
                                        sameSum = sameSum + comparison.count;
                                    }
                                });

                                // If the percent of unchanged characters is beyond the threshold
                                if (util.getPercent(sameSum, initString.length) > threshold && util.getPercent(sameSum, compString.length) > threshold) {
                                    
                                    const initHit = Object.create(null),
                                        compHit = Object.create(null),
                                        initDiffArrOrigin = [],
                                        initDiffArrVariation = [],
                                        compDiffArrOrigin = [],
                                        compDiffArrVariation = [];

                                    let color;

                                    // There's definitely a less-dumb way to do this, but it's 2am
                                    // Output the side-by-side diff
                                    answerDiff.forEach(function(part) {
                                        if ((part.added && part.added !== 'undefined') || (!part.added && !part.removed)) {
                                            color = part.added ? 'green' :
                                                part.removed ? 'red' : 'grey';
                                            initDiffArrOrigin.push('<span class="' + color + '">' + part.value + '</span>');
                                        }

                                        if ((part.removed && part.removed !== 'undefined') || (!part.added && !part.removed)) {
                                            color = part.added ? 'green' :
                                                part.removed ? 'red' : 'grey';
                                            initDiffArrVariation.push('<span class="' + color + '">' + part.value + '</span>');
                                        }
                                    });

                                    // The side-by-side diff needs to be generated for both of the two files
                                    // since a flag on one file means a flag on the other
                                    compDiff.forEach(function(part) {
                                        if ((part.added && part.added !== 'undefined') || (!part.added && !part.removed)) {
                                            color = part.added ? 'green' :
                                                part.removed ? 'red' : 'grey';
                                            compDiffArrOrigin.push('<span class="' + color + '">' + part.value + '</span>');
                                        }

                                        if ((part.removed && part.removed !== 'undefined') || (!part.added && !part.removed)) {
                                            color = part.added ? 'green' :
                                                part.removed ? 'red' : 'grey';
                                            compDiffArrVariation.push('<span class="' + color + '">' + part.value + '</span>');
                                        }
                                    });

                                    // Add the 'hit' data to the submission's object
                                    initHit.percent = util.getPercent(sameSum, initString.length);
                                    compHit.percent = util.getPercent(sameSum, compString.length);

                                    initHit.compareFile = compSubm.filename;
                                    initHit.thisQues = qNum;
                                    initHit.compareQues = compQNum;

                                    compHit.compareFile = initSubm.filename;
                                    compHit.thisQues = compQNum;
                                    compHit.compareQues = qNum;

                                    initHit.diff = Object.create(null);
                                    compHit.diff = Object.create(null);

                                    initHit.diff.sideOne = initDiffArrOrigin;
                                    initHit.diff.sideTwo = initDiffArrVariation;

                                    compHit.diff.sideOne = compDiffArrOrigin;
                                    compHit.diff.sideTwo = compDiffArrVariation;

                                    assn.submissions.forEach(submssn => {
                                        if (submssn.filename === initSubm.filename) {
                                            submssn.hits.push(initHit);
                                        } else if (submssn.filename === compSubm.filename) {
                                            submssn.hits.push(compHit);
                                        }
                                    });
                                }

                            }
                        });

                    }

                });
            }
        }

        // Create the reporting
        assn.submissions.forEach(asnmnt => {

            wstream.write("<hr><h2 id='" + asnmnt.filename + "'><strong><small>File:</small> " + asnmnt.filename + "</strong></h2>");

            // Sort the 'hits' by file
            const hitCount = [];
            const compare = function(a, b) {
                if (a.last_nom < b.last_nom)
                    return -1;
                if (a.last_nom > b.last_nom)
                    return 1;
                return 0;
            }

            asnmnt.hits.sort(compare);
            asnmnt.hits.forEach(hit => {
                hitCount.push(hit.compareFile);
            });

            // Get the number of hits per file
            const counts = {};

            for (let i = 0; i < hitCount.length; i++) {
                const num = hitCount[i];
                counts[num] = counts[num] ? counts[num] + 1 : 1;
            }

            let responseCss = "success";

            if (hitCount.length > 0) {
                responseCss = "alert";
            }

            wstream.write("<div class='callout callout--response " + responseCss + "'>");

            Object.keys(counts).forEach(key => {
                wstream.write("<p><strong>" + counts[key] + "</strong> answers flagged in <strong>" + key + "</strong>");
            });

            wstream.write("</div>");

            // Get list of files with 'hits'
            const hitFiles = [...new Set(hitCount)];

            // Output the side-by-side diffs
            hitFiles.forEach(hit => {
                wstream.write("<h3 class='diff-header'><small>Diff with:</small> " + hit + "</h3>");
                asnmnt.hits.forEach(asnHit => {
                    if (asnHit.compareFile === hit) {
                        wstream.write("<table><thead><tr><th colspan='2'>" + asnHit.percent + "% match</th></tr>");
                        wstream.write("<tr><th>" + asnmnt.filename + "</th><th>" + hit + "</th></tr></thead><tbody><tr>");
                        wstream.write("<td><code>" + asnHit.diff.sideOne + "</code></td>");
                        wstream.write("<td><code>" + asnHit.diff.sideTwo + "</code></td>");
                        wstream.write("</tr></tbody></table>");
                    }
                });
            });
        });

        wstream.write(htmlSnippets.footer());

    });
};

module.exports = detect;