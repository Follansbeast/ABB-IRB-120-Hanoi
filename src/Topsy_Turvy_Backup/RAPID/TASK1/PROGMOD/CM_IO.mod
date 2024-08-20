MODULE CM_IO
    ! Module provides functions for using mocked signals for use in virtual environments that work in real environments
    ! IO_signalXX intended to replace signalXX. This is firstly to allow a signal to be neatly bunded with its mock.
    !   Output signals are not mocked, but new variable types are made for them. Creating these variables primarily provides a consistent interface to promote ease of use.
    !   The goal is that all IO routes through CM_IO. This enables testing using the mock variables.
    !   Mock variables are used based on IO_USE_MOCK. Initially, this is targeted at virtual environments, but could be extended.
    
    RECORD IO_signaldi
        signaldi signal;
        signaldo signal_mock;
    ENDRECORD
    
    RECORD IO_signaldo
        signaldo signal;
    ENDRECORD
    
    RECORD IO_signalai
        signalai signal;
        signalao signal_mock;
    ENDRECORD
    
    RECORD IO_signalao
        signalao signal;
    ENDRECORD
    
    RECORD IO_handshake
        IO_signaldi signal_external;
        IO_signaldo signal_rob;
    ENDRECORD
    
    LOCAL FUNC BOOL IO_USE_MOCK ()
        RETURN RobOS();
    ENDFUNC
    
    PROC IO_CONNECT_DI_WITH_MOCK (VAR signaldi from_signal, VAR signaldo from_signal_mock, VAR IO_signaldi to_signal_alias)
        AliasIO from_signal_mock, to_signal_alias.signal_mock;
        AliasIO from_signal, to_signal_alias.signal;
    ENDPROC
    
    PROC IO_CONNECT_DO (VAR signaldo from_signal, VAR IO_signaldo to_signal)
        AliasIO from_signal, to_signal.signal;
    ENDPROC
        
    PROC IO_CONNECT_AI_WITH_MOCK (VAR IO_signalai signal_alias, VAR signalai signal, VAR signalao signal_mock)
        AliasIO signal_mock, signal_alias.signal_mock;
        AliasIO signal, signal_alias.signal;
    ENDPROC
    
    PROC IO_CONNECT_AO (VAR signalao from_signal, VAR IO_signalao to_signal)
        AliasIO from_signal, to_signal.signal;
    ENDPROC
    
    PROC IO_SET_DI (VAR IO_signaldi signal, bool value)
        IF     value SetDO signal.signal_mock, 1;
        IF NOT value SetDO signal.signal_mock, 0;
    ENDPROC

    PROC IO_SET_AI (VAR IO_signalai signal, num value)
        SetAO signal.signal_mock, value;
    ENDPROC

    PROC IO_SET_DO (VAR IO_signaldo signal, bool value)
        IF     value SetDO signal.signal, 1;
        IF NOT value SetDO signal.signal, 0;
    ENDPROC
    
    PROC IO_SET_AO (VAR IO_signalao signal, num value)
        SetAO signal.signal, value;
    ENDPROC
    
    FUNC bool IO_GET_DI (VAR IO_signaldi signal)
        IF IO_USE_MOCK() return DInput(signal.signal) > 0;
        return DOutput(signal.signal_mock) > 0;
    ENDFUNC
    
    FUNC num IO_GET_AI (VAR IO_signalai signal)
        IF IO_USE_MOCK() return AInput(signal.signal);
        return AOutput(signal.signal_mock);
    ENDFUNC
    
    FUNC bool IO_GET_DO (VAR IO_signalDO signal)
        RETURN DOutput(signal.signal) > 0;
    ENDFUNC
    
    FUNC num IO_GET_AO (VAR IO_signalAO signal)
        RETURN AOutput(signal.signal);
    ENDFUNC
    
    PROC IO_WAIT_DI(VAR IO_signaldi signal, bool value)
        VAR dionum bool_num := 0;
        IF value bool_num := 1;
        IF IO_USE_MOCK() THEN
            WaitDO signal.signal_mock, bool_num;
        ELSE
            WaitDI signal.signal, bool_num;
        ENDIF
    ENDPROC
    
    PROC IO_CONNECT_HANDSHAKE_TO_IO (VAR IO_handshake to_handshake, VAR signaldo rob_signal, VAR signaldi external_signal, VAR signaldo external_signal_mock)
         AliasIO rob_signal, to_handshake.signal_rob;
         IO_CONNECT_DI_WITH_MOCK external_signal, external_signal_mock, to_handshake.signal_external;
    ENDPROC
    
    PROC IO_HANDSHAKE_SEND (VAR IO_handshake handshake)
        IO_SET_DO handshake.signal_rob, TRUE;
        IO_WAIT_DI handshake.signal_external, TRUE;
        IO_SET_DO handshake.signal_rob, FALSE;
    ENDPROC
    
    PROC IO_HANDSHAKE_RECEIVE (VAR IO_handshake handshake)
        IO_WAIT_DI handshake.signal_external, TRUE;
        IO_SET_DO handshake.signal_rob, TRUE;
        IO_WAIT_DI handshake.signal_external, FALSE;
        IO_SET_DO handshake.signal_rob, FALSE;
    ENDPROC
    
ENDMODULE