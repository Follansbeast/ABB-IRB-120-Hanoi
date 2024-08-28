MODULE M_General
    
    FUNC num Min (num A, num B)
        if A < B RETURN A;
        RETURN B;
    ENDFUNC
    
    FUNC num Max (num A, num B)
        if A > B RETURN A;
        RETURN B;
    ENDFUNC

    FUNC pos CrossProd (pos Vector1, pos vector2)
        VAR pos cross_vector;
        
        cross_vector.x := Vector1.y * Vector2.z - Vector1.z * Vector2.y;
        cross_vector.y := Vector1.z * Vector2.x - Vector1.x * Vector2.z;
        cross_vector.z := Vector1.x * Vector2.y - Vector1.y * Vector2.x;
        
        RETURN cross_vector;
    ENDFUNC
    
ENDMODULE