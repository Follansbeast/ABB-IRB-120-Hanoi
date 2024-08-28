MODULE CM_Disc_T
    PROC test_disc_RUN ()
        test_GET_DISC_SUMMARY;
    ENDPROC
    
    PROC test_GET_DISC_SUMMARY ()
        VAR string summary;
        VAR c_disc disc_arr {G_ToH_number_of_discs};
        disc_arr{1}.peg_current := 1;
        disc_arr{2}.peg_current := 2;
        disc_arr{3}.peg_current := 3;
        disc_arr{4}.peg_current := 1;
        disc_arr{5}.peg_current := 2;
        disc_arr{6}.peg_current := 3;
        disc_arr{7}.peg_current := 1;
        disc_arr{8}.peg_current := 2;
        disc_arr{9}.peg_current := 3;
        

        summary := disc_arr_GET_DISC_SUMMARY (disc_arr);
        assert summary = "[1, 4, 7], [2, 5, 8], [3, 6, 9], []", "GET_DISC_SUMMARY full summary";
        
        summary := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=1);
        assert summary = "[1, 4, 7]", "GET_DISC_SUMMARY test peg 1";
        
        summary := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=2);
        assert summary = "[2, 5, 8]", "GET_DISC_SUMMARY test peg 2";
        
        summary := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=3);
        assert summary = "[3, 6, 9]", "GET_DISC_SUMMARY test peg 3";
        
        summary := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=0);
        assert summary = "[]", "GET_DISC_SUMMARY test peg 0";
        
        summary := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=4);
        assert summary = "", "GET_DISC_SUMMARY test peg 4";
    ENDPROC
ENDMODULE