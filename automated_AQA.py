import argparse
import os
import dicom_organiser
import test_identifier
import results_to_excel


# if __name__ == "__main__":
#     parser = argparse.ArgumentParser(description="Identifies the QA tests bases on the foldernames.")
#     parser.add_argument("main_folder", help="Type the path to the folder exported from Horos that contains all the QA data.")
# # im


# main_folder = parser.parse_args().main_folder
main_folder = dicom_organiser.sort_dicoms()
macro_file,results_dir = test_identifier.main(main_folder) #creates the macro file and outputs its location and the location of the results from FIJI 
os.system(f'/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx -macro {str(macro_file)}' );
results_to_excel.main(results_dir)


