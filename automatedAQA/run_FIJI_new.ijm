// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

current=getDirectory("current");
script_path = current+"/MagNET_QA_scripts/";
print(script_path)
home_path=getDirectory("home");

BC_SNR_TRA_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_TRA_1_12";
BC_SNR_TRA_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_TRA_2_13";
BC_SNR_COR_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_COR_1_17";
BC_SNR_COR_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_COR_2_18";
BC_SNR_SAG_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_SAG_2_16";
BC_SNR_SAG_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SNR_SAG_1_15";
HNC_SNR_TRA_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_TRA_1_2";
HNC_SNR_TRA_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_TRA_2_3";
HNC_SNR_COR_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_COR_2_7";
HNC_SNR_COR_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_COR_1_6";
HNC_SNR_SAG_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_SAG_1_4";
HNC_SNR_SAG_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_HNC_SNR_SAG_2_5";
GEOMETRY_TRA = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_GEO_L_TRA_59";
GEOMETRY_COR = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_GEO_L_COR_57";
GEOMETRY_SAG = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_GEO_L_SAG_54";
SLICE_POS = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/SE_BC_SP_TRA_61";
GHOSTING_1 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/MULTIECHOSE_HNC_GHO_TRA_NSA2_50";
GHOSTING_2 = "/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/MULTIECHOSE_HNC_GHO_TRA_NSA1_49";
Results_dir="/Users/papo/Documents/QA and Acceptance Tests/PETMR_QA_20181029_Pat/hierarchixca/DATA/DATA/FIJI_Results";


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