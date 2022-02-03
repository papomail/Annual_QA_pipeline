// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

home_path=getDirectory("home");

script_path = "/Users/papo/Sync/Projects/Annual_QA_pipeline/automatedAQA/MagNET_QA_scripts/" 
print(script_path) ;
BC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_TRA_17";
BC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_TRA_16";
BC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_COR_19";
BC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_COR_18";
BC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_SAG_20";
BC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SNR_SAG_21";
HNC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_TRA_6";
HNC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_TRA_7";
HNC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_COR_8";
HNC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_COR_9";
HNC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_SAG_11";
HNC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_SNR_SAG_10";
GEOMETRY_TRA = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_GEO_TRA_24";
GEOMETRY_COR = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_GEO_COR_33";
GEOMETRY_SAG = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_GEO_SAG_30";
SLICE_POS = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/BC_SP_TRA_35";
GHOSTING_1 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_GHO_TRA_AV1_13";
GHOSTING_2 = "/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/HNC_GHO_TRA_AV2_14";
Results_dir="/Users/papo/Sync/MRdata/QA/81Harleyst_Qa2022/DATA_ORGANISED/FIJI_Results";


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

// runMacro(script_path + "SLICE_POSITION.ijm");
runMacro(script_path + "SLICE_POSITION_version1.ijm");



// close("*");

print("");
print("");
print("");
print("Done! Test results saved in:");
print(Results_dir);

print("Closing FIJI now... ");
run("Quit");
