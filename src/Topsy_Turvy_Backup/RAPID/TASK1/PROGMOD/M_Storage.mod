MODULE M_Storage
    
    PROC storage_LOAD_CURRENT_DATA (VAR c_station station, c_peg peg_arr{*}, c_disc disc_arr{*})
        VAR string file_path := "HOME:/Data Current/";
        VAR string low_frequency_file := "M_Storage_Low_Frequency.mod";
        VAR string high_frequency_file := "M_Storage_High_Frequency.mod";
        Load \Dynamic, file_path, \File:= low_frequency_file;
        Load \Dynamic, file_path, \File:= high_frequency_file;
        
        storage_LOAD_ALL station, peg_arr, disc_arr;
        EraseModule "M_Storage_Low_Frequency";
    ENDPROC
    
    PROC storage_SAVE_CURRENT_DATA (VAR c_station station, c_peg peg_arr{*}, c_disc disc_arr{*})
        VAR string file_path := "HOME:/Data Current/";
        VAR string low_frequency_file := "M_Storage_Low_Frequency.mod";
        VAR string high_frequency_file := "M_Storage_High_Frequency.mod";
        Load \Dynamic, file_path, \File:= low_frequency_file;
        Load \Dynamic, file_path, \File:= high_frequency_file;
        
        storage_SAVE_ALL station, peg_arr, disc_arr;
        
        Save "M_Storage_Low_Frequency", \FilePath:= file_path, \File:= low_frequency_file;
        Save "M_Storage_High_Frequency", \FilePath:= file_path, \File:= high_frequency_file;
    ENDPROC
    
    PROC storage_SAVE_CURRENT_HF_DATA (c_disc disc_arr{*})
        VAR string file_path := "HOME:/Data Current/";
        VAR string high_frequency_file := "M_Storage_High_Frequency.mod";
        Load \Dynamic, file_path, \File:= high_frequency_file;
        
        storage_SAVE_HF disc_arr;
        
        Save "M_Storage_High_Frequency", \FilePath:= file_path, \File:= high_frequency_file;
    ENDPROC
    
    PROC storage_SAVE_ALL (c_station station, c_peg peg_arr{*}, c_disc disc_arr{*})
        %"storage_lf_SAVE_STATION"% station;
        %"storage_lf_SAVE_PEG_ARR"% peg_arr;
        %"storage_hf_SAVE_DISC_ARR"% disc_arr;
    ENDPROC
    
    PROC storage_SAVE_HF (c_disc disc_arr{*})
        %"storage_hf_SAVE_DISC_ARR"% disc_arr;
    ENDPROC
    
    PROC storage_LOAD_ALL (INOUT c_station station, INOUT c_peg peg_arr{*}, INOUT c_disc disc_arr{*})
        %"storage_lf_LOAD_STATION"% station;
        %"storage_lf_LOAD_PEG_ARR"% peg_arr;
        %"storage_hf_LOAD_DISC_ARR"% disc_arr;
    ENDPROC
    
!    saving and loading modules

!Can only unload modules based on location where they have been loaded from

!lf data
!Load data initally from current

!Save when menu items are changed
!Erase LF module when menu is exited or program is started

!When saving and loading externally
!Save
!	Save Current (loaded) as new file name
!Load
!	Load Module
!	Load Data

! The questions
! when do I unload one of these PERS modules?
! When do I erase them?

    
    
ENDMODULE