MODULE M_Game_T
    
    VAR clock timer;
    VAR num move;
    
    PROC test_game_RUN ()
        test_game_SIMPLE;
    ENDPROC
    
    PROC test_game_SIMPLE ()
        VAR num start {14} := [1,1,1,1,1,1,1,1,1,1,1,1,1,1];
        VAR num target{14} := [2,2,2,2,2,2,2,2,2,2,2,2,2,2];
        !VAR num start {4} := [1,1,1,1];
        !VAR num target{4} := [2,2,2,2];
        VAR num time;
        !VAR clock timer;
        
        ErrWrite \I, "start", "";
        ClkReset timer;
        ClkStart timer;
        move := 0;
        game_SOLVE start, target, start, dim(start,1);
        ClkStop timer;
        ErrWrite \I, "end, time: " + NumToStr(ClkRead(timer, \HighRes),3), "";
    ENDPROC
    
ENDMODULE