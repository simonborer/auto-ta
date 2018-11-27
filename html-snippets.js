const htmlSnippets = Object.create(null);

htmlSnippets.header = function(title) {
    const header = `<!doctype html>
	<html lang="">

	<head>
	  <meta charset="utf-8">
	  <meta http-equiv="x-ua-compatible" content="ie=edge">
	  <title>` + title + `</title>
	  <meta name="description" content="Pre-grading utility">
	  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	  <link rel="stylesheet" href="../../assets/foundation.min.css">
	  <link rel="stylesheet" href="../../assets/app.css">
	</head>

	<body>
	<div class="grid-x">
		<div class="cell large-8 large-offset-2 medium-10 medium-offset-1">`;

    return header;
};

htmlSnippets.footer = function() {
    const footer = '</div></div></body></html>';
    return footer;
};

module.exports = htmlSnippets;