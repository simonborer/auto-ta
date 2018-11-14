// Returns object
// Keys are question #s
// Values are answers

const getQuestions = function(contents) {

    const questionsObj = Object.create(null);

    const parsedQuestions = contents
        .replace(/\n/g, " ")
        .split(/(-{1,3}\s*[Qq][uestion]*\s*\d{1,2})/)
        .filter(function(el) {
            return el !== "";
        })
        .map(function(el) {
            return el.replace(/(-{1,3}\s*[Qq][uestion]*\s*)/, "");
        })
        .map(s => s.trim());


    parsedQuestions.forEach((question, index) => {
        if (question.match(/^\d{1,2}/)) {
            const answer = parsedQuestions[index + 1];
            if (answer !== undefined) {
                questionsObj[question] = answer;
            } else {
                questionsObj[question] = "";
            }
        }
    });

    return questionsObj;
};

module.exports = getQuestions;