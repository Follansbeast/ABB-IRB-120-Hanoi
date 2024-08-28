MODULE M_Menu
    PROC menu_MAIN (INOUT c_station station, VAR c_station_io station_io, INOUT c_peg peg_arr{*}, INOUT c_disc disc_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{6} := [
            "System Setup",
            "Game Setup",
            "Game Mode: Manual, Auto",
            "Robot Control Mode: Solo, Controller, Worker",
            "Start Robot Operation",
            "Run Tests"
            ];
        
        IF RobOS() menu_items{6} := "";
        
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
                CASE 1: menu_SYSTEM_SETUP station, station_io, peg_arr, disc_arr;
                CASE 2: menu_GAME_SETUP;
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
    
    PROC menu_GAME_SETUP ()
        VAR menu_selection selection;
        VAR string menu_items{3} := [
            "Game Targets: ##",
            "Set Game Targets",
            "Game Mode: Single/Continuous"           
            ];
        
        WHILE TRUE DO
            selection := menu_LIST ("System Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: 
                CASE 2: 
                CASE 3: 
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC menu_SYSTEM_SETUP (INOUT c_station station, VAR c_station_io station_io, INOUT c_peg peg_arr{*}, INOUT c_disc disc_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{10} := [
            "Adjust LoadID Calibration Angle",
            "Define Stylus Tool",
            "Set User Frame Plane and Origin, Keep Peg Wobjs in Place",
            "Set User Frame Plane and Origin, Alter Peg Wobjs",
            "Define Peg Work Objects",
            "Configure End Effector",
            "Define End Effector",
            "Configure Station Settings",
            "Input Disc Thicknesses",
            "Advanced Station Settings"
            ];
        
        WHILE TRUE DO
            selection := menu_LIST ("System Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: num_props_MENU station.calibration_angle, station.calibration_angle_props;
                CASE 2: station_DEFINE_STYLUS station;
                CASE 3: station_DEFINE_BASE_PLANE station;
                    peg_arr_SET_UFRAME peg_arr,station.user_frame, \maintain_global_pos;
                CASE 4: station_DEFINE_BASE_PLANE station;
                    peg_arr_SET_UFRAME peg_arr,station.user_frame;
                CASE 4: menu_DEFINE_PEGS peg_arr;
                CASE 5: menu_EE_SETUP station.ee, station_io.ee_io \calibration_angle := station.calibration_angle;
                CASE 6: 
                CASE 7: 
                CASE 8: menu_DISC_THICKNESS disc_arr, station.disc_props;
                CASE 9: 
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC menu_EE_SETUP (INOUT c_ee ee, VAR c_EE_io ee_io \num calibration_angle)
        VAR menu_selection selection;
        VAR string menu_items{8};
        VAR num calibration_angle_local := 0;
        IF Present(calibration_angle) calibration_angle_local := calibration_angle;
        
        Load \Dynamic, diskhome \File:="lib/M_Tool.mod";
        
        WHILE TRUE DO
            menu_items{1} := "Calibrate Tool Load via LoadID";
            menu_items{2} := "Calibrate Tool Center Point";
            menu_items{3} := "Toggle Actuation Signal Exists, Current: " + ValToStr(ee.has_actuation_signal);
            menu_items{4} := "Toggle Actuation Feedback Exists, Current: " + ValToStr(ee.has_feedback_signal);
            menu_items{5} := "Toggle Object Held Signal Exists, Current: " + ValToStr(ee.has_object_held_signal);
            menu_items{6} := "Toggle Actuation Motion Exists, Current: " + ValToStr(ee.has_actuation_motion);
            menu_items{7} := "Define Actuation Motion";
            menu_items{8} := "Actuator Test Menu";
            
            selection := menu_LIST ("End Effector Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 2: RETURN;
                CASE 1:
                    TEST selection.list_selection
                        CASE 1: %"tool_DEFINE_LOAD"% ee.tool_data, \calibration_angle:= calibration_angle_local;
                        CASE 2: !Probably need an alternative way to calculate TCP than 4 pt
                        CASE 3: 
                            IF ee.has_actuation_signal
                                THEN ee.has_actuation_signal := FALSE;
                                ELSE ee.has_actuation_signal := TRUE;
                            ENDIF
                        CASE 4: 
                            IF ee.has_feedback_signal
                                THEN ee.has_feedback_signal := FALSE;
                                ELSE ee.has_feedback_signal := TRUE;
                            ENDIF
                        CASE 5: 
                            IF ee.has_object_held_signal
                                THEN ee.has_object_held_signal := FALSE;
                                ELSE ee.has_object_held_signal := TRUE;
                            ENDIF
                        CASE 6: 
                            IF ee.has_actuation_motion
                                THEN ee.has_actuation_motion := FALSE;
                                ELSE ee.has_actuation_motion := TRUE;
                            ENDIF
                        CASE 7: ee_MOTION_MENU ee;
                        CASE 8: ee_TEST_MENU ee, ee_io;
                    ENDTEST
            ENDTEST
        ENDWHILE
        
        EraseModule "M_Tool";
        
    ENDPROC
    
    PROC ee_TEST_MENU (INOUT c_ee ee, VAR c_ee_io ee_io)
        VAR menu_selection selection;
        VAR string menu_items{4};
        
        WHILE TRUE DO
            menu_items{1} := "Actuation Signal Status: " + ValToStr(IO_GET_DO(ee_io.actuate_signal));
            menu_items{2} := "Actuation Feedback Status: " + ValToStr(IO_GET_DI(ee_io.feedback_signal));
            menu_items{3} := "Object Held Status: " + ValToStr(IO_GET_DI(ee_io.object_held_signal));
            if ee.actuated menu_items{4} := "Release Actuator";
            if NOT ee.actuated menu_items{4} := "SET Actuator";
            
            
            selection := menu_LIST ("End Effector Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 2: RETURN;
                CASE 1:
                    TEST selection.list_selection
                        CASE 1: 
                        CASE 2: 
                        CASE 3: 
                        CASE 4: 
                        CASE 5: 
                        CASE 6: 
                        CASE 7: 
                    ENDTEST
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC ee_MOTION_MENU (VAR c_ee ee)
    ENDPROC
    
    PROC menu_DISC_THICKNESS (INOUT c_disc disc_arr{*}, c_disc_props disc_props)
        VAR menu_selection selection;
        VAR string menu_items{G_ToH_number_of_discs};
        VAR num peg_number;
        VAR string peg_number_string;
        
        FOR i FROM 1 TO Dim(menu_items, 1) DO
            menu_items{i} := "Disc " + NumToStr(i,0) + ": " + NumToStr(disc_arr{i}.thickness,0) + " mm";
        ENDFOR
        
        WHILE TRUE DO
            selection := menu_LIST ("Disc Thickness Setup", menu_items, ["SELECT", "BACK"], \previous_selection := selection);
            IF selection.button_selection = 2 RETURN;
            num_props_MENU disc_arr{selection.list_selection}.thickness, disc_props.thickness_props;
        ENDWHILE
    ENDPROC
    
    PROC menu_DEFINE_PEGS (INOUT c_peg peg_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{G_ToH_number_of_pegs};
        
        FOR i FROM 1 TO Dim(menu_items, 1) DO
            menu_items{i} := "Set Peg Work Object, Peg " + NumToStr(i,0);
        ENDFOR
        
        WHILE TRUE DO
            selection := menu_LIST ("Peg Setup", menu_items, ["SELECT", "BACK"], \previous_selection := selection);
            IF selection.button_selection = 2 RETURN;
            peg_SET_WOBJ_DATA peg_arr{selection.list_selection};
        ENDWHILE
    ENDPROC
    
    PROC storage_LOAD_MENU()
        ! Get filename of all modules in directory
        ! Build list of filenames
        ! Allow for new file to be saved with UIAlphaEntry
        ! 
        VAR menu_selection selection;
        CONST num pager_size:=2;
        VAR string menu_items{pager_size};
        VAR dir directory;
        VAR string filename;
        VAR num index := -2;
        VAR num pager_offset := 0;
        VAR num pager_index := 0;
        VAR bool reset_pager := FALSE;
        
        WHILE TRUE DO
            OpenDir directory, "HOME:/Configurations";
            WHILE ReadDir(directory, filename) AND index - pager_offset < pager_size DO
                index := index + 1;
                IF index > pager_offset menu_items{index - pager_offset} := filename;
            ENDWHILE
            CloseDir directory;
            
            IF index - pager_offset < 1 THEN
                pager_offset := 0;
                index := -2;
                FOR i FROM 1 TO Dim(menu_items,1) DO
                    menu_items{i} := "";
                ENDFOR
            ELSE
                selection := menu_LIST ("Configuration Management", menu_items, ["SAVE NEW", "OPEN", "DELETE", "BACK", "NEXT PAGE"], \previous_selection:=selection);
                TEST selection.button_selection
                    CASE 4: RETURN;
                    CASE 5: ! NEXT PAGE
                        pager_offset := pager_offset + pager_size;
                        index := -2;
                        FOR i FROM 1 TO Dim(menu_items,1) DO
                            menu_items{i} := "";
                        ENDFOR
                    CASE 1: ! SAVE NEW
                        ! Need a file that contains empty pers versions of the data that I am looking for.
                        ! Load empty pers file that is standard
                        ! Save operation to save all settings
                        ! Multiple minor save functions for updating certain records only
                        ! Save the data passed to this function into those variables.
                        ! Save that module with associated file name
                        ! Close that module
                ENDTEST
                TEST selection.list_selection
                    CASE 1: 
                    CASE 2: 
                    CASE 3: 
                    
                ENDTEST
            ENDIF
        ENDWHILE
        
        ! Load \Dynamic, diskhome\File:="";
        ! File contains save and load procedures which are executed by this menu
        ! Save takes existing VARs and puts them in PERS variables in the save document
        ! Alternatively, the module could be loaded and save/load procs could be in a separate module that then get pushed to just data holders.
        
    ENDPROC
    
    PROC station_CONTROL_MODE_MENU (VAR c_station station)
        VAR menu_selection selection;
        VAR string menu_items{3} := [
            "Solo",
            "Controller",
            "Worker"
            ];
        VAR string worker_mode;
        
        selection := menu_LIST ("Select Control Mode", menu_items, ["SELECT", "BACK"], \previous_selection:=[station.control_mode + 1,0]);
        if selection.button_selection = 2 RETURN;
        TEST selection.list_selection
            CASE 1: station.control_mode := 0;
            CASE 2: station.control_mode := 1;
            CASE 3: station.control_mode := 2;
        ENDTEST
    ENDPROC
    
ENDMODULE