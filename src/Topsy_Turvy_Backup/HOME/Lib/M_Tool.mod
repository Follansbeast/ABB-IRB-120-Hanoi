MODULE M_Tool
    
    ! Generic purpose tool definition module
    
    PROC tool_DEFINE_TOOL_MENU (INOUT tooldata tool, string tool_name, \num calibration_angle)
        VAR menu_selection selection;
        VAR string menu_items{2} := [
        "Calibrate Tool Load via LoadID",
        "Calibrate Tool Center Point"
        ];
        VAR num calibration_angle_local := 0;
        IF Present(calibration_angle) calibration_angle_local := calibration_angle;
        
        WHILE TRUE DO
            selection := menu_LIST ("Tool Menu: " + tool_name, menu_items, ["SELECT", "RETURN"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: tool_DEFINE_LOAD tool, \calibration_angle:=calibration_angle_local;
                CASE 2: tool_DEFINE_TCP_4PT_MENU tool;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC tool_DEFINE_TCP_4PT_MENU (INOUT tooldata tool)
        VAR menu_selection selection;
        CONST num number_of_targets := 4;
        VAR jointtarget targets{number_of_targets};
        VAR string menu_items{number_of_targets};

        WHILE TRUE DO
            FOR i FROM 1 TO number_of_targets DO
                menu_items{i} :="Target " + NumToStr(i,0) + ": " + ValToStr(targets{i}.robax);
            ENDFOR
            
            selection := menu_LIST ("Define Tool TCP (4 Point Cal)", menu_items, ["DEFINE", "CALCULATE TCP", "RETURN"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 1: user_GET_JOG_POINT tool, "TCP Point " + NumToStr(selection.list_selection,0), \jtarget := targets{selection.list_selection};
                CASE 2: IF tool_CALCULATE_TCP(tool, targets) RETURN;
                CASE 3: RETURN;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    FUNC bool tool_CALCULATE_TCP (INOUT tooldata tool, jointtarget targets{*})
        VAR bool accept_definition := FALSE;
        VAR btnres queryAnswer;
        VAR num max_error;
        VAR num mean_error;
        VAR tooldata current_tool_restore;
        current_tool_restore := tool;
        
        MToolTCPCalib targets{1}, targets{2}, targets{3}, targets{4}, tool, max_error, mean_error;
        
        queryAnswer:=UIMessageBox(
            \Header:="Accept TCP Definition?"
            \Msgarray:=[
                "TCP: " + ValToStr(tool.tframe),
                "",
                "Max Error: " + ValToStr(max_error),
                "Mean Error: " + ValToStr(mean_error)
                ]
            \Buttons:=btnOKCancel);
            
        IF queryAnswer = 1 RETURN TRUE;
        IF queryAnswer = 2 RETURN FALSE;
    ENDFUNC
    
    PROC tool_DEFINE_LOAD (INOUT tooldata tool, \num calibration_angle)
        VAR btnres query_answer;
        VAR num load_accuracy;
        VAR robtarget current_target;
        VAR jointtarget cal_target:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
        VAR tooldata current_tool_restore;
        current_tool_restore := tool;

        IF present(calibration_angle) cal_target.robax.rax_1 := calibration_angle;
        
        current_target := CRobT (\Tool:=tool0, \WObj:=wobj0);
        
        query_answer:=UIMessageBox(
            \Header:="Proceed with Robot Motion?"
            \Msgarray:=[
                "Robot will move to load calibration position.",
                "Manual mode is recommended until familiar with calibration location.",
                "",
                "Adjust calibration angle to rotate joint 1 of calibration position."
                ]
            \Buttons:=btnOKCancel);
            
        IF query_answer = 2 RETURN;
        
        MoveJ CalcRobT(cal_target, tool0, \WObj:=wobj0), v200, fine, tool0 \WObj:=wobj0;
        
        query_answer:=UIMessageBox(
            \Header:="Proceed With Calibration?"
            \Msgarray:=[
                "Robot in calibration position.",
                "",
                "Press OK to proceed with load identification motions",
                "Press CANCEL to cancel calibration in current position.",
                "Press GO BACK to return to previous location and cancel calibration."
                ]
            \BtnArray:=["OK", "CANCEL", "GO BACK"]);
            
        IF query_answer = 2 RETURN;
        IF query_answer = 3 THEN
            MoveJ current_target, v200, fine, tool0 \WObj:=wobj0;
            RETURN;
        ENDIF
        
        Load \Dynamic, "RELEASE:/system/mockit.sys";
        Load \Dynamic, "RELEASE:/system/mockit1.sys";
        %"LoadId"%TOOL_LOAD_ID, MASS_WITH_AX3, tool, \WObj:=wobj0, \Accuracy:=load_accuracy;
        UnLoad "RELEASE:/system/mockit.sys";
        UnLoad "RELEASE:/system/mockit1.sys";
        
        query_answer:=UIMessageBox(
            \Header:="Load Calibration Complete"
            \Msgarray:=[
                "Calibration Complete.",
                "Load Accuracy: " + NumToStr(load_accuracy, 1) + "%",
                "",
                "Press ACCEPT to accept load.",
                "Pess ACCEPT AND GO BACK to rerturn to initial position",
                "Press CANCEL to reject load identification."
                ]
            \BtnArray:=["ACCEPT", "ACCEPT AND GO BACK", "CANCEL"]);
            
        TEST query_answer
            CASE 1:
            CASE 2: 
                MoveJ current_target, v200, fine, tool0 \WObj:=wobj0;
            CASE 3:
                tool := current_tool_restore;
        ENDTEST
        
        RETURN;
    ENDPROC
    
ENDMODULE