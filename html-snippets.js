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
		<style>
			.toggle__label:hover {
				text-decoration: underline;
  				cursor: pointer;
			}
			.toggle__input {
				position: absolute;
				left: -999em;
			}
			.toggle__target {
				max-height: 0;
				overflow: hidden;
			}
			.toggle__input:checked + .toggle__target {
				max-height: 99em;
			}
			.callout {
				margin-bottom: 0;
			}
			.results-table {
				margin-bottom: 2rem;
			}
			code[class*="language-"],
			pre[class*="language-"] {
				color: #f8f8f2;
				background: #144270;
				text-shadow: 0 1px rgba(0, 0, 0, 0.3);
				font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;

				line-height: 1.5;

				-moz-tab-size: 4;
				-o-tab-size: 4;
				tab-size: 4;

				-webkit-hyphens: none;
				-moz-hyphens: none;
				-ms-hyphens: none;
				hyphens: none;
			}
			.grey{
				color: grey;
			}
			.red{
				color: red;
			}
			.green{
				color: green;
			}

		</style>
	</head>

	<body>
	<div class="grid-x">
		<div class="cell large-6 large-offset-3 medium-10 medium-offset-1">`;

    return header;
};

htmlSnippets.footer = function() {
    const footer = '</div></div></body></html>';
    return footer;
};

module.exports = htmlSnippets;