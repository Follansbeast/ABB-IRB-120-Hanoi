MODULE CM_Num_T
    
    LOCAL CONST num array_size := 10;
    LOCAL CONST num test_data_1{array_size} := [65,43,21,35,46,13,26,51,32,32];
    LOCAL CONST num test_data_2{array_size} := [48,51,32,58,46,13,15,68,52,35];
    LOCAL CONST num test_data_3{array_size} := [48,51,32,58,46,13,35, 0, 0, 0];
    
    PROC test_num_RUN ()
        test_numarray_CREATE_PIVOT;
        test_numarray_QUICK_SORT;
        test_num_CALC_STATS;
    ENDPROC
    
    PROC test_numarray_CREATE_PIVOT ()
        VAR num test_data{array_size};
        VAR num expected_data{array_size};
        VAR num pivot_index;
        
        test_data := test_data_1;
        expected_data := [21,13,26,32,32,43,65,51,35,46];
        pivot_index := numarray_CREATE_PIVOT(test_data, 1, 10);
        !ErrWrite ValToStr(test_data), "";
        assert pivot_index = 5, "Numarray Create Pivot test 1";
        assert test_data = expected_data, "Numarray Create Pivot test 2";
        
        test_data := test_data_2;
        expected_data := [32,13,15,35,46,51,48,68,52,58];

        pivot_index := numarray_CREATE_PIVOT(test_data, 1, 10);
        !ErrWrite ValToStr(test_data), "";
        assert pivot_index = 4, "Numarray Create Pivot test 3";
        assert test_data = expected_data, "Numarray Create Pivot test 4";
        
        test_data := test_data_3;
        expected_data := [32,13,35,58,46,51,48,0,0,0];

        pivot_index := numarray_CREATE_PIVOT(test_data, 1, 7);
        !ErrWrite ValToStr(test_data), "";
        assert pivot_index = 3, "Numarray Create Pivot test 5";
        assert test_data = expected_data, "Numarray Create Pivot test 6";
    ENDPROC
    
    PROC test_numarray_QUICK_SORT ()
        VAR num test_data{array_size};
        VAR num expected_data{array_size};
        VAR num pivot_index;
        
        test_data := test_data_1;
        expected_data := [13,21,26,32,32,35,43,46,51,65];
        numarray_QUICK_SORT test_data ;
        !ErrWrite ValToStr(test_data), "";
        assert test_data = expected_data, "Numarray Quick Sort test 1";
        
        test_data := test_data_2;
        expected_data := [13,15,32,35,46,48,51,52,58,68];
        numarray_QUICK_SORT test_data;
        !ErrWrite ValToStr(test_data), "";
        assert test_data = expected_data, "Numarray Quick Sort test 2";
        
        test_data := test_data_3;
        expected_data := [13,32,35,46,48,51,58,0,0,0];
        numarray_QUICK_SORT test_data, \high:=7;
        !ErrWrite ValToStr(test_data), "";
        assert test_data = expected_data, "Numarray Quick Sort test 2";
    ENDPROC
    
    PROC test_num_CALC_STATS ()
        VAR c_num_stats stats;
        VAR c_num_stats stats_exepected;
        
        stats := num_CALC_STATS (test_data_1);
        stats_exepected.mean      := 36.4;
        stats_exepected.median    := 33.5;
        stats_exepected.std_dev   := 15.27670703;
        stats_exepected.max       := 65;
        stats_exepected.index_max := 1;
        stats_exepected.min       := 13;
        stats_exepected.index_min := 6;
        stats_exepected.range     := 52;
        stats_exepected.RMS       := 39.17907605;
        !ErrWrite ValToStr(stats), "";
        assert num_IS_EQUAL(stats.mean     , stats_exepected.mean     ), "Numarray Stats test A1";
        assert num_IS_EQUAL(stats.median   , stats_exepected.median   ), "Numarray Stats test A2";
        assert num_IS_EQUAL(stats.std_dev  , stats_exepected.std_dev  ), "Numarray Stats test A3";
        assert num_IS_EQUAL(stats.max      , stats_exepected.max      ), "Numarray Stats test A4";
        assert num_IS_EQUAL(stats.index_max, stats_exepected.index_max), "Numarray Stats test A5";
        assert num_IS_EQUAL(stats.min      , stats_exepected.min      ), "Numarray Stats test A6";
        assert num_IS_EQUAL(stats.index_min, stats_exepected.index_min), "Numarray Stats test A7";
        assert num_IS_EQUAL(stats.range    , stats_exepected.range    ), "Numarray Stats test A8";
        assert num_IS_EQUAL(stats.RMS      , stats_exepected.RMS      ), "Numarray Stats test A9";
        
        stats := num_CALC_STATS (test_data_2);
        stats_exepected.mean      := 41.8;
        stats_exepected.median    := 47;
        stats_exepected.std_dev   := 17.89972067;
        stats_exepected.max       := 68;
        stats_exepected.index_max := 8;
        stats_exepected.min       := 13;
        stats_exepected.index_min := 6;
        stats_exepected.range     := 55;
        stats_exepected.RMS       := 45.11762405;
        !ErrWrite ValToStr(stats), "";
        assert num_IS_EQUAL(stats.mean     , stats_exepected.mean     ), "Numarray Stats test B1";
        assert num_IS_EQUAL(stats.median   , stats_exepected.median   ), "Numarray Stats test B2";
        assert num_IS_EQUAL(stats.std_dev  , stats_exepected.std_dev  ), "Numarray Stats test B3";
        assert num_IS_EQUAL(stats.max      , stats_exepected.max      ), "Numarray Stats test B4";
        assert num_IS_EQUAL(stats.index_max, stats_exepected.index_max), "Numarray Stats test B5";
        assert num_IS_EQUAL(stats.min      , stats_exepected.min      ), "Numarray Stats test B6";
        assert num_IS_EQUAL(stats.index_min, stats_exepected.index_min), "Numarray Stats test B7";
        assert num_IS_EQUAL(stats.range    , stats_exepected.range    ), "Numarray Stats test B8";
        assert num_IS_EQUAL(stats.RMS      , stats_exepected.RMS      ), "Numarray Stats test B9";
        
        stats := num_CALC_STATS (test_data_3);
        stats_exepected.mean      := 28.3;
        stats_exepected.median    := 33.5;
        stats_exepected.std_dev   := 23.07981321;
        stats_exepected.max       := 58;
        stats_exepected.index_max := 4;
        stats_exepected.min       := 0;
        stats_exepected.index_min := 8;
        stats_exepected.range     := 58;
        stats_exepected.RMS       := 35.78128002;
        !ErrWrite ValToStr(stats), "";
        assert num_IS_EQUAL(stats.mean     , stats_exepected.mean     ), "Numarray Stats test C1";
        assert num_IS_EQUAL(stats.median   , stats_exepected.median   ), "Numarray Stats test C2";
        assert num_IS_EQUAL(stats.std_dev  , stats_exepected.std_dev  ), "Numarray Stats test C3";
        assert num_IS_EQUAL(stats.max      , stats_exepected.max      ), "Numarray Stats test C4";
        assert num_IS_EQUAL(stats.index_max, stats_exepected.index_max), "Numarray Stats test C5";
        assert num_IS_EQUAL(stats.min      , stats_exepected.min      ), "Numarray Stats test C6";
        assert num_IS_EQUAL(stats.index_min, stats_exepected.index_min), "Numarray Stats test C7";
        assert num_IS_EQUAL(stats.range    , stats_exepected.range    ), "Numarray Stats test C8";
        assert num_IS_EQUAL(stats.RMS      , stats_exepected.RMS      ), "Numarray Stats test C9";
        
        stats := num_CALC_STATS (test_data_3, \data_points:=7);
        stats_exepected.mean      := 40.42857143;
        stats_exepected.median    := 46;
        stats_exepected.std_dev   := 15.0649388;
        stats_exepected.max       := 58;
        stats_exepected.index_max := 4;
        stats_exepected.min       := 13;
        stats_exepected.index_min := 6;
        stats_exepected.range     := 45;
        stats_exepected.RMS       := 42.76680956;
        !ErrWrite ValToStr(stats), "";
        assert num_IS_EQUAL(stats.mean     , stats_exepected.mean     ), "Numarray Stats test D1";
        assert num_IS_EQUAL(stats.median   , stats_exepected.median   ), "Numarray Stats test D2";
        assert num_IS_EQUAL(stats.std_dev  , stats_exepected.std_dev  ), "Numarray Stats test D3";
        assert num_IS_EQUAL(stats.max      , stats_exepected.max      ), "Numarray Stats test D4";
        assert num_IS_EQUAL(stats.index_max, stats_exepected.index_max), "Numarray Stats test D5";
        assert num_IS_EQUAL(stats.min      , stats_exepected.min      ), "Numarray Stats test D6";
        assert num_IS_EQUAL(stats.index_min, stats_exepected.index_min), "Numarray Stats test D7";
        assert num_IS_EQUAL(stats.range    , stats_exepected.range    ), "Numarray Stats test D8";
        assert num_IS_EQUAL(stats.RMS      , stats_exepected.RMS      ), "Numarray Stats test D9";
    ENDPROC
    
ENDMODULE