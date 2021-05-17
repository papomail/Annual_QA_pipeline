// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

//script_path=getDirectory("current");
script_path = "/Users/papo/Sync/Projects/Annual_QA_pipeline/MagNET_QA_scripts/";
print(script_path)
home_path=getDirectory("home");

BC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_TRA_4";
BC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_TRA_3";
BC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_COR_6";
BC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_COR_5";
BC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_SAG_8";
BC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SNR_SAG_7";
HNC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_TRA_19";
HNC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_TRA_18";
HNC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_COR_21";
HNC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_COR_20";
HNC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_SAG_23";
HNC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_SNR_SAG_22";
GEOMETRY_TRA = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_GEO_TRA_12";
GEOMETRY_COR = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_GEO_COR_14";
GEOMETRY_SAG = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_GEO_SAG_16";
SLICE_POS = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/BC_SP_TRA_10";
GHOSTING_1 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_GHO_TRA_2AVE_26";
GHOSTING_2 = "/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/Sequence_Region_Siemens_Sequences _1/HNC_GHO_TRA_1AVE_25";
Results_dir="/Users/papo/Sync/MRdata/QA/LCD_AERA/LDC_AERA_2021/Annual_Qa_2021/FIJI_Results";


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
