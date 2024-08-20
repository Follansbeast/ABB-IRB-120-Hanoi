MODULE CM_Num_Properties (NOSTEPIN)
    
    RECORD c_num_props
        num max;
        num min;
        num sig_figs;
        string units;
        string header;
        string message;
    ENDRECORD
    
    PROC num_props_MENU (INOUT num value, c_num_props value_props)
        value := UINumEntry(
        \Header:=value_props.header,
        \Message:=value_props.message,
        \Icon:=iconInfo,
        \InitValue:=value,
        \MinValue:=value_props.min,
        \MaxValue:=value_props.max);
    ENDPROC
    
    FUNC string num_props_READ_AS_STRING (num value, c_num_props value_props)
        RETURN NumToStr(value, value_props.sig_figs) + " " + value_props.units;
    ENDFUNC
    
ENDMODULE