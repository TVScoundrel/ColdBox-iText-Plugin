package com.tutuka.itext;

import java.util.HashMap;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

abstract class HeaderFooter {
	
	private PdfWriter writer;
	private Document document;
	private float width = 0f;
	private float originalTopMargin;
	private float originalBottemMargin;
	private PdfPTable defaultContent = null;
	private HashMap<Integer, PdfPTable> content = new HashMap<Integer, PdfPTable>();
	
	public HeaderFooter(PdfWriter writer, Document document){
		setWriter(writer);
		setDocument(document);
		setWidth(document.getPageSize().getWidth());
		setOriginalTopMargin(document.topMargin());
		setOriginalBottemMargin(document.bottomMargin());
	}
	
	public void setContentForPage(int pageNumber, PdfPTable pdfPTable){
		setPdfPTableMaxWidthToPageWidth(pdfPTable);
		content.put((Integer) pageNumber, pdfPTable);
	}
	
	private void setPdfPTableMaxWidthToPageWidth(PdfPTable pdfPTable) {
		if (pdfPTable.getTotalWidth() > width || pdfPTable.getTotalWidth() == 0){
			pdfPTable.setTotalWidth(width);
		}
	}

	public float getHeight(){
		PdfPTable pdfPTable = null;
		float height = 0;
		if (content.containsKey((Integer) writer.getPageNumber())){
			pdfPTable = content.get((Integer) writer.getPageNumber());
			height = pdfPTable.getTotalHeight();
		} else if (defaultContent != null) {
			height = defaultContent.getTotalHeight();
		} else {
			height = getOriginalHeight();
		}
		return height;
	}
	
	public PdfWriter getWriter() {
		return writer;
	}

	public void setWriter(PdfWriter writer) {
		this.writer = writer;
	}

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}

	public float getWidth() {
		return width;
	}

	public void setWidth(float width) {
		this.width = width;
	}

	public PdfPTable getDefaultContent() {
		return defaultContent;
	}

	public void setDefaultContent(PdfPTable defaultContent) {
		setPdfPTableMaxWidthToPageWidth(defaultContent);
		this.defaultContent = defaultContent;
	}

	public float getOriginalTopMargin() {
		return originalTopMargin;
	}

	public void setOriginalTopMargin(float originalTopMargin) {
		this.originalTopMargin = originalTopMargin;
	}

	public float getOriginalBottemMargin() {
		return originalBottemMargin;
	}

	public void setOriginalBottemMargin(float originalBottemMargin) {
		this.originalBottemMargin = originalBottemMargin;
	}

	public HashMap<Integer, PdfPTable> getContent() {
		return content;
	}

	public void setContent(HashMap<Integer, PdfPTable> content) {
		this.content = content;
	}

	abstract public void print();

	abstract public float getOriginalHeight();

}
