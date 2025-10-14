    function mpc = case14modif

    % O sistema foi modificado: Compensadores sÌncronos nas barras 6 e 8 passam a ser
    % geradores sÌncronos, gerando 20 e 50 MW, respectivamente.

    %   MATPOWER
    %% MATPOWER Case Format : Version 2
    mpc.version = '2';


    %%-----  Power Flow Data  -----%%
    %% system MVA base
    mpc.baseMVA = 100;


    %% bus data
    % OBS: 1) Bs      ==> N√£o precisar√° dividir por 2 dentro do c√≥digo
    %      2) ¡rea    ==> n˙mero da ·rea do sistema
    %      3) ctrl    ==> Define se o gerador (PV) pertence (1) ou n„o (0) do controle de potÍncia ativa (controle de interc‚mbio)
    %      4) Tipo   ==> 3 - SLack, 2 - PV, 1, PQ

    mpc.bus = [
    %  bus_i  type	    Pd      Qd     Gs Bs/2 area	 Vm    Va baseKV       ctrl     Vmax    Vmin    Pg      Qg       Qmim     Qmax
        1       3      0       0        0	0	1	 1.06	0       0       0   	1.06	0.94    232.4   -16.9   -99999    99999;
        2       2   21.7    12.7        0	0	1	 1.045	0	    0       0   	1.06	0.94    40      42.4    -99999    99999;
        3       2   94.2      19      	0	0	1	 1.01	0       0       0   	1.06	0.94    0       23.4    -99999    99999;
        4       1   47.8    -3.9        0	0	1	 1.0	0   	0       0   	1.06	0.94    0       0       -99999    99999;
        5       1    7.6     1.6        0	0	1	 1.0	0   	0       0   	1.06	0.94    0       0       -99999    99999;
        6       2   11.2     7.5     	0	0	2	 1.07	0   	0       1   	1.06	0.94    20      12.2    -69999    99999;     % Adicionei 20 Pg
        7       1      0       0        0	0	1	 1.0	0   	0       0   	1.06	0.94    0       0       -99999    99999;
        8       2      0       0        0	0	1	 1.09	0   	0       1   	1.06	0.94    50      17.4    -99999    99999;     % Adicionei 50 Pg
        9       1   29.5    16.6        0   19	1	 1.0	0   	0   	0   	1.06	0.94    0       0       -99999    99999;
        10      1      9     5.8     	0	0	2	 1.0	0   	0   	0   	1.06	0.94    0       0       -99999    99999;
        11      1    3.5     1.8     	0	0	2	 1.0	0   	0   	0   	1.06	0.94    0       0       -99999    99999;
        12      1    6.1     1.6     	0	0	2	 1.0	0   	0   	0   	1.06	0.94    0       0       -99999    99999;
        13      1   13.5     5.8     	0	0	2	 1.0	0   	0   	0   	1.06	0.94    0       0       -99999    99999;
        14      1   14.9       5        0	0	2	 1.0	0   	0   	0       1.06	0.94    0       0       -99999    99999;
    ];

     mpc.bus(:,3)  = 3 * mpc.bus(:,3);
     mpc.bus(:,4)  = 3 * mpc.bus(:,4);
     mpc.bus(:,14) = 3 * mpc.bus(:,14);
     mpc.bus(:,15) = 3 * mpc.bus(:,15);

    %% generator data
    mpc.gen = [
    %       bus   Pg	 Qg    Qmax	Qmin	    Vg    mBase  status.   Pmax	  Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	
            1.   232.4	-16.9	0       0       1.06	100     1     332.4	    0       0	0	0       0       0       0       0           0       0       0       0;
            2	 40      42.4	3      -3       1.045	100 	1       140     0       0	0	0       0       0       0       0       	0   	0    	0   	0;
            3	 0       23.4	40      0       1.01	100 	1   	100     0       0	0	0       0       0       0   	0       	0   	0       0   	0;
            6	 20      12.2	20     -6       1.07	100 	1   	100     0       0	0	0       0       0       0   	0       	0   	0       0   	0;
            8	 50      17.4	50     -6       1.09	100 	1   	100     0       0	0	0       0       0       0   	0       	0   	0       0   	0;
    ];

    mpc.gen(:,2)  = 3 * mpc.gen(:,2);
    mpc.gen(:,3)  = 3 * mpc.gen(:,3);
    mpc.gen(:,9)  = 3 * mpc.gen(:,9);
    mpc.gen(:,10) = 3 * mpc.gen(:,10);
    
    
%     % Adicionando limites m·ximos aos geradores 8:
     mpc.gen(5,9) = 195;
    
    %% branch data
    % OBS: 1) SHL (b) ==> deve-se /2 dentro do c√≥digo e j√° est√° em [pu]
    %      2) r, x    ==> [pu]
    %      3) TAP     ==> onde n√£o tem transformador, o TAP deve ser 1
    mpc.branch = [
    %   fbus tbus  r      x       b	   rateA	rateB	rateC   TAP	  angle	status	angmin	angmax
        1	2	0.01938	0.05917	0.0528	0   	0       0   	1       0       1	-360	360;
        1	5	0.05403	0.22304	0.0492	0   	0   	0   	1       0   	1	-360	360;
        2	3	0.04699	0.19797	0.0438	0   	0       0   	1       0   	1	-360	360;
        2	4	0.05811	0.17632	0.034	0   	0   	0   	1       0   	1	-360	360;
        2	5	0.05695	0.17388	0.0346	0   	0   	0   	1       0   	1	-360	360;
        3	4	0.06701	0.17103	0.0128	0   	0   	0       1       0   	1	-360	360;
        4	5	0.01335	0.04211	0       0   	0   	0   	1       0   	1	-360	360;
        4	7	0       0.20912	0       0   	0   	0   	0.978	0   	1	-360	360;
        4	9	0       0.55618	0       0   	0   	0   	0.969	0   	1	-360	360;
        5	6	0       0.25202	0       0   	0   	0   	0.932	0   	1	-360	360;
        6	11	0.09498	0.1989	0       0   	0   	0   	1       0    	1	-360	360;
        6	12	0.12291	0.25581	0       0   	0   	0   	1       0   	1	-360	360;
        6	13	0.06615	0.13027	0       0   	0   	0   	1       0   	1	-360	360;
        7	8	0       0.17615	0       0   	0   	0   	1       0   	1	-360	360;
        7	9	0       0.11001	0       0   	0   	0   	1       0   	1	-360	360;
        9	10	0.03181	0.0845	0       0   	0   	0   	1       0   	1	-360	360;
        9	14	0.12711	0.27038	0       0   	0   	0   	1       0   	1	-360	360;
        10	11	0.08205	0.19207	0       0   	0   	0   	1       0   	1	-360	360;
        12	13	0.22092	0.19988	0       0   	0   	0   	1       0   	1	-360	360;
        13	14	0.17093	0.34802	0       0   	0   	0   	1       0   	1	-360	360;
    ];