#@ File (label = "Input File", style ="file") filepath
#@ File (label = "Output directory", style = "directory") output
#@ int (label = "Use channel") ch

roiManager("reset");
run("Bio-Formats Macro Extensions");
Ext.setId(filepath);
Ext.getSeriesCount(seriesCount);
print(seriesCount+" series in "+filepath);
for (j=0; j<seriesCount; j++) {
	run("Bio-Formats Importer", "open=["+filepath+"] color_mode=Default view=Hyperstack stack=XYCZT series_"+(j+1));
	seriesName=getTitle();
	if (indexOf(seriesName, "Maximum") >= 0) {
		close();
	} else {
		image_stack = seriesName;
		kc_stack = image_stack+"_kinetochore_substack";
		run("Duplicate...", "duplicate channels="+ch);
		run("Z Project...", "projection=[Max Intensity]");
		run("Top Hat...", "radius=2 slice");
		setAutoThreshold("Yen dark no-reset");
		run("Analyze Particles...", "size=0.25-Infinity show=Masks");
		run("Invert");
		run("Dilate");
		run("Dilate");
		run("Dilate");
		run("Analyze Particles...", "size=20-Infinity add include");
		roiManager("Select", 0);
		run("Select Bounding Box");
		run("Enlarge...", "enlarge=2");
		roiManager("Add");
		roiManager("Select", 0);
		roiManager("Delete");
		selectWindow(image_stack);
		close("\\Others");
		roiManager("Select", 0);
	roiManager("Save", output+File.separator+image_stack+"_crop.roi");
	run("Duplicate...", "title=["+kc_stack+"] duplicate channels="+ch);
	run("3D Maxima Finder", "minimmum=100 radiusxy=2.50 radiusz=2.50 noise=20");
	xpoints=Table.getColumn("X");
	ypoints=Table.getColumn("Y");
	zpoints=Table.getColumn("Z");

	for (i = 0; i < nResults(); i++) {
    	makePoint(xpoints[i], ypoints[i]);
		Roi.setPosition(zpoints[i]);
		roiManager("add");
	}
	roiManager("Select", 0);
	roiManager("delete");
	print(image_stack + " has " +roiManager("count") +" kinetochores");
	selectWindow(kc_stack);
	saveAs("Tiff", output+File.separator+kc_stack+".tif");
	roiManager("deselect");
	roiManager("Save", output+File.separator+kc_stack+"_points.zip");
	roiManager("reset");
	selectWindow("Results");
	run("Close");
	close("*");
	}
}