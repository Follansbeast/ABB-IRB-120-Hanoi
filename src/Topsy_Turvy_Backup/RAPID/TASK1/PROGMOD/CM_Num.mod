MODULE CM_Num
    
    RECORD  c_num_stats
        num mean;
        num median;
        num std_dev; 
        num max;
        num index_max;
        num min;
        num index_min;
        num range;
        num RMS;
    ENDRECORD
    
    FUNC c_num_stats num_CALC_STATS (num values{*}, \num data_points)
        VAR c_num_stats stats;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        stats.mean := numarray_MEAN(values, \data_points := data_points_local);
        stats.median := numarray_MEDIAN(values, \data_points := data_points_local);
        stats.std_dev := numarray_STD_DEV(values, \data_points := data_points_local, \mean := stats.mean);
        stats.max := numarray_MAX(values, \data_points := data_points_local);
        stats.index_max := numarray_GET_INDEX (values, stats.max);
        stats.min := numarray_MIN(values, \data_points := data_points_local);
        stats.index_min := numarray_GET_INDEX  (values, stats.min);
        stats.range := abs(stats.max - stats.min);
        stats.RMS := numarray_RMS(values, \data_points := data_points_local);
        RETURN stats;
    ENDFUNC
    
    FUNC bool num_IS_EQUAL(num num1, num num2, \num tolerance)
        VAR num epsilon := 0.00005;
        IF Present(tolerance) epsilon := tolerance;
        RETURN abs(num1 - num2) < epsilon;
    ENDFUNC
    
    FUNC num num_SIGN (num nNumber)
        IF nNumber >= 0 RETURN 1;
        IF nNumber < 0 RETURN -1;
    ENDFUNC

    FUNC num numarray_MEAN (num values {*}, \num data_points)
        VAR num sum := 0;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        FOR i FROM 1 TO data_points_local DO
            sum := values{i} + sum;
        ENDFOR

        RETURN sum / data_points_local;
    ENDFUNC
    
    FUNC num numarray_MEDIAN (num values {*}, \num data_points)
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        numarray_QUICK_SORT values \high:=data_points_local;
        
        IF data_points_local MOD 2 = 1 RETURN values{(data_points_local-1)/2+1};
        RETURN (values{(data_points_local)/2} + values{(data_points_local)/2+1})/2;
    ENDFUNC
    
    FUNC num numarray_STD_DEV (num values {*}, \num data_points, \num mean)
        VAR num std_dev := 0;
        VAR num sum_delta_squared := 0;
        VAR num mean_local;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        IF     Present(mean) mean_local := mean;
        IF NOT Present(mean) mean_local := numarray_MEAN(values, \data_points := data_points);
        
        FOR i FROM 1 TO data_points_local DO
            sum_delta_squared := sum_delta_squared + Pow(values{i} - mean_local,2);
        ENDFOR
        
        RETURN sqrt(sum_delta_squared/(data_points_local-1));
    ENDFUNC
    
    FUNC num numarray_MIN (num values {*}, \num data_points)
        VAR num min_value;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        min_value := values{1};
        FOR i FROM 1 TO data_points_local DO
            min_value := Min(min_value, values{i});
        ENDFOR
        RETURN min_value;
    ENDFUNC
    
    FUNC num numarray_MAX (num values {*}, \num data_points)
        VAR num max_value;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        max_value := values{1};
        FOR i FROM 1 TO data_points_local DO
            max_value := Max(max_value, values{i});
        ENDFOR
        RETURN max_value;
    ENDFUNC
    
    FUNC num numarray_RANGE (num values {*}, \num data_points)
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        RETURN abs(numarray_MAX(values, \data_points := data_points_local) - numarray_MIN(values, \data_points := data_points_local));
    ENDFUNC
    
    FUNC num numarray_RMS (num values {*}, \num data_points)
        VAR num sum_RMS;
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(values, 1);
        
        FOR i FROM 1 TO data_points_local DO
            sum_RMS := sum_RMS + Pow(values{i},2);
        ENDFOR
        RETURN sqrt(sum_RMS / data_points_local);
    ENDFUNC
    
    FUNC num numarray_GET_INDEX(num values {*}, num value_to_index)
        FOR i FROM 1 TO Dim(values, 1) DO
            if num_IS_EQUAL(values{i}, value_to_index) RETURN i;
        ENDFOR
        RETURN 0;
    ENDFUNC
    
    PROC numarray_QUICK_SORT (INOUT num values{*}, \num low, \num high)
        VAR num pivot_index;
        VAR num low_local := 1;
        VAR num high_local;
        high_local := Dim(values,1);
        IF Present(low) low_local := low;
        IF Present(high) high_local := high;
        
        IF low_local < high_local THEN
            pivot_index := numarray_CREATE_PIVOT(values, low_local, high_local);
            numarray_QUICK_SORT values, \low := low_local, \high := pivot_index - 1;
            numarray_QUICK_SORT values, \low := pivot_index + 1, \high := high_local;
        ENDIF
    ENDPROC
    
    FUNC num numarray_CREATE_PIVOT(INOUT num values{*}, num low, num high)
        VAR num pivot_value;
        VAR num swap_scratch;
        VAR num pivot_index;
        
        pivot_value := values{high};
        pivot_index := low;
        FOR i FROM low TO high DO
            IF values{i} <= pivot_value THEN
                swap_scratch := values{pivot_index};
                values{pivot_index} := values{i};
                values{i} := swap_scratch;
                pivot_index := pivot_index + 1;
            ENDIF
        ENDFOR
        RETURN pivot_index - 1;
    ENDFUNC
    
ENDMODULE