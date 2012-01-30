<cfsavecontent variable="par1">
Bacon ipsum dolor sit amet prosciutto pastrami strip steak, tongue ground round salami cow. Chicken capicola short loin, pork belly chuck turducken sirloin cow tail sausage rump beef ribs ribeye. Tri-tip cow spare ribs salami. Ground round ball tip salami, corned beef t-bone filet mignon ham jerky meatloaf beef ribs short loin capicola chicken. Sausage corned beef chicken sirloin jerky.
Swine pork loin boudin meatloaf pastrami brisket, jowl leberkäse prosciutto short loin bacon. Ham hock filet mignon swine brisket, salami beef ribs short ribs pancetta.
</cfsavecontent>

<cfsavecontent variable="par2">
Ham tail shoulder, pig sirloin t-bone pork belly capicola tri-tip bacon sausage ham hock spare ribs ground round. Pork chop brisket ham short loin, ball tip salami sirloin swine pig ham hock t-bone. Pork loin bacon frankfurter boudin, shank bresaola drumstick pancetta sirloin fatback beef ribs ribeye leberkäse ground round. Ham corned beef flank, meatball venison pork loin strip steak bresaola tail spare ribs. Cow spare ribs ham meatloaf. Prosciutto ball tip pork belly strip steak. Sirloin swine tri-tip bacon.
</cfsavecontent>

<cfscript>
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

	// get a com.tutuka.itext.headerFooterHelper which is an extension of com.itextpdf.text.pdf.PdfPageEventHelper
	headerFooterHelper = iText.getHeaderFooterHelper(writer,document);
	writer.setPageEvent(headerFooterHelper);

	// headerFooterHelper has two members of types: com.tutuka.itext.Header and com.tutuka.itext.Footer
	// they are extensions of the com.tutuka.itext.HeaderFooter abstract class
	// get the header and footer from the headerFooterHelper so we can populate them to give our PDF some nice headers and footers
	header = headerFooterHelper.getHeader();
	footer = headerFooterHelper.getFooter();
	
	// Firstly, you can (but you don't have to) set a default header-content and footer-content
	// Lets do that anyway:
	// Note that the content can only be set as a PdfPTable
	// Your document's top and bottom margins will automatically adjust to your headers and footers
	
	defaultHead = iText.get("PdfPTable").init(1); // To keep it simple I create a PdfPTable with one column
	header.setDefaultContent(defaultHead); // set the table as the default header
	cell = iText.get("PdfPCell").init(iText.get("Phrase").init("This is the default header")); // A simple Phrase in a PdfPCell
	cell.setFixedHeight(javacast("float", 80)); // Set the height of the cell (for now only float = pt but will create calculate function soon)
	cell.setVerticalAlignment(iText.get("Element").ALIGN_MIDDLE); // just gona center everything
	cell.setHorizontalAlignment(iText.get("Element").ALIGN_CENTER);
	defaultHead.addCell(cell); // add the cell to the table
	
	// now doing exactly the same for the footer
	defaultFoot = iText.get("PdfPTable").init(1);
	footer.setDefaultContent(defaultFoot);
	cell = iText.get("PdfPCell").init(iText.get("Phrase").init("This is the default footer"));
	cell.setFixedHeight(javacast("float", 40));
	cell.setVerticalAlignment(iText.get("Element").ALIGN_MIDDLE);
	cell.setHorizontalAlignment(iText.get("Element").ALIGN_CENTER);
	defaultFoot.addCell(cell);
	
	// Nice, if we would run now, we would get a pdf with about 4 or 5 pages and each page has the same header and footer
	
	// Now I want a bigger header on the first page so...
	bigHead = iText.get("PdfPTable").init(1);
	header.setContentForPage(1, bigHead); // I am setting the content for page 1; the method name speaks for itself
	font = iText.get("Font").init(iText.get("BaseFont").createFont(), javacast("float", 26)); // Fool around with the font
	cell = iText.get("PdfPCell").init(iText.get("Phrase").init("I am a big header", font));
	cell.setFixedHeight(javacast("float", 140));
	cell.setVerticalAlignment(iText.get("Element").ALIGN_MIDDLE);
	cell.setHorizontalAlignment(iText.get("Element").ALIGN_CENTER);
	bigHead.addCell(cell);
	
	// Now I want a bigger footer on the first page to...
	bigFoot = iText.get("PdfPTable").init(1);
	footer.setContentForPage(1, bigFoot); // I am adding the content for page 1; the method name speaks for itself
	font = iText.get("Font").init(iText.get("BaseFont").createFont(), javacast("float", 20)); // Fool with the font
	cell = iText.get("PdfPCell").init(iText.get("Phrase").init("I am a big footer", font));
	cell.setFixedHeight(javacast("float", 60));
	cell.setVerticalAlignment(iText.get("Element").ALIGN_MIDDLE);
	cell.setHorizontalAlignment(iText.get("Element").ALIGN_CENTER);
	bigFoot.addCell(cell);
	
	// you can add new header and footer tables for any page you like; or you can reuse them:
	
	// I want the big header on page 4 with the default footer
	header.setContentForPage(4, bigHead);
	
	// And you want the big footer on page 3???
	footer.setContentForPage(3, bigFoot);
	
	// Pretty nifty huh?
		
	// open the document for writing
	document.open();
	
	// create a few paragraphs and add them to the document to get some pages
	par1 = iText.get("Paragraph").init(par1);
	par2 = iText.get("Paragraph").init(par2);
	document.add(par1);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	document.add(par1);
	document.add(par2);
	
	// close the document and baos to finalise the byteArray
	document.close();
	baos.close();
	
	// show in browser
	iText.showInBrowser(baos.toByteArray());	
</cfscript>