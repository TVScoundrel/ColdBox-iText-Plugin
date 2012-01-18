/**
* iText Project that provides iText PDF operations to ColdBox applications
*/
component extends="coldbox.system.Plugin" singleton="true"{
	
	property name="jl" inject="coldbox:plugin:JavaLoader";
	property name="libPath" type="string";
	
	/**
	* constructor
	*/
	iText function init(required any controller){
		super.init(arguments.controller);
			
		// Plugin Properties
		setPluginName("iText");
		setPluginVersion("1.0");
		setPluginDescription("iText Project that provides iText PDF operations to ColdBox applications");
		setPluginAuthor("Tom Van Schoor");
		setPluginAuthorURL("www.tutuka.com");
		
		return this;
	}
	
	function onDIComplete(){
		// Set the library path
		libPath 	= "/#getSetting("appMapping")#/plugins/iText-lib";
		// Load jar files.
		jl.appendPaths(expandPath("#libPath#"));
	}
	
	/**
	* Wrapper to get any class from a full or partial path in itextpdf-5.1.3.jar
	*/
	any function get(required string class, boolean partial = true){
		
		var classPath = arguments.class;
		
		if (arguments.partial){
			var iTextClasses = jl.create("com.tutuka.itext.iTextCFC");
			var classPaths = iTextClasses.getClassPath(arguments.class, "#expandPath("#libPath#")#/itextpdf-5.1.3.jar");

			if (arrayLen(classPaths) > 1) {
				throw(message="Multiple classes found: #arrayToList(classPath)#");
			}
			
			if (arrayLen(classPaths) == 0) {
				throw(message="Class not found");
			}			

			var classPath = classPaths[1];
		}
		
		return jl.create(classPath);
	}
	
	/**
	* Wrapper to get any class from a full path in CLASSPATH
	*/
	any function getFullPath(required string class){
		return get(arguments.class, false);
	}
	
	/**
	* returns a document with given dimentions in
	* - mm. if measurement = metric
	* - in. if measurement = imperial
	* - user space units by default (1/72 in. = 1pt if in 72ppi)
	*/
	any function sizedDocument(
		required numeric pageWidth,
		required numeric pageHeight,
		required numeric leftMargin,
		required numeric rightMargin,
		required numeric topMargin,
		required numeric bottomMargin,
		string measurement = "pt"
	){
		// get the dimensions according to measurement
		var dimensions = calculateUserSpaceUnits(argumentCollection = arguments);
		// set the page size
		local.pageSize = get("Rectangle").init(dimensions.pageWidth, dimensions.pageHeight);
		// get a Document initialized with calculated dimensions
		return get("Document").init(local.pageSize, dimensions.leftMargin, dimensions.rightMargin, dimensions.topMargin, dimensions.bottomMargin);
	}
	
	/**
	* returns a document with given standard size in
	* - mm. if measurement = metric
	* - in. if measurement = imperial
	* - user space units by default (1/72 in. = 1pt if in 72ppi)
	*/
	any function standardSizeDocument(
		required string size,
		required numeric leftMargin,
		required numeric rightMargin,
		required numeric topMargin,
		required numeric bottomMargin,
		boolean landscape = false,
		string measurement = "pt"
	){
		// get the dimensions according to measurement
		var dimensions = calculateUserSpaceUnits(argumentCollection = arguments);
		// get the standard sizes
		var standardSizes = get("PageSize").init();
		// set the page size
		if(arguments.landscape){
			local.pageSize = get("Rectangle").init(evaluate("standardSizes.#arguments.size#.rotate()"));
		} else {
			local.pageSize = get("Rectangle").init(evaluate("standardSizes.#arguments.size#"));
		}
		// get a Document initialized with calculated dimensions
		return get("Document").init(local.pageSize, dimensions.leftMargin, dimensions.rightMargin, dimensions.topMargin, dimensions.bottomMargin);
	}
	
	/**
	*
	*/
	void function showInBrowser(required any content){
		// alternative for:
		// <cfcontent type="application/pdf" reset="true" variable="#arguments.content#">
		response = getPageContext().getFusionContext().getResponse();
		response.setHeader("Content-Type", "application/pdf");
		response.getOutputStream().writeThrough(arguments.content);
	}
	
	/**
	* Function to calculate the user space units used in PDF
	* according to the chosen measurement system
	* - mm. if measurement = metric
	* - in. if measurement = imperial
	* - user space units by default (1/72 in. = 1pt if in 72ppi)
	*/
	private Struct function calculateUserSpaceUnits(required String measurement){
		
		// Only arguments with a key that is in includeArgs list will be returned
		var includeArgs = "pageWidth,pageHeight,leftMargin,rightMargin,topMargin,bottomMargin";
		var measurementStruct = {};
		
		// get the correct unit / ratio
		switch(arguments.measurement){
			case "metric":
				var unit = 25.4;
				var ratio = 72;
				break;
			case "imperial":
				var unit = 1;
				var ratio = 72;
				break;
			default:
				// PDF user space units
				var unit = 1;
				var ratio = 1;
				break;
		}
		
		// calculate each legal argument
		for (key in arguments){
			if (listFindNoCase(includeArgs, key)){
				measurementStruct[key] = javacast("float", arguments[key] / unit * ratio);
			}
		}
		
		return measurementStruct;
	}
}
