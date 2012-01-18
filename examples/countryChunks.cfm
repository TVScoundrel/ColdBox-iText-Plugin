<cfscript>
	
	countries = [
		{id = 1, name = "Belgium"},
		{id = 2, name = "USA"},
		{id = 3, name = "France"},
		{id = 4, name = "UK"},
		{id = 5, name = "South Africa"}
	];
	
	iText = getMyPlugin("iText");

	// set up the document as A4 which writes to a ByteArrayOutputStream in memory
	document = iText.standardSizeDocument(
		size="A4",
		leftMargin=20,
		rightMargin=20,
		topMargin=20,
		bottomMargin=20,
		landscape=false,
		measurement="metric"
	);
	baos = iText.getFullPath("java.io.ByteArrayOutputStream").init();
	writer = iText.get("PdfWriter").getInstance(document,baos);
	writer.setInitialLeading(16);
	// open the document for writing
	document.open();
	// create the font for the ID chunk
	font = iText.get("Font").init(iText.get("Font$FontFamily").HELVETICA, 6, iText.get("Font").BOLD, iText.get("BaseColor").WHITE);
	// loop through countries and add as chunks
	for (i = 1; i <= arrayLen(countries); i++){
		document.add(iText.get("Chunk").init(countries[i].name));
    document.add(iText.get("Chunk").init(" "));
    id = iText.get("Chunk").init(countries[i].id, font);
    // with a background color
    id.setBackground(iText.get("BaseColor").BLACK, javaCast("float", 1), javaCast("float", 0.5), javaCast("float", 1), javaCast("float", 1.5));
    // and a text rise
    id.setTextRise(6);
    document.add(id);
    document.add(iText.get("Chunk").NEWLINE);
	}
	// close the document and baos to finalise the byteArray
	document.close();
	baos.close();
	
	// show in browser
	iText.showInBrowser(baos.toByteArray());
</cfscript>