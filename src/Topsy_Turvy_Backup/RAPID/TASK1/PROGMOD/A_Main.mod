MODULE A_Main
    
    ! Declare data
    
    ! Global constants. These are used to define arrays throughout the program.
    ! Will need to update PERS variables below in the event that these are changed.
    CONST num G_number_of_pegs := 3;
    CONST num G_number_of_discs := 9;
    
    ! Persistent state storage, direct access is strictly local.
    
    LOCAL PERS c_station PERS_station := [
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

    
    LOCAL PERS c_peg PERS_peg_arr{G_number_of_pegs} := [
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]],
        [[FALSE, FALSE, "",[[0, 0, 0],[0, 0, 0, 0]],[[0,0,0],[0,0,0,0]]]]
        ];
    
    LOCAL PERS c_disc PERS_disc_arr{G_number_of_discs} := [
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0]
        ];
    
    PROC main()
        VAR c_station_io station_io;
        initialize station_io;
        menu_MAIN PERS_station, station_io, PERS_peg_arr, PERS_disc_arr;
    ENDPROC
    
ENDMODULE