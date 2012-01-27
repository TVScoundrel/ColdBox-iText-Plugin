package com.tutuka.itext;

import com.itextpdf.text.Document;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class Header extends HeaderFooter {

	public Header(PdfWriter writer, Document document) {
		super(writer, document);
	}

	@Override
	public void print() {
		Integer pageNumber = getWriter().getPageNumber();
		if (getContent().containsKey(pageNumber))
			printPageHeader(pageNumber);
		else if (getDefaultContent() != null)
			printDefaultHeader();
	}

	private void printPageHeader(Integer pageNumber) {
		PdfPTable head = getContent().get(pageNumber);
		print(head);
	}

	private void printDefaultHeader() {
		PdfPTable head = getDefaultContent();
		print(head);
	}
	
	private void print(PdfPTable head){
		Document document = getDocument();
		PdfWriter writer = getWriter();
		Rectangle page = document.getPageSize();
		head.writeSelectedRows(
			0,
			-1,
			0,
			page.getHeight(),
			writer.getDirectContent()
		);
	}

	@Override
	public float getOriginalHeight() {
		return getOriginalTopMargin();
	}

}
