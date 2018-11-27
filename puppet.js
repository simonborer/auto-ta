const puppeteer = require('puppeteer'),
    chalk = require('chalk'),
    fs = require('fs-extra');

async function puppet(username, password, courseId, cvid) {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    const USERNAME_SELECTOR = '#username',
        PASSWORD_SELECTOR = '#password',
        BUTTON_SELECTOR = '#fm1 > section.row > input.btn-submit';

    console.log(chalk.magenta("starting"));

    await page.goto('https://login.humber.ca/cas/login');

    console.log(chalk.magenta("login page"));

    await page.click(USERNAME_SELECTOR);
    await page.keyboard.type(username);

    await page.click(PASSWORD_SELECTOR);
    await page.keyboard.type(password);

    await page.click(BUTTON_SELECTOR);

    console.log(chalk.magenta("login submitted, waiting for navigation"));
    await page.waitForNavigation();

    console.log(chalk.magenta("redirect successful"));
    await page.goto('https://learn.humber.ca/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1');
    await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/viewNeedsGrading?sortDir=ASCENDING&sortCol=attemptDate&course_id=' + courseId + '&editPaging=true&numResults=200');
    await page.setViewport({ width: 9999, height: 9999 });
    console.log('navigated to "Needs grading"');
    await page.waitForSelector('#listContainer_databody');
    console.log('listContainer loaded');
    const asnLinks = await page.evaluate(() => {
        const links = Array.from(document.querySelectorAll('#listContainer_databody > tr > th > a'));
        return links.map(link => {
            const linkObj = Object.create(null);
            linkObj.script = link.getAttribute('onclick').replace("javascript:", "");
            linkObj.assn = link.parentElement.previousElementSibling.querySelectorAll('.table-data-cell-value')[0].textContent.trim();
            return linkObj;
        });
    });
    for (const link of asnLinks) {
        console.log("executing " + link.script);
        await page.evaluate(link.script);
        await page.waitForNavigation({ timeout: 10000 });
        const downloadLinks = await page.evaluate(() => {
            const dlLinks = Array.from(document.querySelectorAll('.dwnldBtn'));
            return dlLinks.map(dlLink => dlLink.getAttribute('href'));
        });

// TODO name file for student
// txt => sql
// 		remove html

        async function mkLinkDir(directory) {
            try {
                await fs.ensureDir(directory);
                console.log('success!');
            } catch (err) {
                console.error(err);
            }
        }

        mkLinkDir('./assignments/' + link.assn);

        if (downloadLinks.length) {
            for (const dlLink of downloadLinks) {
                console.log(dlLink);
                await page._client.send('Page.setDownloadBehavior', {
                    behavior: 'allow',
                    downloadPath: './assignments/' + link.assn
                });
                await page.click('a[href="' + dlLink + '"]');
            }
        } else {
            const content = await page.evaluate(el => el.innerHTML, await page.$('#previewerInner'));
            fs.writeFile('./assignments/' + link.assn + '/message.txt', content, (err) => {
                if (err) throw err;
                console.log('The file has been saved!');
            });
        }
        await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/viewNeedsGrading?sortDir=ASCENDING&sortCol=attemptDate&course_id=' + courseId + '&editPaging=true&numResults=200');

    }







    //     console.log("loading " + courseId + " with cvid " + cvid);
    //     await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/enterGradeCenter?course_id=' + courseId + '&cvid=' + cvid, { waitUntil: 'networkidle0' });

    //     console.log("waiting for table...".yellow);
    //     await page.screenshot({ path: 'screenshots/humber1.png' });
    //     await page.waitForSelector('#table1');
    //     console.log("table loaded, waiting for links".yellow);
    //     await page.waitForSelector('#table1 > tbody > tr > td > div.gbDivWrapper > span.contextMenuContainer > a');

    //     const asnLinks = await page.evaluate(() => {
    //         const links = Array.from(document.querySelectorAll('#table1 > tbody > tr > td:not(:first-of-type) > div.gbDivWrapper > span.contextMenuContainer > a'))
    //         return links.map(link => link.id);
    //     });

    //     console.log(asnLinks);

    // process.on('unhandledRejection', (reason, p) => {
    //     console.error('Unhandled Rejection at: Promise', p, 'reason:', reason);
    //     browser.close();
    // });


    // 	//async function clickAsnLinks() {
    // 		for (const assn of asnLinks) {
    // 			console.log("waiting for " + assn);
    // 			const assnId = "#" + assn;
    // 			const assnIdImg = assnId + " > img";
    // 			await page.$eval(assnId, e => e.setAttribute("style", "display:block"));
    // 			await page.waitForSelector(assnIdImg, {visible: true});
    // 			console.log("clicking " + assnIdImg);
    // 			await page.click(assnIdImg);
    // 			const assnDivId = "#" + assn.replace("link", "div");
    // 			console.log("clicked " + assn + ", waiting for " + assnDivId);
    // 			await page.screenshot({ path: 'screenshots/humber-clicked.png' });
    // 			await page.waitForSelector(assnDivId);
    // 		}
    //}

    // clickAsnLinks();

    // const linkHandlers = await page.$x("//a[contains(text(), 'learn.humber.ca')]");

    // if (linkHandlers.length > 0) {
    // 	console.log("link found".green);
    //     await linkHandlers[0].click();
    //     await page.waitForNavigation();
    //     await page.screenshot({ path: 'screenshots/humber.png' });
    // } else {
    //     throw new Error("Link not found");
    // }
    // await page.click('a[href="https://learn.humber.ca"]');
    // await console.log("navigated");
    // await page.goto('https://learn.humber.ca/webapps/gradebook/do/instructor/enterGradeCenter?course_id=_114784_1&cvid=981295');


    await browser.close();
}

module.exports = puppet;