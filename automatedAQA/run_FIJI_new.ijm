// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

home_path=getDirectory("home");

script_path = "/Users/papo/Sync/Projects/Annual_QA_pipeline/automatedAQA/MagNET_QA_scripts/" 
print(script_path) ;
BC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_TRA_2_1001";
BC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_TRA_1_901";
BC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_COR_2_1401";
BC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_COR_1_1301";
BC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_SAG_2_1201";
BC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/BC_SNR_SAG_1_1101";
HNC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_TRA_2_301";
HNC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_TRA_1_201";
HNC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_COR_2_701";
HNC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_COR_1_601";
HNC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_SAG_1_401";
HNC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/HNC_SNR_SAG_2_501";
Results_dir="/Users/papo/Sync/MRdata/QA/PBT_SNR_tests/PBT_SNR_TEST_FOLLOWUP3_21Oct2021/DATA/FIJI_Results";


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


wait(200); //to allow FIJI to load fully

// RUN SNR:

runMacro(script_path + "SNR.ijm") ;

print("");
print("");
print("");
print("Done! The SNR test results are saved in:");
print(Results_dir);

print("Closing FIJI now... ");
run("Quit");
