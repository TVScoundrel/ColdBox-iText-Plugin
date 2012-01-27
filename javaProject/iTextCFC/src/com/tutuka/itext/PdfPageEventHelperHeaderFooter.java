package com.tutuka.itext;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

public class PdfPageEventHelperHeaderFooter extends PdfPageEventHelper {
	private Header header;
	private Footer footer;
	
	public PdfPageEventHelperHeaderFooter(Header header, Footer footer) {
		super();
		setHeader(header);
		setFooter(footer);
	}
	
	public void onOpenDocument(PdfWriter writer, Document document){}
	
	public void onStartPage(PdfWriter writer, Document document){
		setMarginsForHeaderAndFooter(writer, document);
		document.newPage();
	}
	
	private void setMarginsForHeaderAndFooter(PdfWriter writer, Document document) {
		document.setMargins(
			document.leftMargin(),
			document.rightMargin(),
			header.getHeight(),
			footer.getHeight()
		);
	}

	public void onEndPage(PdfWriter writer, Document document){
		header.print();
		footer.print();
	}

	public Header getHeader() {
		return header;
	}

	public void setHeader(Header header) {
		this.header = header;
	}

	public Footer getFooter() {
		return footer;
	}

	public void setFooter(Footer footer) {
		this.footer = footer;
	}
}
