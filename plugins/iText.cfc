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
	
}
