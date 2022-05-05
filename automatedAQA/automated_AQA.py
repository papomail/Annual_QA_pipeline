import os

try:
    import dicom_organiser, test_identifier, results_to_excel
except:    
    from automated_AQA import dicom_organiser, test_identifier, results_to_excel


# if __name__ == "__main__":
#     parser = argparse.ArgumentParser(description="Identifies the QA tests bases on the foldernames.")
#     parser.add_argument("main_folder", help="Type the path to the folder exported from Horos that contains all the QA data.")
# # im


# USED TO DIRTILY DO THE SP SNR TESTS
## change ijm_template_footer to  ijm_template_footer_SNR_ONLY in test_identifier.py
filter_dic_ALT = {
    #Body Coil SNR
    # 'BC_SNR_TRA':['sp123','snr'],
    # 'BC_SNR_COR':['sp456','snr'],
    # 'BC_SNR_SAG':['sp56','snr'],
    #Head&Neck Coil SNR
    'HNC_SNR_TRA':['sp12','snr'],
    'HNC_SNR_COR':['sp34','snr'],
    'HNC_SNR_SAG':['sp56','snr'],
    'BC_SNR_TRA':['sp78','snr'],
    'BC_SNR_COR':['sp78','snr'],
    'BC_SNR_SAG':['sp78','snr'],
} # add all 6 tests (even if you reapeat them) so that the scrip works correctly



# main_folder = parser.parse_args().main_folder
def main():
    main_folder = dicom_organiser.sort_dicoms()
    macro_file,results_dir = test_identifier.main(main_folder) #creates the macro file and outputs its location and the location of the results from FIJI 
    # macro_file,results_dir = test_identifier.main(main_folder,filter_dic_ALT) #USE ONLY TO DIRTILY DO THE SP SNR TESTS
    os.system(f'/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx -macro {str(macro_file)}' );
    results_to_excel.main(results_dir)

if __name__ == "__main__":
    main()

