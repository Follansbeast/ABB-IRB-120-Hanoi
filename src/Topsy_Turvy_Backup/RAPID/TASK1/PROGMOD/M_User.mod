MODULE M_User
    
    LOCAL PERS tooldata PERS_tool_local := [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];
    LOCAL PERS wobjdata PERS_wobj_local := [FALSE, TRUE, "",[[0, 0, 0],[1, 0, 0, 0]],[[0,0,0],[1,0,0,0]]];
    
    PROC user_GET_JOG_POINT(string point_description, \tooldata tool, \wobjdata wobj, \INOUT robtarget target, \INOUT jointtarget jtarget)
        ! Procedure prompts user to navigate robot tool to position, breaks, and then records the position in a robtarget

        VAR btnres queryAnswer;
        VAR robtarget target_local;
        VAR jointtarget jtarget_local;
        
        PERS_tool_local := tool0;
        IF Present(tool) PERS_tool_local := tool;
        PERS_wobj_local := wobj0;
        IF Present(wobj) PERS_wobj_local := wobj;
        
        queryAnswer:=UIMessageBox(
            \Header:="User Jog Point"
            \Message:="Jog robot to " + point_description + ". Resume program when complete."
            \Buttons:=btnOKCancel);

        ! If user presses OK : stop program so user can navigate robot TCP to required position.
        ! After resuming program, function will return position of TCP as rob target.
        ! When user presses play, position of TCP will be returned by function as robtarget
        ! If users presses CANCEL : program ends and returns to main menu.
        
        IF queryAnswer=resCancel RETURN;

        Stop \NoRegain;
        
        target_local := CRobT(\Tool:=PERS_tool_local \WObj:=PERS_wobj_local);
        jtarget_local := CJointT();
        
        IF Present(target) target := target_local;
        IF Present(jtarget) jtarget := jtarget_local;
        
        UIMsgBox
            \Header:="User Jog Point",
            "Target acquired.",
            \MsgLine2 := "Robot Target: " + ValToStr(target_local.trans),
            \MsgLine3 := "Joint Target: " + ValToStr(jtarget_local.robax);
    ENDPROC
    
ENDMODULE