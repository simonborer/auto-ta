const fs = require('fs');

const util = Object.create(null);

util.mkdirSync = function (dirPath) {
  try {
    fs.mkdirSync(dirPath)
  } catch (err) {
    if (err.code !== 'EEXIST') throw err
  }
}

util.getPercent = function(num1, num2){
	const percent = Math.round(num1 / num2 * 100);
	return percent;
}

module.exports = util;