MODULE M_Game_T
    
    PROC test_game_RUN ()
        test_game_SINGLE_DISC;
    ENDPROC
    
    PROC test_game_SINGLE_DISC()
        ! Because we are using the moves as they are created,
        ! Single disc
        ! Discs on 0 or negative pegs
        ! Discs on pegs larger than 3
        ! Mismatched array sizes for start and end
        
        VAR num start_single {1} := [1];
        VAR num target_single {1} := [2];
        VAR num start_two {2} := [1,1];
        VAR num target_two {2} := [2,2];
        VAR num start_three {3};
        VAR num target_three {3};
        VAR num move_disc;
        VAR num move_to_peg;
        VAR num test_number := 0;
        VAR bool peg_not_assigned_triggered := FALSE;
        
        ! SINGLE DISC
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 1;
        target_single {1} := 1;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert move_disc = 0 and move_to_peg = 0, "game_SINGLE_DISC game complete";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 1;
        target_single {1} := 2;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert move_disc = 1 and move_to_peg = 2, "game_SINGLE_DISC test 1";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 2;
        target_single {1} := 3;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert move_disc = 1 and move_to_peg = 3, "game_SINGLE_DISC test 2";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 3;
        target_single {1} := 1;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert move_disc = 1 and move_to_peg = 1, "game_SINGLE_DISC test 3";
        
        ! OOB Conditions
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 0;
        target_single {1} := 2;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert peg_not_assigned_triggered = TRUE, "game_SINGLE_DISC, start 0";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 2;
        target_single {1} := 0;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert peg_not_assigned_triggered = TRUE, "game_SINGLE_DISC, start 0";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := G_ToH_number_of_pegs + 1;
        target_single {1} := 1;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert peg_not_assigned_triggered = TRUE, "game_SINGLE_DISC, start pegs + 1";
        
        peg_not_assigned_triggered := FALSE;
        start_single {1} := 1;
        target_single {1} := G_ToH_number_of_pegs + 1;
        game_GET_NEXT_MOVE start_single, target_single, move_disc, move_to_peg;
        assert peg_not_assigned_triggered = TRUE, "game_SINGLE_DISC, target pegs + 1";
        
        ! TWO DISCS
        peg_not_assigned_triggered := FALSE;
        start_two := [1,1];
        target_two := [2,2];
        game_GET_NEXT_MOVE start_two, target_two, move_disc, move_to_peg;
        assert move_disc = 2 and move_to_peg = 3, "game_TWO_DISC, test move1";
        
        peg_not_assigned_triggered := FALSE;
        start_two := [1,3];
        target_two := [2,2];
        game_GET_NEXT_MOVE start_two, target_two, move_disc, move_to_peg;
        assert move_disc = 1 and move_to_peg = 2, "game_TWO_DISC, test move2";
        
        peg_not_assigned_triggered := FALSE;
        start_two := [2,3];
        target_two := [2,2];
        game_GET_NEXT_MOVE start_two, target_two, move_disc, move_to_peg;
        assert move_disc = 2 and move_to_peg = 2, "game_TWO_DISC, test move3";
        
        start_three := [1,1,1];
        target_three := [2,2,2];
        !game_SOLVE start_three, target_three;
        
        ! THREE DISCS
        peg_not_assigned_triggered := FALSE;
        start_three := [1,1,1];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 3 and move_to_peg = 2, "game_THREE_DISC, test move1";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [1,1,2];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 2 and move_to_peg = 3, "game_THREE_DISC, test move2";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [1,3,2];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 3 and move_to_peg = 3, "game_THREE_DISC, test move3";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [1,3,3];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 1 and move_to_peg = 2, "game_THREE_DISC, test move4";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [2,3,3];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 3 and move_to_peg = 1, "game_THREE_DISC, test move5";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [2,3,1];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 2 and move_to_peg = 2, "game_THREE_DISC, test move6";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [2,2,1];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 3 and move_to_peg = 2, "game_THREE_DISC, test move7";
        
        peg_not_assigned_triggered := FALSE;
        start_three := [2,2,2];
        target_three := [2,2,2];
        game_GET_NEXT_MOVE start_three, target_three, move_disc, move_to_peg;
        assert move_disc = 0 and move_to_peg = 0, "game_THREE_DISC, game complete";
        
        ERROR 
            IF ERRNO = ERR_PEG_NOT_ASSIGNED THEN
                peg_not_assigned_triggered := TRUE;
                TRYNEXT;
            ENDIF
    ENDPROC
    
ENDMODULE