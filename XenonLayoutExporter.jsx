/*
 * Project Xenon Layout Exporter
 * Create your layout in PS and export the filename and image coordinates.
 * Pointers taken from:
 * https://github.com/omgmog/photoshop-text-export - Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
 * https://forums.adobe.com/thread/1064028 - Dogspods
 * pfaffenbichler, 2009
 * 
*/

#target photoshop

function main()
{  
	if (!documents.length)
	{
		alert("No open file found. Please open atleast one file and run this script again.", "Project Xenon Layout Exporter");
		return;
	}
	
	if (documents.length > 1)
	{
		alert("More than one open document found. Only exporting the active document! Contact Krishna if you would like batch export, I left it out because I thought it would be a hindrance!", "Project Xenon Layout Exporter");
	}
	
	var docName = app.activeDocument.name;
    var docNameNewExt = docName.replace(".psd", ".txt");
	 
     // Actually, for now, we'll just have it in the same folder.
     //var newDocPath = "./levels/" + docNameNewExt;
     var newDocPath = app.activeDocument.path + "/" + docNameNewExt;
    
	var file = new File(newDocPath);  
	file.open("w", "TEXT", "????");
	$.os.search(/windows/i)  != -1 ? file.lineFeed = 'windows'  : file.lineFeed = 'macintosh';  
	
    exportData(file);
    file.close();
}

function exportData(file)
{   
   var ref = new ActionReference();   
   ref.putEnumerated(
                charIDToTypeID('Dcmn'),
                charIDToTypeID('Ordn'),
                charIDToTypeID('Trgt')
                );
                
   var count = executeActionGet(ref).getInteger(charIDToTypeID('NmbL')) +1;
   
   // For each layer in layers, ...
   // Apparently layers start from 1. 0 gives us issues
   for(var i = 1; i < count; ++i)
   {     
		ref = new ActionReference();   
		ref.putIndex(charIDToTypeID('Lyr '), i);
        
		var desc = executeActionGet(ref);  
		var layerName = desc.getString(charIDToTypeID( 'Nm  '));  
		var Id = desc.getInteger(stringIDToTypeID( 'layerID' ));
        
		if(layerName.match(/^<\/Layer group/))      continue;       // We don't want to export Layer groups!
        
        var vMask = desc.getBoolean(stringIDToTypeID('hasVectorMask' ));   
        try
        {  
              var adjust = typeIDToStringID(desc.getList (stringIDToTypeID('adjustment')).getClass (0));  
              if(vMask == true)
              {  
                  adjust = false;  
                  var Shape = true;
               }  
	   }
        catch(e)
        {
            var adjust = false;
            var Shape = false;
         }
     
        var layerType = typeIDToStringID(desc.getEnumerationValue(stringIDToTypeID('layerSection')));  
        var isLayerSet = (layerType == 'layerSectionContent') ? false : true;  
        var Vis = desc.getBoolean(stringIDToTypeID('visible'));   
        var descBounds = executeActionGet(ref).getObjectValue(stringIDToTypeID("bounds"));  
        var X = descBounds.getUnitDoubleValue(stringIDToTypeID('left'));  
        var Y = descBounds.getUnitDoubleValue(stringIDToTypeID('top'));
        
		if(Vis && !isLayerSet && !adjust)
        {
            file.writeln(layerName + ",", + X + "," + Y);
        }
   };
};  

// Run the whole thing.
main();

if (app.documents.length > 0) {
////////////////////////////////////
// get document-path and -title;
	var myDocument = app.activeDocument;
	var myDocName = myDocument.name.match(/(.*)\.[^\.]+$/)[1];
	var myPath = myDocument.path;
	var theLayerSets = collectLayerSets(myDocument);
////// filter for checking if entry is numeric, thanks to xbytor //////
	numberKeystrokeFilter = function() {
	this.text = this.text.replace(",", "");
	this.text = this.text.replace(".", "");
	if (this.text.match(/[^\-\.\d]/)) {
		this.text = this.text.replace(/[^\-\.\d]/g, "");
		};
	if (this.text == "") {
		this.text = "0"
		}
	};
////////////////////////////////////
// create the dialog;	
	var dlg = new Window('dialog', "pdfs from layersets", [500,300,930,840]);	
//create list for layer-selection;
	dlg.layerRange = dlg.add('panel', [21,20,279,445], "select layersets to create pdfs of");
	dlg.layerRange.layersList = dlg.layerRange.add('listbox', [11,20,240,405], '', {multiselect: true});
	for (var q = 0; q < theLayerSets.length; q++) {
		dlg.layerRange.layersList.add ("item", theLayerSets[q].name);
		dlg.layerRange.layersList.items[q].selected = true
		};
// entry for suffix;
	dlg.suffix = dlg.add('panel', [290,20,410,85], "enter suffix");
	dlg.suffix.suffixText = dlg.suffix.add('edittext', [11,20,99,40], "", {multiline:false});
// entry for number;
	dlg.number = dlg.add('panel', [290,100,410,165], "start with #");
	dlg.number.startNumber = dlg.number.add('edittext', [11,20,45,40], "1", {multiline:false});
	dlg.number.addNumber = dlg.number.add('checkbox', [55,20,105,40], "add", {multiline:false});
	dlg.number.startNumber.onChange = numberKeystrokeFilter;
// field to add layer-name;
	dlg.layerName = dlg.add('panel', [290,180,410,270], "layer-name");
	dlg.layerName.doAddName = dlg.layerName.add('radiobutton', [11,20,120,40], "add it");
	dlg.layerName.dontAddName = dlg.layerName.add('radiobutton', [11,45,120,65], "don’t add it");
	dlg.layerName.doAddName.value = true;
// field to select target-folder;
	dlg.target = dlg.add('panel', [290,285,410,445], "target-folder");
	dlg.target.targetSel = dlg.target.add('button', [11,20,100,40], "select");
	dlg.target.targetField = dlg.target.add('statictext', [11,50,100,155], String(myPath), {multiline:true});
	dlg.target.targetSel.onClick = function () {
		var target = Folder.selectDialog("select a target folder");
		dlg.target.targetField.text = target.fsName
		};
// ok- and cancel-buttons;
	dlg.buildBtn = dlg.add('button', [220,460,410,475], 'OK', {name:'ok'});
	dlg.cancelBtn = dlg.add('button', [21,460,210,475], 'Cancel', {name:'cancel'});
	dlg.warning = dlg.add('statictext', [21,490,410,530], "be advised: existing files of the same name will be replaced without prompting", {multiline: true});
	dlg.center();
////////////////////////////////////

		var theLayerSelection = new Array;
		var theColl = dlg.layerRange.layersList.items;
		for (var p = 0; p < dlg.layerRange.layersList.items.length; p++) {
		{
				theLayerSelection = theLayerSelection.concat(p);
		}

// collect the rest of the variables,
		var theSuffix = dlg.suffix.suffixText.text;
		var theNumber = Number (dlg.number.startNumber.text) - 1;
		var theLayerNameAdd = dlg.layerName.doAddName.value;
		var theDestination = dlg.target.targetField.text;
		var theNumbering = dlg.number.addNumber.value;
// PNG options
          var pngSaveOptions = new PNGSaveOptions();
          pngSaveOptions.compression = 9;
         
         var theVisibilities = new Array;
// create the pdf-name;
		if (theSuffix.length > 0) {
			var aSuffix = "_" + theSuffix
			}
		else {
			var aSuffix = ""
			};
// create a flattened copy;
		var theCopy = myDocument.duplicate("thecopy", true);
// do the operation;
		for (var m = theLayerSelection.length - 1; m >= 0; m--) {
			app.activeDocument = myDocument;
			var theLayer = theLayerSets[theLayerSelection[m]];
			if (theNumbering == true) {
				theNumber = bufferNumberWithZeros((Number (theNumber) + 1), 2);
				theNumberString =  "_" + theNumber
				};
			else {
				theNumberString = ""
				};
// get the layername for the pdf-name;
			if (theLayerNameAdd == true) {
				var aLayerName = "_" + theLayer.name.replace("/", "_")
				}
			else {
				var aLayerName = ""
				}			
// transfer layerset over to the copy;
			theLayer.duplicate (theCopy, ElementPlacement.PLACEATBEGINNING);
			app.activeDocument = theCopy;
// hide the llast added layer;
			theCopy.layers[1].visible = false;
			theCopy.saveAs((new File(theDestination+"/"+myDocName+aSuffix+aLayerName+theNumberString+".png")),pngSaveOptions,true)
			};
		theCopy.close(SaveOptions.DONOTSAVECHANGES);
		}
	};
else {alert ("no document open")};

function bufferNumberWithZeros (number, places)
{
	var theNumberString = String(number);
	for (var o = 0; o < (places - String(number).length); o++)
    {
		theNumberString = String("0" + theNumberString);
	};

	return theNumberString
};

function collectLayerSets (theParent)
{
	if (!allLayerSets)
    {
		var allLayerSets = new Array;
    } 
	
    for (var m = theParent.layers.length - 1; m >= 0;m--)
    {
		var theLayer = theParent.layers[m];
		if (theLayer.typename == "ArtLayer") 
        {
		//	allLayerSets = allLayerSets.concat(theLayer)
        }
        else{
// this line includes the layer groups;
			allLayerSets = allLayerSets.concat(theLayer);
			allLayerSets = allLayerSets.concat(collectLayerSets(theLayer))
			}
		}
	return allLayerSets
};

alert("Process complete.", "Project Xenon Layout Exporter");