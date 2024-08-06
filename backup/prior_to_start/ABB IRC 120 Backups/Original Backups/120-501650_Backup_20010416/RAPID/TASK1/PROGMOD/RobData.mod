MODULE RobData
    PERS robtarget pPass2:=[[-40.4314,-257.966,143.781],[4.99019E-05,-0.667497,0.744613,6.30517E-05],[-2,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pFcCalib:=[[108.10,-252.03,11.85],[0.000221418,-0.707336,0.706877,0.000273512],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget phome:=[[-123.67,-373.52,162.15],[0.000155501,-0.707328,0.706885,0.000175752],[-2,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pPlace:=[[-40.42,-221.88,117.83],[2.18321E-05,-0.667502,0.744608,4.10089E-05],[-2,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PERS robtarget pPickWait:=[[-120.88,-373.23,161.48],[0.000203675,-0.707307,0.706906,0.000196952],[-2,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pCCD2Cali:=[[226.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pTCPCalib:=[[30.7907,-313.012,77.5181],[0.000151307,-0.259062,-0.96586,-0.000290982],[-1,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pCCD1:=[[30.06,-312.09,93.13],[0.0001492,-0.259078,-0.965856,-0.000290729],[-1,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PERS robtarget pPickInkpad:=[[105.07,-271.31,39.8],[0.000184835,-0.707311,0.706902,0.000223378],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pPass1:=[[200.53,-307.58,242.84],[0.299987,0.731588,0.298484,-0.534504],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pPick:=[[-123.67,-373.52,82.15],[0.000155501,-0.707328,0.706885,0.000175752],[-2,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pAssembly:=[[0,0,119],[0,-1,0,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PERS robtarget pAssem:=[[354.53,109.44,1307.28],[0.522631,-0.494622,0.5135,0.467465],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pInsert:=[[-3.04,0.80,217.25],[0.000437457,-0.712014,0.0134034,-0.702037],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pAssBase:=[[225.06,-308.31,118.65],[0.0102026,-0.99364,-0.111268,-0.0139692],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pCali2Temp:=[[221.471,-305.943,140.42],[3.87751E-06,0.113366,-0.993553,-6.74824E-05],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget pActPos:=[[752.23,113.39,1307.28],[0.522626,-0.494634,0.513503,0.467454],[0,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS tooldata tGripper:=[TRUE,[[0,0,115],[0,0,0,-1]],[1,[0,0,0.001],[1,0,0,0],0,0,0]];
    PERS tooldata tcp1:=[TRUE,[[-134.881,-2.6021,210.993],[0.472574,-0.509839,-0.505206,0.511376]],[0.001,[0,0,0.001],[1,0,0,0],0,0,0]];
    PERS tooldata tcp2:=[TRUE,[[-134.881,-2.6021,210.993],[0.472574,-0.509839,-0.505206,0.511376]],[0.001,[0,0,0.001],[1,0,0,0],0,0,0]];
    PERS tooldata tCurTool:=[TRUE,[[-0.261642,-0.18486,115],[0.999995,-1.10444E-11,7.99385E-12,-0.00325258]],[1,[0,0,0.001],[1,0,0,0],0,0,0]];
    PERS wobjdata AssFrame:=[FALSE,TRUE,"",[[228.15,-306.126,0],[0.498117,0,0,-0.86711]],[[0,0,0],[1,0,0,0]]];
    PERS pose posRel:=[[29.926,-311.799,93.13],[0.000291213,-0.966694,0.255935,0.000148254]];
    !the position of insert action
    PERS robtarget pccd2Calib{9}:=[[[222.43,-311.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[222.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[222.43,-303.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-311.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-303.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[230.43,-311.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[230.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[230.43,-303.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]];
    CONST robtarget p10:=[[418.58,0.00,334.20],[0.69977,-5.36606E-06,0.714368,-1.01452E-05],[-1,-1,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p20:=[[0.60,-2.39,139.88],[0.0451042,-0.778366,0.0549821,-0.62377],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p30:=[[2.03,-1.48,133.89],[0.0349452,-0.822791,0.0369745,-0.566062],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p40:=[[4.97,-1.85,131.80],[0.0393794,-0.888544,0.03218,-0.455964],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p50:=[[7.35,-1.97,128.77],[0.0439547,-0.949177,0.025601,-0.310606],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p60:=[[8.62,-0.66,125.77],[0.0466607,-0.979164,0.0202421,-0.196599],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p70:=[[7.11,-0.69,123.96],[0.047197,-0.984152,0.0189763,-0.169877],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p80:=[[7.11,-0.05,123.96],[0.0406734,-0.991285,-0.0497359,-0.115008],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p90:=[[4.75,0,122.6],[0.0228857,-0.987126,-0.142227,-0.0694926],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p100:=[[4.30,1.38,122.36],[0.0190123,-0.977767,-0.196515,-0.07065],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p110:=[[4.30,1.38,122.36],[0.00254443,0.877133,0.474641,0.0731204],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p120:=[[4.3,1.38,122],[0.00801003,0.838822,0.543448,0.0312508],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p130:=[[0.78,0.99,121.75],[0.0133946,0.729882,0.682811,0.0293496],[-1,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p140:=[[395.07,52.94,69.21],[0.146773,-0.40343,-0.902897,-0.0218841],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p150:=[[0.73,0.19,121.74],[0.00247764,0.730292,0.683065,0.00947357],[-1,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p160:=[[0.62,3.16,122.50],[0.0216987,-0.999509,-0.0111852,0.0196521],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p170:=[[0.15,1.60,122.60],[0.022889,-0.999681,-0.0106178,-0.00147162],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p180:=[[0.33,0.75,122.56],[0.0405975,-0.99906,-0.000325195,-0.0151796],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p190:=[[-5.04,9.32,128.15],[0.502915,0.733369,-0.411451,-0.199886],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p200:=[[-7.89,9.59,127.41],[0.377726,0.806199,-0.437126,-0.127621],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p210:=[[309.31,-185.13,57.93],[3.23688E-05,-0.711176,0.703014,2.50774E-05],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p220:=[[309.31,-185.13,60.13],[3.17998E-05,-0.71117,0.70302,2.71847E-05],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p230:=[[291.17,-178.69,59.38],[0.121864,0.177542,0.974817,-0.0579603],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p240:=[[291.17,-178.69,59.38],[0.0237281,0.143256,0.987655,-0.0587628],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p250:=[[294.50,-178.67,59.37],[0.0180936,0.0502125,0.996728,-0.0607034],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p260:=[[296.33,-183.75,59.37],[0.00909617,-0.0948952,0.99347,-0.0626853],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p270:=[[299.47,-185.58,56.25],[0.0201912,0.533122,-0.843665,0.060031],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p280:=[[309.31,-185.13,57.93],[3.23688E-05,-0.711176,0.703014,2.50774E-05],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p290:=[[309.31,-185.13,60.13],[3.17998E-05,-0.71117,0.70302,2.71847E-05],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget J_Temp:=[[0,0,0,0,0,0],[0,0,0,0,0,0]];
    PERS string sCCD;
    PERS string Revision:="Rev 3.3.2";
    PERS string sFirstStr;
    PERS string sSecondStr;
    PERS num Zangle:=-96.2604;
    PERS num Yangle:=-0.00782723;
    PERS num Xangle:=179.998;
    VAR string CCD1X{9}:=["","","","","","","","",""];
    VAR string CCD1Y{9}:=["","","","","","","","",""];
    VAR string CCD2X{9}:=["","","","","","","","",""];
    VAR string CCD2Y{9}:=["","","","","","","","",""];
    PERS NUM ARRAY{9}:=[3,6,9,8,5,2,1,4,7];
    VAR string sCCD1;
    VAR string sCCD3;
    PERS num nanglex:=0;
    PERS num nangley:=0;
    !CCD 1 data for pick the Buttun
    PERS num X1:=29.926;
    PERS num Y1:=-311.799;
    PERS num nAngle1:=-30.058;
    !CCD2 data for gasket
    PERS num X2:=228.15;
    PERS num Y2:=-306.126;
    PERS num nAngle2:=-30.249;
    !CCD3 data for cable;
    PERS num X3:=-0.502;
    PERS num Y3:=0; 
    PERS num nAngle3:=0;
    PERS num X4:=35.818;
    PERS num Y4:=-312.359;
    PERS num nAngle4:=1.27;
    !the data from computer to modify the robot position
    
    !CCD3 data for cable;
    PERS num noffsX:=-0.465;
    PERS num noffsY:=-0.07;
    PERS num noffsAngle:=0.4;
    PERS num nAssX:=-0.5;
    PERS num nAssY:=-0.2;
    PERS num nAssz:=0.6;
    PERS num XC:=9;
    PERS num YC:=20;
    PERS num nCCD:=0;
    PERS num nccd3offs:=0;
    PERS num nccd3offsx:=0;
    PERS num nTempX:=-5;
    PERS num nTempY:=0;
    PERS num nTempZ:=0;
    PERS num nTAnglez:=0;
    PERS num nTAngley:=0;
    PERS num nTAnglex:=0;
    PERS num nPositionNo:=0;
    PERS num nHtemp:=0;
    !the insert speed of the robot
    PERS speeddata vAssembly:=[200,25,5000,1000];
    PERS num baseX2:=0;
    PERS num baseY2:=0;
    PERS bool bFull:=TRUE;
    PERS bool bWork:=FALSE;
    PERS bool bCalibration:=FALSE;
    PERS bool bInitall:=FALSE;
    PERS bool bEmptyDone:=FALSE;
    PERS bool SockGet:=TRUE;
    VAR intnum iSocketError:=0;
    VAR intnum iCalibration:=0;
    VAR intnum iInitall:=0;
    VAR intnum iEmptydone:=0;
    VAR intnum iProcessFinish:=0;
    !CCD3 data for
    PERS num CCD1_X:=425.2;
    PERS num CCD1_Y:=-118.686;
    PERS num AngZ:=0;
    !Gasket wobj Z value
    
    VAR socketdev temp_socket;
    PERS tooldata tGrip:=[TRUE,[[0,0,108],[1,0,0,0]],[2,[0,1,0],[1,0,0,0],0,0,0]];
    PERS tooldata tTCP:=[TRUE,[[0,0,120],[1,0,0,0]],[2,[0,1,0],[1,0,0,0],0,0,0]];
    PERS num n:=2;
    PERS num b:=3;
    PERS num nStrLength:=10;
    PERS num nfind:=6;
    PERS num nArray{20}:=[6,20,29,37,45,54,20,23,26,29,5,8,11,14,17,20,23,26,0,0];
    var num nArray1{9}:=[13,20,29,37,45,54,59,66,73];
    var num nArray2{3}:=[11,18,0];
    PERS pose nPoseAss:=[[-0.2,0.5,0.6],[1,0,0,0]];
    PERS pos nPOSCCD1{9}:=[[26.0574,-312.476,77.5211],[26.0624,-310.281,77.5186],[26.0617,-308.082,77.5179],[30.0623,-312.476,77.5217],[30.0624,-310.281,77.518],[30.0622,-308.081,77.5179],[34.0622,-312.476,77.5213],[34.0623,-310.283,77.5186],[34.0619,-308.08,77.5182]];
    PERS pos nPOSCCD2{9}:=[[224.429,-305.141,145.771],[226.43,-305.143,145.772],[228.43,-305.142,145.771],[228.432,-307.145,145.774],[226.43,-307.141,145.772],[224.43,-307.141,145.772],[224.43,-309.142,145.773],[226.432,-309.144,145.773],[228.427,-309.137,145.769]];
    PERS String SocketStr:="";
    PERS String SendStr:="";
    PERS String sFrame:="world";
    CONST robtarget p300:=[[35.94,-312.18,78.08],[0.0367958,-0.00985026,-0.999273,0.00150693],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pCCD1Cali:=[[30.06,-312.09,93.13],[0.000159189,-0.259061,-0.965861,-0.000291941],[-1,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pccd2Calib_T{9}:=[[[224.43,-309.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[224.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[224.43,-305.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-309.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[226.43,-305.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[228.43,-309.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[228.43,-307.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[228.43,-305.14,145.78],[0.000100878,-0.707367,0.706846,0.00017394],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]];
    VAR intnum intDoor:=0;
    PERS wobjdata AssFrame1:=[FALSE,TRUE,"",[[228.15,-306.126,0],[0.965361,0,0,-0.260917]],[[0,0,0],[1,0,0,0]]];
ENDMODULE