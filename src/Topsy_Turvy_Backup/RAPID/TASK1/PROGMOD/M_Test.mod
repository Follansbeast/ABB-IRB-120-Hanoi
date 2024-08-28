MODULE M_Test
    
    LOCAL VAR bool all_tests_passed;
    LOCAL VAR num failed_tests;
    LOCAL VAR num total_tests;
    LOCAL VAR bool tests_running := FALSE;
    
    PROC assert(bool condition, string title, \string details, \switch display_passing)
        VAR string message := "";
        IF present (details) message := details;
        
        total_tests := total_tests + 1;
        
        IF NOT condition THEN
            ! If the assertion fails, log the message and set test status to FALSE
            ErrWrite "ASSERTION FAILED: " + title, message;
            all_tests_passed := FALSE;
            failed_tests := failed_tests + 1;
        ELSE
            IF Present(display_passing) THEN
                ! Optionally, log a success message
                ErrWrite \I, "ASSERTION PASSED: " + title, message;
            ENDIF
        ENDIF
    ENDPROC
    
    PROC test_RUN_TESTS ()
        all_tests_passed := TRUE;
        failed_tests := 0;
        total_tests := 0;
        
        tests_running := TRUE;
        
        !test_MOTION;
        test_disc_RUN;
        test_num_RUN;
        
        Load \Dynamic, diskhome \File:="lib/M_Tool.mod";
        Load \Dynamic, diskhome \File:="testing/M_Tool_T.mod";
        %"test_tool_RUN"%;
        EraseModule "M_Tool";
        EraseModule "M_Tool_T";
        
        Load \Dynamic, diskhome \File:="testing/CM_Plane_T.mod";
        %"test_plane_RUN"%;
        EraseModule "CM_Plane_T";
        
        Load \Dynamic, diskhome \File:="testing/M_Game_T.mod";
        %"test_game_RUN"%;
        EraseModule "M_Game_T";
        
        tests_running := FALSE;
        
        IF all_tests_passed THEN 
            ErrWrite \I, NumToStr(total_tests,0) + " TESTS PASSED", "";
            RETURN;
        ENDIF
        
        ErrWrite \I, NumToStr (failed_tests,0) + "/" + NumToStr(total_tests,0) + " FAILED", "";
    ENDPROC
    
    FUNC bool test_RUNNING ()
        RETURN tests_running;
    ENDFUNC
ENDMODULE