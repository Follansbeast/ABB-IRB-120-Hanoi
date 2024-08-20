MODULE M_User
    
    PROC user_GET_JOG_POINT(PERS tooldata TOOL, string point_description, \INOUT robtarget target, \INOUT jointtarget jtarget)
        ! Procedure prompts user to navigate robot tool to position, breaks, and then records the position in a robtarget

        VAR btnres queryAnswer;
        VAR robtarget target_local;
        VAR jointtarget jtarget_local;
        
        queryAnswer:=UIMessageBox(
            \Header:="User Jog Point"
            \Message:="Jog robot to " + point_description + " then resume program."
            \Buttons:=btnOKCancel);

        ! If user presses OK : stop program so user can navigate robot TCP to required position.
        ! After resuming program, function will return position of TCP as rob target.
        ! When user presses play, position of TCP will be returned by function as robtarget
        ! If users presses CANCEL : program ends and returns to main menu.
        
        IF queryAnswer=resCancel RETURN;

        Stop \NoRegain;
        target_local := CRobT(\Tool:=TOOL \WObj:=wobj0);
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