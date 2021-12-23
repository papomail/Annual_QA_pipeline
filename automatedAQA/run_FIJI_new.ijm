// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

home_path=getDirectory("home");

script_path = "/Users/papo/Sync/Projects/Annual_QA_pipeline/automatedAQA/MagNET_QA_scripts/" 
print(script_path) ;
BC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_TRA_13";
BC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_TRA_12";
BC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_COR_14";
BC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_COR_15";
BC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_SAG_16";
BC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SNR_SAG_17";
HNC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_TRA_2";
HNC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_TRA_3";
HNC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_COR_5";
HNC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_COR_6";
HNC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_SAG_8";
HNC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/HNC_SNR_SAG_7";
GEOMETRY_TRA = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_GEO_TRA_21";
GEOMETRY_COR = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_GEO_COR_25";
GEOMETRY_SAG = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_GEO_SAG_27";
SLICE_POS = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/BC_SP_TRA_19";
GHOSTING_1 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/GHO_1";
GHOSTING_2 = "/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/GHO_2";
Results_dir="/Users/papo/Sync/MRdata/QA/ISEH_2021/DATA_ORGANISED/FIJI_Results";


//Create Results_dir folder
if ( File.isDirectory(Results_dir)==0 ){
print("Creating folder "+ Results_dir);
File.makeDirectory(Results_dir);
}


//store results_dir path
call("ij.Prefs.set", "myMacros.savedir", Results_dir);
//store filename paths
//SNR HNC coil
call("ij.Prefs.set", "myMacros.HNC_SNR_TRA_1", HNC_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.HNC_SNR_COR_1", HNC_SNR_COR_1);
call("ij.Prefs.set", "myMacros.HNC_SNR_SAG_1", HNC_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.HNC_SNR_TRA_2", HNC_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.HNC_SNR_COR_2", HNC_SNR_COR_2);
call("ij.Prefs.set", "myMacros.HNC_SNR_SAG_2", HNC_SNR_SAG_2);

//SNR BC coil
call("ij.Prefs.set", "myMacros.BC_SNR_TRA_1", BC_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.BC_SNR_COR_1", BC_SNR_COR_1);
call("ij.Prefs.set", "myMacros.BC_SNR_SAG_1", BC_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.BC_SNR_TRA_2", BC_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.BC_SNR_COR_2", BC_SNR_COR_2);
call("ij.Prefs.set", "myMacros.BC_SNR_SAG_2", BC_SNR_SAG_2);


//Geometry
call("ij.Prefs.set", "myMacros.GEOMETRY_TRA", GEOMETRY_TRA);
call("ij.Prefs.set", "myMacros.GEOMETRY_COR", GEOMETRY_COR);
call("ij.Prefs.set", "myMacros.GEOMETRY_SAG", GEOMETRY_SAG);

//Ghosting
call("ij.Prefs.set", "myMacros.GHOSTING_1", GHOSTING_1);
call("ij.Prefs.set", "myMacros.GHOSTING_2", GHOSTING_2);

//Slice Position
call("ij.Prefs.set", "myMacros.SLICE_POS", SLICE_POS);

//this will retrieve stored valeu of myMacros.savedir to myvalue
//myvalue = call("ij.Prefs.get", "myMacros.savedir", "defaultValue");


wait(200); //to allow FIJI to load fully

// RUN SNR:

runMacro(script_path + "SNR.ijm") ;

// RUN SIGNAL UNIFORMITY:

//runMacro(script_path + "SIGNAL_UNIFORMITY.ijm") ;
runMacro(script_path + "SIGNAL_UNIFORMITY_NOPLOTS.ijm") ;

// RUN GEOMETRIC_LINEARITY:

runMacro(script_path + "GEOMETRIC_LINEARITY.ijm");


// RUN SLICE WIDTH:

runMacro(script_path + "SLICE_WIDTH.ijm");


// RUN GHOSTING:

runMacro(script_path + "GHOSTING2.ijm");


// RUN SLICE_POS:

runMacro(script_path + "SLICE_POSITION.ijm");



// close("*");

print("");
print("");
print("");
print("Done! Test results saved in:");
print(Results_dir);

print("Closing FIJI now... ");
run("Quit");
