const puppeteer = require('puppeteer'),
    chalk = require('chalk'),
    chalkAnimation = require('chalk-animation'),
    fs = require('fs-extra'),
    h2p = require('html2plaintext'),
    StreamZip = require('node-stream-zip');

const walking = chalk.bold.cyan.bgMagenta,
    error = chalk.bold.red;

async function puppet(username, password, courseId, cvid) {
console.log(walking('Launching'));
const browser = await puppeteer.launch();
const page = await browser.newPage();

const USERNAME_SELECTOR = '#username',
    PASSWORD_SELECTOR = '#password',
    BUTTON_SELECTOR = '#fm1 > section.row > input.btn-submit';

console.log(walking('Logging in'));

await page.goto('https://login.humber.ca/cas/login');

console.log(walking('Submitting login info'));

await page.click(USERNAME_SELECTOR);
await page.keyboard.type(username);

await page.click(PASSWORD_SELECTOR);
await page.keyboard.type(password);

await page.click(BUTTON_SELECTOR);

console.log(walking('Login submitted'));

let str = 'This is where it usually goes wrong';
const rainbow = chalkAnimation.rainbow(str);

setInterval(() => {
    rainbow.replace(str += '.');
}, 1000);

try {
    await page.waitForNavigation();
} catch (error) {
    chalkAnimation.neon(err);
}

console.log(walking('Redirect successful'));

await page.goto('https://learn.humber.ca/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1');

console.log(walking('Navigating to grading page'));

await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/viewNeedsGrading?sortDir=ASCENDING&sortCol=attemptDate&course_id=' + courseId + '&editPaging=true&numResults=200');

console.log(walking('Setting viewport'));

await page.setViewport({ width: 9999, height: 9999 });

console.log(walking('Waiting for page to fully load'));

await page.waitForSelector('#listContainer_databody');

const asnLinks = await page.evaluate(() => {
    //     const links = Array.from(document.querySelectorAll('#listContainer_databody > tr > th > a'));
    //     return links.map(link => {
    //         const linkObj = Object.create(null);
    //         linkObj.script = link.getAttribute('onclick').replace("javascript:", "");
    //         linkObj.assn = link.parentElement.previousElementSibling.querySelectorAll('.table-data-cell-value')[0].textContent.trim();
    //         linkObj.student = link.textContent.trim().replace(/\s/g, "-").toLowerCase();
    //         return linkObj;
    //     });
});

async function mkLinkDir(directory) {
    try {
        await fs.ensureDir(directory);
    } catch (err) {
        console.log(error(err));
    }
}

console.log(walking('Making log folder'));

mkLinkDir('./assignments/logs');

console.log(walking('Making log file'));

const logFile = fs.createWriteStream('./assignments/logs/log.txt');

for (const link of asnLinks) {

    //     console.log(walking('Making ' + link.assn + ' directory'));

    //     mkLinkDir('./assignments/' + link.assn);

    //     console.log(walking("Executing " + link.script));

    //     await page.evaluate(link.script);

    //     console.log(walking('Navigating to submission page'));

    //     await page.waitForNavigation();

    //     const downloadLinks = await page.evaluate(() => {
    //         const dlLinks = Array.from(document.querySelectorAll('.dwnldBtn'));
    //         return dlLinks.map(dlLink => dlLink.getAttribute('href'));
    //     });

    //     // 		renaming
    //     // 		unzip

    //     if (downloadLinks.length) {

    //         console.log(walking('Downloading ' + downloadLinks.length + ' submission files'));

    //         for (const dlLink of downloadLinks) {

    //             console.log(walking('Logging ' + link.student + ' => ' + dlLink));

    //             logFile.write(link.student + ' => ' + dlLink + '\n\n');

    //             console.log(walking('Waiting for file download'));

    //             await page._client.send('Page.setDownloadBehavior', {
    //                 behavior: 'allow',
    //                 downloadPath: './assignments/' + link.assn
    //             });

    //             await page.click('a[href="' + dlLink + '"]');

    //             console.log(walking('Downloaded ' + dlLink));
    //         }
    //     } else {

    //         console.log(walking('Scraping submission text'));

    //         const content = await page.evaluate(el => el.innerHTML, await page.$('#previewerInner'));

    //         console.log(walking('Parsing text from raw markup'));

    //         const parsedContent = h2p(content);

    //         console.log(walking('Writing submission text to ./assignments/' + link.assn + '/' + link.student + '.sql'));
    //         fs.writeFile('./assignments/' + link.assn + '/' + link.student + '.sql', parsedContent, (err) => {
    //             if (err) throw err;
    //         });
    //     }

    //     console.log(walking('Returning to grading page'));
    //     await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/viewNeedsGrading?sortDir=ASCENDING&sortCol=attemptDate&course_id=' + courseId + '&editPaging=true&numResults=200');

}

console.log(walking('Closing log file'));

logFile.end();

console.log(walking('Closing browser'));

await browser.close();

console.log(walking('Listing subdirectories in assignments'));

    const dirCont = fs.readdirSync('assignments');

    dirCont.forEach(folder => {

        // Create an object for each assignment
        const subfolder = fs.readdirSync('assignments/' + folder);

        subfolder.forEach(file => {
        	console.log(file);
            const fileExt = file.substring(file.length - 4),
            	filePath = 'assignments/' + folder + '/';
            switch (fileExt) {
                case '.txt':
                    const newName = file.replace('.txt', '.sql');
                    console.log(walking('Renaming ' + file + ' to ' + newName));
                    try {
	                    fs.rename(filePath + file, filePath + newName);                	
                    } catch (error) {
                    	console.log(error);
                    }
                    break;
                case '.zip':
                    console.log(walking('Unzipping ' + file));

                    const zip = new StreamZip({
                        file: filePath + file,
                        storeEntries: true
                    });

                    try {
                        zip.on('ready', () => {
                            zip.extract(null, './' + filePath, (err, count) => {
                                console.log(err ? 'Extract error' : `Extracted ${count} entries`);
                                zip.close();
                            });
                        });
                    } catch (error) {
                        chalkAnimation.neon(error);
                    }
                    break;
            }
        })

    });
}

module.exports = puppet;