MODULE CM_Cylinder
    
    RECORD c_cylinder
        pos axis;
        pos origin;
        num radius;
    ENDRECORD
    
    LOCAL PERS tooldata PERS_tool_local := [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];
    LOCAL PERS wobjdata PERS_wobj_local := [FALSE, TRUE, "",[[0, 0, 0],[1, 0, 0, 0]],[[0,0,0],[1,0,0,0]]];

    ! How can we define the cylinder?
    ! Dial indicator and rotation of axis 6
    ! Points on the surface and least squares
    !   Lest Squares Methods
    !       Gradient Descent
    !       Levenberg-Marquardt algorithm
    
    PROC cylinder_DIAL_INDICATOR_DEF (INOUT c_cylinder cylinder, \tooldata tool, \wobjdata wobj)
        VAR robtarget vector_target1;
        VAR robtarget vector_target2;
        VAR robtarget vector_target_x;
        VAR robtarget vector_target_y;
        VAR robtarget vector_aligned_target;
        VAR robtarget axis_point;
        VAR orient vector_orientation;
        VAR btnres messagebox_answer;
        VAR jointtarget jtarget;
        VAR pose origin_frame; 
        VAR pos vector;
        VAR pos vector_translation_x;
        VAR pos vector_translation_y;
        VAR num displacement := 10;

        PERS_tool_local := tool0;
        IF Present(tool) PERS_tool_local := tool;
        PERS_wobj_local := wobj0;
        IF Present(wobj) PERS_wobj_local := wobj;
        
        ! Collect jog points from user defined with dial indicator around cylinder.
        user_GET_JOG_POINT "first position where indicator on J6 is aligned with cylinder", \tool:= PERS_tool_local, \wobj:= PERS_wobj_local, \target := vector_target1;
        user_GET_JOG_POINT "second indicator aligned position. Do not reorient robot during jog", \tool:= PERS_tool_local, \wobj:= PERS_wobj_local, \target := vector_target2;
        
        ! Generate axis vector from two positions
        vector := vector_target1.trans - vector_target2.trans;
        
        ! Create x vector from origin (target2) using displacement in the wobj x coordinate direction.
        vector_translation_x := vector;
        vector_translation_x.x := vector_translation_x.x + displacement;
        vector_translation_x := point_to_plane_projection(vector_translation_x,[vector_target2.trans,vector]);
        
        ! Use cross product with axis to create y vector
        vector_translation_y := CrossProd(vector, vector_translation_x);
        
        ! Calculate orientation aligned with wobj x axis using defframe
        vector_target_x := vector_target2;
        vector_target_x.trans := vector_translation_x;
        vector_target_y := vector_target2;
        vector_target_y.trans := vector_translation_y;
        origin_frame := DefFrame(vector_target2,vector_target_x,vector_target_y);
        
        ! Get jtarget. Set j6 to 0. Then convert back to euclidean targets.
        vector_aligned_target.trans := origin_frame.trans;
        vector_aligned_target.rot := origin_frame.rot;
        jtarget := CalcJointT(vector_aligned_target, PERS_tool_local, \WObj:= PERS_wobj_local);
        jtarget.robax.rax_6 := 0;
        vector_aligned_target := CalcRobT(jtarget, PERS_tool_local, \WObj:= PERS_wobj_local);
        
        ! Prepare for motion, then reorient
        messagebox_answer:=UIMessageBox(
            \Header:="Proceed with Robot Motion?"
            \Msgarray:=[
                "Robot will move to match orientation of the vector",
                "Press cancel to back out of routine and prevent motion"
                ]
            \Buttons:=btnOKCancel);
        IF messagebox_answer = 2 RETURN;
        
        MoveJ vector_aligned_target, v200, fine, PERS_tool_local \WObj:=PERS_wobj_local;
        user_GET_JOG_POINT "third indicator aligned position. Do not reorient robot during jog", \tool:= PERS_tool_local, \wobj:= PERS_wobj_local, \target := axis_point;
        
        cylinder.origin := axis_point.trans;
        cylinder.axis := vector;
    ENDPROC
    
ENDMODULE