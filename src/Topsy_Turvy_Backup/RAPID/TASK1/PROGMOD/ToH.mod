MODULE ToH
    
    RECORD TOH_binary
        num places;
        num binary;
    ENDRECORD
    
    VAR num nstart;
    VAR num nend;
    VAR num nFooBar;
    
    
    PROC R_pick_n_place ()
    ENDPROC
    
    FUNC num R_Recursive_Tower_Solution (num ncounter, num nfromrod, num ntorod, num nauxrod)
        IF ncounter = 0 RETURN 0;
        nFooBar := R_Recursive_Tower_Solution(ncounter-1, nfromrod, nauxrod, ntorod);
        nstart := nfromrod;
        nend := ntorod;
        R_pick_n_place;
        nfoobar := R_Recursive_Tower_Solution(ncounter-1, nauxrod,ntorod,nfromrod);
        RETURN 0;
    ENDFUNC
    
    FUNC num encode_to_binary ()
        
    ENDFUNC
    
    PROC solve ()
        ! create states S and T
        
        ! comparing S and T, find the larget disc (lowest number) that needs to move.
        ! create a new T where all smaller discs are on aux tower. Tarrget disc stays in location
    
        
        ! Recurse function using S and new T to determine largest disc (lowest number) that needs to move and aux tower configuration
        
        ! When largest disc needed to move is smallest disk, move disc
        
        
    ENDPROC
    
    
ENDMODULE