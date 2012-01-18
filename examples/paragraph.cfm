<cfsavecontent variable="par1">
Bacon ipsum dolor sit amet prosciutto pastrami strip steak, tongue ground round salami cow. Chicken capicola short loin, pork belly chuck turducken sirloin cow tail sausage rump beef ribs ribeye. Tri-tip cow spare ribs salami. Ground round ball tip salami, corned beef t-bone filet mignon ham jerky meatloaf beef ribs short loin capicola chicken. Sausage corned beef chicken sirloin jerky.
Swine pork loin boudin meatloaf pastrami brisket, jowl leberkäse prosciutto short loin bacon. Ham hock filet mignon swine brisket, salami beef ribs short ribs pancetta.
</cfsavecontent>

<cfsavecontent variable="par2">
Ham tail shoulder, pig sirloin t-bone pork belly capicola tri-tip bacon sausage ham hock spare ribs ground round. Pork chop brisket ham short loin, ball tip salami sirloin swine pig ham hock t-bone. Pork loin bacon frankfurter boudin, shank bresaola drumstick pancetta sirloin fatback beef ribs ribeye leberkäse ground round. Ham corned beef flank, meatball venison pork loin strip steak bresaola tail spare ribs. Cow spare ribs ham meatloaf. Prosciutto ball tip pork belly strip steak. Sirloin swine tri-tip bacon.
</cfsavecontent>

<cfscript>
	iText = getMyPlugin("iText");
	
	// set up the document as A4 wich writes to a ByteArrayOutputStream in memory
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
	
	// open the document for writing
	document.open();
	// create a few paragraphs and add them to the document
	par1 = iText.get("Paragraph").init(par1);
	par2 = iText.get("Paragraph").init(par2);
	document.add(par1);
	document.add(par2);
	// close the document and baos to finalise the byteArray
	document.close();
	baos.close();
	
	// show in browser
	iText.showInBrowser(baos.toByteArray());
</cfscript>