MODULE M_Motion_T
    LOCAL PERS wobjdata current_work_object:=[FALSE, TRUE, "",[[450, 0, 0],[1, 0, 0, 0]],[[0,0,0],[1,0,0,0]]];
    LOCAL PERS tooldata current_tool:=[TRUE,[[0,0,0],[1.91069E-15,-1,-4.37114E-08,-4.37114E-08]],[0.01,[0,0,0.01],[1,0,0,0],0,0,0]];

    PROC test_MOTION ()
        VAR c_EE end_effector;
        VAR c_peg peg;
        VAR num height := 10;
        VAR robtarget target_1;
        VAR robtarget target_2;
        VAR robtarget target_3;
        
        end_effector.tool_data:=[TRUE,[[0,0,0],[1,0,0,0]],[0.01,[0,0,0.01],[1,0,0,0],0,0,0]];
        end_effector.move_speed := v1000;
        end_effector.tool_data.tframe.rot := OrientZYX(180,180,0);
        
        
        peg.wobj := [FALSE, TRUE, "",[[450, 0, 0],[1, 0, 0, 0]],[[0,0,0],[1,0,0,0]]];
        current_work_object := peg.wobj;
        current_tool := end_effector.tool_data;
        
        motion_SHAFT_REFERENCED_MOVE end_effector, peg, 0;
        WaitRob \InPos;
        WaitRob \ZeroSpeed;
        WaitTime 1;
        target_1 := CRobT (\Tool:=current_tool, \WObj:=current_work_object);
        
        motion_SHAFT_REFERENCED_MOVE end_effector, peg, 100;
        WaitRob \InPos;
        WaitRob \ZeroSpeed;
        WaitTime 1;
        target_2 := CRobT (\Tool:=current_tool, \WObj:=current_work_object);
        
        motion_SHAFT_REFERENCED_MOVE end_effector, peg, 200;
        WaitRob \InPos;
        WaitRob \ZeroSpeed;
        WaitTime 1;
        target_3 := CRobT (\Tool:=current_tool, \WObj:=current_work_object);
        
        motion_SHAFT_REFERENCED_MOVE end_effector, peg, 0;
        WaitRob \InPos;
        WaitRob \ZeroSpeed;
        target_1 := CRobT (\Tool:=current_tool, \WObj:=current_work_object);
    ENDPROC
    
ENDMODULE