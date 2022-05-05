
close("*");
roiManager("reset");


macro "SLICE_POSITION" {

////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path 
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 
SLICE_POS = call("ij.Prefs.get", "myMacros.SLICE_POS", "defaultValue"); 



// run Slice Position test:
SLICE_POSITION_TEST(SLICE_POS,Results_dir);







//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function SLICE_POSITION_TEST(filename,results_dir) {

	


outdir=results_dir+File.separator+"SLICE_POSITION";
screenshot_dir=outdir+File.separator+"ScreenshotCheck";
//Create uniformity folder
if ( File.isDirectory(outdir)==0 ){
print("Creating folder "+ outdir);
File.makeDirectory(outdir);
}
//Create screenshot_dir folder
if ( File.isDirectory(screenshot_dir)==0 ){
print("Creating folder "+ screenshot_dir);
File.makeDirectory(screenshot_dir);
}
open(filename);
myimage=getTitle();
selectWindow(myimage);







//code execution


CreateImagesForEdgeCentre(myimage,results_dir);

//make binaries for edge and centre 
selectWindow("centreRods");
run("Make Binary", "method=IsoData background=Default calculate");
//run("Make Binary", "method=Intermodes background=Default calculate");
//run("Make Binary", "method=Moments background=Default calculate");
//run("Analyze Particles...", "size=5-30 pixel circularity=0.01-1.00 show=Outlines exclude clear summarize stack");

selectWindow("edgeRods");
//run("Make Binary", "method=Huang background=Default calculate");
run("Make Binary", "method=Li background=Default calculate");
//run("Make Binary", "method=Mean background=Default calculate");
//run("Analyze Particles...", "size=0.2-30 pixel circularity=0.01-1.00 show=Outlines exclude clear summarize stack");
num_slices = nSlices;



// draw rods
edge_xpos=newArray(4);
edge_ypos=newArray(4);

centre_xpos=newArray(2);
centre_ypos=newArray(2);
roiManager("reset");


for (i=1; i<num_slices ; i++) {
	selectWindow("edgeRods");
	wait(20);
	setSlice(i);
	wait(20);
//	run("Analyze Particles...", "size=0.1-30 pixel circularity=0.01-1.00 exclude clear summarize");
	run("Analyze Particles...", "size=5-30 pixel circularity=0.01-1.00 exclude clear summarize");
	wait(20);
	edge_counts = nResults(); 
	print('edge counts');
	print(edge_counts);
	
	if (edge_counts == 4) {
	for (j = 0; j < 4; j++) {
	xp=getResult("X", j);
	yp=getResult("Y", j);
	edge_xpos[j]=xp;
	edge_ypos[j]=yp;
	};

	
	selectWindow("centreRods");
	wait(20);
	setSlice(i);
	wait(20);
	run("Analyze Particles...", "size=5-30 pixel circularity=0.01-1.00 exclude clear summarize");
	wait(20);
	centre_counts = nResults(); 
	print('centre counts');
	print(centre_counts);
	if (centre_counts == 2) {
		for (j = 0; j < 2; j++) {
	xp=getResult("X", j);
	yp=getResult("Y", j);
	centre_xpos[j]=xp;
	centre_ypos[j]=yp;

	};

	
	selectWindow(myimage);
	wait(20);
	setSlice(i);
	wait(20);
	
	makeLine(edge_xpos[0], edge_ypos[0], edge_xpos[1], edge_ypos[1]);
	roiManager("add");
	makeLine(edge_xpos[2], edge_ypos[2], edge_xpos[3], edge_ypos[3]);
	roiManager("add");	
    makeLine(centre_xpos[0], centre_ypos[0], centre_xpos[1], centre_ypos[1]);
	roiManager("add");	
//	roiManager("update");
};
};
};



//measure distance of rods stored in roimanager


roiManager("select", Array.getSequence(roiManager("count")));
roiManager("Show None");
//roiManager("update");
//roiManager("deselect");

roiManager("Measure");


len=newArray(nResults);
for (i = 0; i < nResults; i++) {
len[i]=getResult("Length", i);

};
//print("nResults:");
  //  print(nResults);

    
//print("len:");
  //  Array.print(len);

    run("Clear Results");
 for (i=0; i<len.length/3; i++){
 
      setResult("DiagLength", i, len[3*i+2]);
      setResult("AverageControl", i, 0.5*(len[3*i+1]+len[3*i]));
      setResult("Control1", i, len[3*i]);
      setResult("Control2", i, len[3*i+1]);
  
  }
updateResults;
saveAs("Results", outdir+File.separator+myimage+"_SLICE_POS.csv");
//////////



//Take screenshots

/////Screen-shots

open(filename);
wait(40);
nROIs = roiManager("count");
for (i=0; i<nROIs; i++){
		
		roiManager("Select", i);
//		setSlice(slice[i]);
		setLocation(1,1,800,800);
		
//		setLocation(1,1,300,300);
		wait(40);
		myscreenshot=screenshot_dir+File.separator+myimage+"_rod"+(i+1)+".png";
//		print(myscreenshot);
		exec("screencapture", myscreenshot);
//		setLocation(1,1,300,300);
		};

















//DEFINITIONS



function CreateImagesForEdgeCentre(name,results_dir) {
selectWindow(name);	


run("Duplicate...", "duplicate");
rename("dup1");
run("Make Binary", "method=Minimum background=Dark calculate black");
//run("Make Binary", "method=Minimum calculate black");

run("Duplicate...", "duplicate");
rename("dup2");
run("Invert", "stack");
run("Fill Holes", "stack");
run("Invert", "stack");

	run("Calculator Plus", "i1=dup2 i2=dup1 operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
	close("dup*");
	selectWindow("Result");
run("Duplicate...", "duplicate");
rename("CandE");
	


//find edge rods
run("Z Project...", "projection=Median");
rename("Flat");

  
// particles	
selectWindow("Flat");	
run("Invert");
run("Set Measurements...", "centroid shape stack display redirect=None decimal=2");
run("Analyze Particles...", "size=1-20 circularity=0.01-1.00 exclude clear");

xpos=newArray(4);
ypos=newArray(4);
posind=newArray(4);
for (i = 0; i < 4; i++) {
	xp=getResult("X", i);
	yp=getResult("Y", i);
	xpos[i]=xp;
	ypos[i]=yp;

	posind[i]=yp*10+xp;
}

sort_index=Array.rankPositions(posind);


Array.print(xpos);
Array.print(ypos);
Array.print(posind);
Array.print(sort_index);

xpos2=newArray(4);
ypos2=newArray(4);
for (i = 0; i < 4; i++) {
	xpos2[i]=xpos[sort_index[i]];
	ypos2[i]=ypos[sort_index[i]];
}
xpos=xpos2;
ypos=ypos2;
xpos_ypos_concat=Array.concat(xpos,ypos);


// rectangle
//selectWindow("CandE");
selectWindow(name);
roiManager("reset")

//makePolygon(xpos[0]-10, ypos[0]-10, xpos[1]+10, ypos[1]-10,xpos[3]+10, ypos[3]+10, xpos[2]-10, ypos[2]+10);
makePolygon(xpos[0]-5, ypos[0]-5, xpos[1]+5, ypos[1]-5,xpos[3]+5, ypos[3]+5, xpos[2]-5, ypos[2]+5);
roiManager("add");
roiManager("Select", 0);

run("Make Inverse");
run("Clear", "stack");
roiManager("Show All");

// create copies for centre and edge rods
run("Duplicate...", "duplicate");
rename("centreRods");
run("Duplicate...", "duplicate");
rename("edgeRods");

roiManager("reset")
makeOval(xpos[0]-15, ypos[0]-15, 30, 30);
roiManager("add");
makeOval(xpos[1]-15, ypos[1]-15, 30, 30);
roiManager("add");
makeOval(xpos[2]-15, ypos[2]-15, 30, 30);
roiManager("add");
makeOval(xpos[3]-15, ypos[3]-15, 30, 30);
roiManager("add");
roiManager("Select", newArray(0,1,2,3));
roiManager("Combine");
roiManager("Add");

// Create edgeRods image
selectWindow("edgeRods");
roiManager("Select", 4);
run("Clear Outside", "stack");
run("Select None");
run("Invert", "stack");
// Create centreRods image
selectWindow("centreRods");
roiManager("Select", 4);
run("Clear", "stack");
run("Select None");
run("Invert", "stack");
}









}



