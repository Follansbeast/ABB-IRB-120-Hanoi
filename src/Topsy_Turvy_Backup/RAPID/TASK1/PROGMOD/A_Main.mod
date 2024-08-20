MODULE A_Main

    CONST num G_number_of_pegs := 3;
    CONST num G_number_of_discs := 9;

    PROC main()
        VAR c_station station;
        VAR c_disc disc_arr{G_number_of_discs};
        VAR c_peg peg_arr{G_number_of_pegs};
        initialize station, disc_arr, peg_arr;
        main_MENU station, disc_arr, peg_arr;
    ENDPROC
    
    PROC main_MENU (VAR c_station station, INOUT c_disc disc_arr{*}, INOUT c_peg peg_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{6} := [
            "System Setup",
            "Game Setup",
            "Game Mode: Manual, Auto",
            "Robot Control Mode: Solo, Controller, Worker",
            "Start Robot Operation",
            "Run Tests"
            ];
        
        WHILE TRUE DO
            IF station.manual_mode menu_items{3} := "Game Mode: Manual";
            IF NOT station.manual_mode menu_items{3} := "Game Mode: Auto";
            TEST station.control_mode
                CASE 0: menu_items{4} := "Robot Control Mode: Solo";
                CASE 1: menu_items{4} := "Robot Control Mode: Controller";
                CASE 2: menu_items{4} := "Robot Control Mode: Worker";
            ENDTEST
            
            selection := menu_LIST ("Main Menu", menu_items, ["SELECT", "EXIT"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: main_SETUP_MENU station, disc_arr, peg_arr;
                CASE 2: 
                CASE 3: 
                    IF station.manual_mode
                        THEN station.manual_mode := FALSE;
                        ELSE station.manual_mode := TRUE;
                    ENDIF
                CASE 4: station_CONTROL_MODE_MENU station;
                CASE 5:
                CASE 6: test_RUN_TESTS;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC main_SETUP_MENU (VAR c_station station, INOUT c_disc disc_arr{*}, INOUT c_peg peg_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{3} := [
            "Station",
            "Pegs",
            "Disc Thicknesses"
            ];
        
        WHILE TRUE DO
            selection := menu_LIST ("System Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: station_SETUP_MENU station;
                CASE 2: peg_arr_MENU peg_arr;
                CASE 3: disc_arr_MENU disc_arr;
                
            ENDTEST
        ENDWHILE
    ENDPROC
    
ENDMODULE