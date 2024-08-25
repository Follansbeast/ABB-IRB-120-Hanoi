MODULE M_Test
    
    LOCAL VAR bool all_tests_passed;
    LOCAL VAR num failed_tests;
    LOCAL VAR num total_tests;
    LOCAL VAR num test_display;
    LOCAL CONST num ALL := 0;
    LOCAL CONST num FAILING_ONLY := 1;
    LOCAL CONST num NONE := 2;
    
    PROC assert(bool condition, string title, \string details)
        VAR string message := "";
        IF present (details) message := details;
        
        total_tests := total_tests + 1;
        
        IF NOT condition THEN
            ! If the assertion fails, log the message and set test status to FALSE
            IF test_display = ALL OR test_display = FAILING_ONLY THEN
                ErrWrite "ASSERTION FAILED: " + title, message;
                all_tests_passed := FALSE;
                failed_tests := failed_tests + 1;
            ENDIF
        ELSE
            IF test_display = ALL THEN
                ! Optionally, log a success message
                ErrWrite \I, "ASSERTION PASSED: " + title, message;
            ENDIF
        ENDIF
    ENDPROC
    
    PROC test_RUN_TESTS ()
        all_tests_passed := TRUE;
        failed_tests := 0;
        total_tests := 0;
        
        test_display := 1;
        !test_MOTION;
        test_disc_RUN;
        test_num_RUN;
        test_tool_RUN;
        test_plane_RUN;
        test_game_SIMPLE;
        
        IF all_tests_passed THEN 
            ErrWrite \I, NumToStr(total_tests,0) + " TESTS PASSED", "";
            RETURN;
        ENDIF
        
        ErrWrite \I, NumToStr (failed_tests,0) + "/" + NumToStr(total_tests,0) + " FAILED", "";
    ENDPROC
    
ENDMODULE