MODULE M_Storage_High_Frequency
    
    LOCAL CONST num disc_arr_storage_size := 100;
    LOCAL PERS c_disc disc_arr_storage{disc_arr_storage_size} :=
        [
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], 
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]
        ];
    
    PROC storage_hf_SAVE_DISC_ARR (c_disc disc_arr{*})
        VAR c_disc disc_arr_new{disc_arr_storage_size};
        
        FOR i FROM 1 TO Dim (disc_arr, 1) DO
            disc_arr_new{i} := disc_arr{i};
        ENDFOR
        
        disc_arr_storage := disc_arr_new;
    ENDPROC
    
    PROC storage_hf_LOAD_DISC_ARR (INOUT c_disc disc_arr{*})
        FOR i FROM 1 TO Dim (disc_arr, 1) DO
            disc_arr{i} := disc_arr_storage{i};
        ENDFOR
    ENDPROC
    
ENDMODULE