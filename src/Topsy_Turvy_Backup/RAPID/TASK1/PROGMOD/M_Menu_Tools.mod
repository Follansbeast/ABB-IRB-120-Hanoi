MODULE M_Menu_Tools (NOSTEPIN)
    
    RECORD menu_selection
        num list_selection;
        num button_selection;
    ENDRECORD
    
    FUNC menu_selection menu_LIST (string header, string menu_items{*}, string buttons{*}, \menu_selection previous_selection)
        VAR menu_selection selection;
        VAR listitem list_items{30};
        VAR num default_index := 1;
        
        FOR i FROM 1 TO Dim(menu_items, 1) DO
            list_items{i}.text := menu_items{i};
        ENDFOR
        
        IF present (previous_selection) THEN
            IF (NOT previous_selection.list_selection = 0) default_index := previous_selection.list_selection;
        ENDIF
        
        selection.list_selection := UIListView (
            \Result := selection.button_selection
            \Header := header,
            list_items
            \BtnArray:=buttons
            \DefaultIndex := default_index);
        RETURN selection;
    ENDFUNC
    
ENDMODULE