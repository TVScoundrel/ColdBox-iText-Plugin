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

	// open the document for writing
	document.open();
	
	// Create a List
	list = iText.get("RomanList").init();
	
	// Create a ListItem
	item = iText.get("ListItem").init("Pancakes");
	
	// Create a sub-list
	ingredients = iText.get("GreekList").init();
	ingredients..setLowercase(iText.get("List").LOWERCASE);
	
	inItem1 = iText.get("ListItem").init("Eggs");
	
	// Create a sub-sub-list
	desc = iText.get("ZapfDingbatsNumberList").init(0);
	desc.add("Preferably fresh");
	desc.add("Throw in water to test");
	inItem1.add(desc);
	
	inItem2 = iText.get("ListItem").init("Flower");
	// Create a sub-sub-list
	desc = iText.get("ZapfDingbatsNumberList").init(0);
	desc.add("Virgin white");
	inItem2.add(desc);
	
	inItem3 = iText.get("ListItem").init("Milk");
	// Create a sub-sub-list
	desc = iText.get("ZapfDingbatsNumberList").init(0);
	desc.add("Full cream!!!");
	inItem3.add(desc);
	
	ingredients.add(inItem1);
	ingredients.add(inItem2);
	ingredients.add(inItem3);
	
	item.add(ingredients);
	list.add(item);
	
	document.add(list);
	// close the document and baos to finalise the byteArray
	document.close();
	baos.close();
	
	// show in browser
	iText.showInBrowser(baos.toByteArray());
</cfscript>