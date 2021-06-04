from logging import exception
from pathlib import Path
from pprint import pprint
import shutil
import easygui_qt


outfile = Path.cwd()/'run_FIJI_new.ijm'
if outfile.is_file():
    outfile.rename(f'{str(outfile)}_OLD')

filter_dic = {
    #Body Coil SNR
    'BC_SNR_TRA':['bc','snr','tra'],
    'BC_SNR_COR':['bc','snr','cor'],
    'BC_SNR_SAG':['bc','snr','sag'],
    #Head&Neck Coil SNR
    'HNC_SNR_TRA':['hnc','snr','tra'],
    'HNC_SNR_COR':['hnc','snr','cor'],
    'HNC_SNR_SAG':['hnc','snr','sag'],

     #Body GEO
    'GEOMETRY_TRA':['bc','geo','tra'],
    'GEOMETRY_COR':['bc','geo','cor'],
    'GEOMETRY_SAG':['bc','geo','sag'],

    #Slice Position
    'SLICE_POS':['bc', 'sp'],

    #Ghosting
    'GHOSTING':['gho_'], 
}


def check_results_exist(main_folder):
    results_dir = Path(main_folder)/"FIJI_Results"
    if results_dir.is_dir():
        ans = easygui.ynbox(msg=f'The "{results_dir.name}" folder already exists. Do you want to continue and overwrite it?',default_choice='No', cancel_choice='No')
        if ans:
            print(f'Okay. Clearing {results_dir.name}')
            shutil.rmtree(results_dir)
        else:
            easygui.msgbox(msg = 'Okay. Clearing {results_dir.name}')
            print('Okay. Aborting mission. Bye!')
            quit()
    return results_dir       

               

def filter_files(filter,files):
    new_files = [file for file in files if filter in str(file.name).lower()]  
    return new_files    

def find_folder(filters,main_folder):
    folders = [fol for fol in Path(main_folder).rglob('*') if fol.is_dir()]
    for filter in filters:
        folders = filter_files(filter,folders)   
    return folders



def main(main_folder, filter_dic=filter_dic):
    results_dir = check_results_exist(main_folder)
    new_paths_text = []
    folders_dic = {}
    for key in filter_dic:
        test_folders = find_folder(filter_dic[key],main_folder) 
        folders_dic.update({key:test_folders})
        # print(f'\nFolder(s) found for {key}:')
        # print(f'len{key}={len(folders_dic[key])}')
        # print(folders_dic[key])
        if len(folders_dic[key]) == 2:
            line = f'{key}_1 = \"{str(folders_dic[key][0])}\";\n' 
            new_paths_text.append(line)
            line = f'{key}_2 = \"{str(folders_dic[key][1])}\";\n'
            new_paths_text.append(line)
        else:

            try:
                line = f'{key} = \"{str(folders_dic[key][0])}\";\n'
            except:
                raise Exception(f'{folders_dic=}, {key=}')    
            new_paths_text.append(line)

    # pprint(str(folders_dic['BODY_SNR_TRA'][0]))

    ## add the results_dir to the macro file
    results_dir_line = f'Results_dir=\"{str(results_dir)}\";\n'
    new_paths_text.append(results_dir_line)

    
    with open(Path(__file__).resolve().parent/'ijm_template_header','r') as f:
        header = f.read()

    with open(Path(__file__).resolve().parent/'ijm_template_footer','r') as f:
        footer = f.read()

    complete_text = str([header, new_paths_text,footer])
    with open(outfile.name,'a') as f:
        f.write(header) 
        f.writelines(new_paths_text) 
        f.write(footer)  

    print(f'\nNew macro file created: "{outfile.name}"') 
    return outfile, str(results_dir)    


if __name__ == "__main__":
    main()
