MODULE M_Tool_T
    LOCAL PERS tooldata test_tool := [TRUE,[[0,0,0],[1,0,0,0]],[0.01,[0,0,0.01],[1,0,0,0],0,0,0]];
    
    PROC test_tool_RUN ()
        !test_tool_DEFINE_TCP;
    ENDPROC
    
    PROC test_tool_DEFINE_TCP ()
        tool_DEFINE_TCP_4PT_MENU test_tool;
    ENDPROC
ENDMODULE