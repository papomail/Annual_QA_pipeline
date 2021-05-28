import easygui_qt
from pathlib import Path
import pydicom
import shutil

# easygui.ynbox('Shall I continue?', 'Title', ('Yes', 'No'))

def sort_dicoms():
    my_msg ='Please select the folder containing the QA data'
    # main_folder = Path(easygui.diropenbox(msg=my_msg, title=my_msg, default=Path.home()/'Sync/MRdata/QA' ))
    main_folder = Path(easygui_qt.get_directory_name(title=my_msg))
    in_folders = [fol for fol in main_folder.rglob('*') if fol.is_dir()]
    dicom_folder = []
    for fol in in_folders:
        if fol.name.lower() == 'dicom':
            dicom_folder.append(fol)

    if len(dicom_folder) == 1:
        dicom_folder = dicom_folder[0]
    elif len(dicom_folder) > 1:
        easygui_qt.handle_exception(f'{len(dicom_folder)} DICOM folders found. Please choose one dataset at a time.')

    elif len(dicom_folder) == 0:
       
        # if easygui.ccbox(f'No DICOM folders found.\nShall I continue to check for dcm files inside {main_folder.name}?'):
        if easygui_qt.get_continue_or_cancel(f'No DICOM folders found.\nShall I continue to check for dcm files inside {main_folder.name}?'):
            dicom_folder = main_folder
        else:
            quit()  

    print(f'\nDICOM folder = {dicom_folder}')

    for file in dicom_folder.rglob('*'):
        if file.is_file():
            try:
                ds = pydicom.dcmread(str(file))
            except:
                continue
            protocol_name = ds[0x18,0x1030].value

            ''' Change protocol name to match the nomenclature in FIJI scripts'''
            protocol_name = protocol_name.upper().replace('_BODY_','_BC_')
            protocol_name = protocol_name.upper().replace('_HEAD_','_HNC_')
            protocol_name = protocol_name.upper().replace('_SLICE_POSITION_','_SP_')
            protocol_name = protocol_name.upper().replace('_GHOSTING_','_GHO_')
            protocol_name = protocol_name.upper().replace('_GEOMETRIC_','_GEO_')
            protocol_name = protocol_name.upper().replace('_LINEARITY_','_L_')

            series_number = ds.SeriesNumber
            organised_folder =main_folder/'DATA'
            protocol_folder = organised_folder/f'{protocol_name}_{series_number}'

            protocol_folder.mkdir( parents=True, exist_ok=True)
            shutil.copy(file, f'{protocol_folder/file.name}.dcm') 

    print(f'\nDICOM files from {main_folder.name} are organised inside the {main_folder.name}/DATA folder.') # For newer Python.
    return organised_folder


    


