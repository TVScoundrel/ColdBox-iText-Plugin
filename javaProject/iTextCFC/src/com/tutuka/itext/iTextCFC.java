package com.tutuka.itext;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class iTextCFC {
	
	public static String[] getClassPath(String className, String jarPath) {
		
		FileInputStream fis = null;
		
		String dottedClassName = "." + className.replace("$", "\\$");
		
		List<String> classPath = new ArrayList<String>();
		Pattern classPattern = Pattern.compile(dottedClassName.replaceAll("\\.", "\\\\.") + "$");
		Matcher matcher = null;
		
		try {
			
			fis = new FileInputStream(jarPath);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		if (fis != null) {
			
			ZipInputStream zis = new ZipInputStream(fis);
			ZipEntry ze = null;
			
			try {
				
				while ((ze = zis.getNextEntry()) != null) {
					String entryName = ze.getName();
					if (entryName.indexOf(".class") != -1) {
						String baseName = entryName.replaceAll(".class", "").replaceAll("/", ".");
						matcher = classPattern.matcher(baseName);
						while (matcher.find()) {
							classPath.add(baseName);
							System.out.println(baseName);
						}
					}
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		String[] classes = new String[classPath.size()];
		classPath.toArray(classes);
		
		return classes;
	}
	
	public static void main(String[] args) {
		//getClassPath("ZapfDingbatsNumberList","E:/www/development/CorporateGiftCard/plugins/iText-lib/itextpdf-5.1.3.jar");
		System.out.println("Hello World");
	}

}