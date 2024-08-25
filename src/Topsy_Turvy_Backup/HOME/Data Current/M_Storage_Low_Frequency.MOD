MODULE M_Storage_Low_Frequency
    
    LOCAL PERS c_station station_storage:=[
        [
            [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]],
            0,[0,0,0,"","","",""],
            0,
            FALSE,
            FALSE,
            FALSE,
            FALSE,
            FALSE,
            [0,0,0,0],
            [0,0,0,0],
            [[0,0,0],[1,0,0,0]],
            [[0,0,0],[1,0,0,0]]
        ],
        [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]],
        0,[0,0,0,"mm","Update Peg Clearance (Metric)","Enter Peg Clearance (mm)","Peg Clearance"],
        [[0,100,2,"mm","Update Disc Thickness (Metric)","Enter Disc Thickness (mm)","Disc Thickness"]],
        0,[-180,180,2,"degrees","Update Joint 1 Calibration Angle","Enter Calibration Angle","Calibration Angle"],
        0,
        FALSE,
        [[0,0,0],[1,0,0,0]]
        ];

    LOCAL CONST num peg_arr_storage_size := 10;
    
    LOCAL PERS c_peg peg_arr_storage{peg_arr_storage_size} := [
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]]
        ];

    PROC storage_lf_SAVE_STATION (VAR c_station station)
        station_TO_STORAGE station, station_storage;
    ENDPROC
    
    PROC storage_lf_LOAD_STATION (VAR c_station station)
        station_TO_STORAGE station, station_storage \from_storage;
    ENDPROC
    
    PROC storage_lf_SAVE_PEG_ARR (c_peg peg_arr{*})
        VAR c_peg peg_arr_new{peg_arr_storage_size};
        
        FOR i FROM 1 TO Dim (peg_arr, 1) DO
            peg_arr_new{i} := peg_arr{i};
        ENDFOR
        
        peg_arr_storage := peg_arr_new;
    ENDPROC
    
    PROC storage_lf_LOAD_PEG_ARR (INOUT c_peg peg_arr{*})
        FOR i FROM 1 TO Dim (peg_arr, 1) DO
            peg_arr{i} := peg_arr_storage{i};
        ENDFOR
    ENDPROC
    
ENDMODULE