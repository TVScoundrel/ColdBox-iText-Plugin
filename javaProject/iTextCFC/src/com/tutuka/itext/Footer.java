package com.tutuka.itext;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class Footer extends HeaderFooter {

	public Footer(PdfWriter writer, Document document) {
		super(writer, document);
	}

	@Override
	public void print() {
		Integer pageNumber = getWriter().getPageNumber();
		if (getContent().containsKey(pageNumber))
			printPageFooter(pageNumber);
		else if (getDefaultContent() != null)
			printDefaultFooter();
	}

	private void printPageFooter(Integer pageNumber) {
		PdfPTable foot = getContent().get(pageNumber);
		print(foot);
	}

	private void printDefaultFooter() {
		PdfPTable foot = getDefaultContent();
		print(foot);
	}

	private void print(PdfPTable foot) {
		PdfWriter writer = getWriter();
		foot.writeSelectedRows(
			0,
			-1,
			0,
			getHeight(),
			writer.getDirectContent()
		);
	}

	@Override
	public float getOriginalHeight() {
		return getOriginalBottemMargin();
	}

}
