MODULE CM_Disc_T
    PROC test_disc_RUN ()
        test_GET_DISC_SUMMARY;
    ENDPROC
    
    PROC test_GET_DISC_SUMMARY ()
        VAR string summary{4};
        VAR c_disc disc_arr {G_number_of_discs};
        disc_arr{1}.peg := 1;
        disc_arr{2}.peg := 2;
        disc_arr{3}.peg := 3;
        disc_arr{4}.peg := 1;
        disc_arr{5}.peg := 2;
        disc_arr{6}.peg := 3;
        disc_arr{7}.peg := 1;
        disc_arr{8}.peg := 2;
        disc_arr{9}.peg := 3;
        
        summary{1} := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=1);
        assert summary{1} = "[1, 4, 7]", "GET_DISC_SUMMARY test 1";
        summary{2} := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=2);
        assert summary{2} = "[2, 5, 8]", "GET_DISC_SUMMARY test 2";
        summary{3} := disc_arr_GET_DISC_SUMMARY (disc_arr, \peg_number:=3);
        assert summary{3} = "[3, 6, 9]", "GET_DISC_SUMMARY test 3";
        summary{4} := disc_arr_GET_DISC_SUMMARY (disc_arr);
        assert summary{4} = "[1, 4, 7], [2, 5, 8], [3, 6, 9], []", "GET_DISC_SUMMARY test 4";
    ENDPROC
ENDMODULE