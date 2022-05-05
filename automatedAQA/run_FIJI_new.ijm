// RUNS MAGNetQA TESTS
close("*");
roiManager("reset");

home_path=getDirectory("home");

script_path = "/Users/papo/Sync/Projects/Annual_QA_pipeline/automatedAQA/MagNET_QA_scripts/" 
print(script_path) ;
BC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18_SP12_SNR_TRA_44";
BC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18_SP12_SNR_TRA_43";
BC_SNR_COR_1 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18B_SP34_SNR_TRA_45";
BC_SNR_COR_2 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18B_SP34_SNR_TRA_46";
BC_SNR_SAG_1 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18LONG_SP56_SNR_TRA_48";
BC_SNR_SAG_2 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT18LONG_SP56_SNR_TRA_47";
HNC_SNR_TRA_1 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT30_SP78_SNR_TRA_49";
HNC_SNR_TRA_2 = "/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/BMAT30_SP78_SNR_TRA_50";
Results_dir="/Users/papo/Sync/MRdata/QA/System14_N_Well/2022/DATA_ORGANISED/FIJI_Results";


//Create Results_dir folder
if ( File.isDirectory(Results_dir)==0 ){
print("Creating folder "+ Results_dir);
File.makeDirectory(Results_dir);
}


//store results_dir path
call("ij.Prefs.set", "myMacros.savedir", Results_dir);
//store filename paths
//SNR HNC coil
//call("ij.Prefs.set", "myMacros.HNC_SNR_TRA_1", HNC_SNR_TRA_1);
//call("ij.Prefs.set", "myMacros.HNC_SNR_COR_1", HNC_SNR_COR_1);
//call("ij.Prefs.set", "myMacros.HNC_SNR_SAG_1", HNC_SNR_SAG_1);

//call("ij.Prefs.set", "myMacros.HNC_SNR_TRA_2", HNC_SNR_TRA_2);
//call("ij.Prefs.set", "myMacros.HNC_SNR_COR_2", HNC_SNR_COR_2);
//call("ij.Prefs.set", "myMacros.HNC_SNR_SAG_2", HNC_SNR_SAG_2);

//SNR BC coil
call("ij.Prefs.set", "myMacros.BC_SNR_TRA_1", BC_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.BC_SNR_COR_1", BC_SNR_COR_1);
//call("ij.Prefs.set", "myMacros.BC_SNR_SAG_1", BC_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.BC_SNR_TRA_2", BC_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.BC_SNR_COR_2", BC_SNR_COR_2);
//call("ij.Prefs.set", "myMacros.BC_SNR_SAG_2", BC_SNR_SAG_2);


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
