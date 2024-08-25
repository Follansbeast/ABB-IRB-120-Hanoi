MODULE CM_Num_Properties (NOSTEPIN)
    
    RECORD c_num_props
        num min;
        num max;
        num dec_precision;
        string units;
        string header;
        string message;
        string name;
    ENDRECORD
    
    PROC num_props_MENU (INOUT num value, c_num_props num_props)
        value := UINumEntry(
            \Header:=num_props.header,
            \Message:=num_props.message,
            \InitValue:=value,
            \MinValue:=num_props.min,
            \MaxValue:=num_props.max);
    ENDPROC
    
    PROC num_props_MENU_EDIT (VAR c_num_props num_props)
        VAR menu_selection selection;
        VAR string menu_items{6} := [
            "Value Title",
            "Adjustment screen header",
            "Adjustment screen message",
            "Min Value",
            "Max Value",
            "Decimal Precision"
            ];
        
        WHILE TRUE DO
            selection := menu_LIST (num_props.name + " Menu Config", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: 
                    num_props.name := UIAlphaEntry(
                        \Header := "Change Header: " + num_props.name,
                        \MsgArray := [
                            "Please enter a new name",
                            "Current: " + num_props.name
                            ],
                        \InitString := num_props.name
                    );
                CASE 2: 
                    num_props.name := UIAlphaEntry(
                        \Header := "Change Header: " + num_props.name,
                        \MsgArray := [
                            "Please enter a new header",
                            "Current: " + num_props.header
                            ],
                        \InitString := num_props.header
                    );
                CASE 3: 
                    num_props.name := UIAlphaEntry(
                        \Header := "Change Message: " + num_props.name,
                        \MsgArray := [
                            "Please enter a new header",
                            "Current: " + num_props.message
                            ],
                        \InitString := num_props.message
                    );
                CASE 4: 
                    num_props.min := UINumEntry(
                        \Header:="Change Mininum Value: " + num_props.name,
                        \MsgArray := [
                            "Please enter a new minimum value",
                            "Current: " + NumToStr(num_props.min, num_props.dec_precision)
                            ],
                        \InitValue:=num_props.min);
                CASE 5:
                    num_props.max := UINumEntry(
                        \Header:="Change Maximum Value: " + num_props.name,
                        \MsgArray := [
                            "Please enter a new maximum value",
                            "Current: " + NumToStr(num_props.max, num_props.dec_precision)
                            ]
                        \InitValue:=num_props.max);
                CASE 6:   
                    num_props.dec_precision := UINumTune(
                        \Header:="Change Decimal Precision: " + num_props.name,
                        \MsgArray := [
                            "Please enter a number of decimal places",
                            "Current: " + NumToStr(num_props.dec_precision, 0)
                            ],
                        num_props.dec_precision,
                        1
                        \MinValue:= 0,
                        \MaxValue:=8
                        );
            ENDTEST
        ENDWHILE

    ENDPROC
    
    FUNC string num_props_READ_AS_STRING (num value, c_num_props num_props)
        RETURN NumToStr(value, num_props.dec_precision) + " " + num_props.units;
    ENDFUNC
    
ENDMODULE