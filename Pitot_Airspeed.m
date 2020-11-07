%%
%House Cleaning
clear all
clc
close

%% Load variables
load('PitotProbeDataFile.mat')
%%
% Base Calculations
N = height(PP1); % Number of elements 
I = 500; 
 PP1 = table2array(PP1);
 PP2 = table2array(PP2);
 PP3 = table2array(PP3);
 PP4 = table2array(PP4);
 PP5 = table2array(PP5);
 PP6 = table2array(PP6);
 PP7 = table2array(PP7);
 PP8 = table2array(PP8);
 PP9 = table2array(PP9);
 PP10 = table2array(PP10);
 PP11 = table2array(PP11);
 PP12 = table2array(PP12);
%average value of the atmospheric temperature and pressure 
Patm = (sum(PP1(:,1)) + sum(PP2(:,1)) + sum(PP3(:,1)) + sum(PP4(:,1)) + sum(PP5(:,1)) + sum(PP6(:,1)) + sum(PP7(:,1)) + sum(PP8(:,1)) + sum(PP9(:,1)) + sum(PP9(:,1)) + sum(PP11(:,1)) + sum(PP12(:,1))) / (N*12);
Tatm = (sum(PP1(:,2)) + sum(PP2(:,2)) + sum(PP3(:,2)) + sum(PP4(:,2)) + sum(PP5(:,2)) + sum(PP6(:,2)) + sum(PP7(:,2)) + sum(PP8(:,2)) + sum(PP9(:,2)) + sum(PP9(:,2)) + sum(PP11(:,2)) + sum(PP12(:,2))) / (N*12);

R = 8.314; %[J/mol·K]

%%
% Obtaining the various pressures with respect to their voltage
for Q = 1:500
	%VOLTAGE = 1.5
    P1D5(:,1) = PP3(Q,3) + PP4(Q,3) + PP7(Q,3) + PP8(Q,3) + PP11(Q,3) + PP12(Q,3);
    P1D5(:,2) = PP3(Q,4) + PP4(Q,4) + PP7(Q,4) + PP8(Q,4) + PP11(Q,4) + PP12(Q,4);
    %VOLTAGE = 1
    P1(:,1) = PP1(Q,3) + PP2(Q,3) + PP5(Q,3) + PP6(Q,3) + PP9(Q,3) + PP9(Q,3);
    P1(:,2) = PP1(Q,3) + PP2(Q,4) + PP5(Q,4) + PP6(Q,4) + PP9(Q,4) + PP9(Q,4);
    
    %VOLTAGE = 3.5
    P3D5(:,1) = PP3(Q+I,3) + PP4(Q+I,3) + PP7(Q+I,3) + PP8(Q+I,3) + PP11(Q+I,3) + PP12(Q+I,3);
    P3D5(:,2) = PP3(Q+I,4) + PP4(Q+I,4) + PP7(Q+I,4) + PP8(Q+I,4) + PP11(Q+I,4) + PP12(Q+I,4);
    %VOLTAGE = 3
    P3(:,1) = PP1(Q+I,3) + PP2(Q+I,3) + PP5(Q+I,3) + PP6(Q+I,3) + PP9(Q+I,3) + PP9(Q+I,3);
    P3(:,2) = PP1(Q+I,3) + PP2(Q+I,4) + PP5(Q+I,4) + PP6(Q+I,4) + PP9(Q+I,4) + PP9(Q+I,4);
   
    %VOLTAGE = 5.5
    P5D5(:,1) = PP3(Q+2*I,3) + PP4(Q+2*I,3) + PP7(Q+2*I,3) + PP8(Q+2*I,3) + PP11(Q+2*I,3) + PP12(Q+2*I,3);
    P5D5(:,2) = PP3(Q+2*I,4) + PP4(Q+2*I,4) + PP7(Q+2*I,4) + PP8(Q+2*I,4) + PP11(Q+2*I,4) + PP12(Q+2*I,4);
    %VOLTAGE = 5
    P5(:,1) = PP1(Q+2*I,3) + PP2(Q+2*I,3) + PP5(Q+2*I,3) + PP6(Q+2*I,3) + PP9(Q+2*I,3) + PP9(Q+2*I,3);
    P5(:,2) = PP1(Q+2*I,3) + PP2(Q+2*I,4) + PP5(Q+2*I,4) + PP6(Q+2*I,4) + PP9(Q+2*I,4) + PP9(Q+2*I,4);

    %VOLTAGE = 7.5
    P7D5(:,1) = PP3(Q+3*I,3) + PP4(Q+3*I,3) + PP7(Q+3*I,3) + PP8(Q+3*I,3) + PP11(Q+3*I,3) + PP12(Q+3*I,3);
    P7D5(:,2) = PP3(Q+3*I,4) + PP4(Q+3*I,4) + PP7(Q+3*I,4) + PP8(Q+3*I,4) + PP11(Q+3*I,4) + PP12(Q+3*I,4);
    %VOLTAGE = 7
    P7(:,1) = PP1(Q+3*I,3) + PP2(Q+3*I,3) + PP5(Q+3*I,3) + PP6(Q+3*I,3) + PP9(Q+3*I,3) + PP9(Q+3*I,3);
    P7(:,2) = PP1(Q+3*I,3) + PP2(Q+3*I,4) + PP5(Q+3*I,4) + PP6(Q+3*I,4) + PP9(Q+3*I,4) + PP9(Q+3*I,4);

    %VOLTAGE = 9.5
    P9D5(:,1) = PP3(Q+4*I,3) + PP4(Q+4*I,3) + PP7(Q+4*I,3) + PP8(Q+4*I,3) + PP11(Q+4*I,3) + PP12(Q+4*I,3);
    P9D5(:,2) = PP3(Q+4*I,4) + PP4(Q+4*I,4) + PP7(Q+4*I,4) + PP8(Q+4*I,4) + PP11(Q+4*I,4) + PP12(Q+4*I,4);
    %VOLTAGE = 9
    P9(:,1) = PP1(Q+4*I,3) + PP2(Q+4*I,3) + PP5(Q+4*I,3) + PP6(Q+4*I,3) + PP9(Q+4*I,3) + PP9(Q+4*I,3);
    P9(:,2) = PP1(Q+4*I,3) + PP2(Q+4*I,4) + PP5(Q+4*I,4) + PP6(Q+4*I,4) + PP9(Q+4*I,4) + PP9(Q+4*I,4);
end

%VOLTAGE = 1.5
A = mean(P1D5(:,1)); % Airspeed Differential Pressure [Pa]
B = mean(P1D5(:,2)); % Aux Differential Pressure [Pa]
dP = A - B;   %delta P
S_P1D5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 1
A = mean(P1(:,1));
B = mean(P1(:,2));
dP = A - B;   %delta P
S_P1 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 3.5
A = mean(P3D5(:,1));
B = mean(P3D5(:,2));
dP = A - B;   %delta P
S_P3D5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 3
A = mean(P3(:,1));
B = mean(P3(:,2));
dP = A - B;   %delta P
S_P3 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 5.5
A = mean(P5D5(:,1));
B = mean(P5D5(:,2));
dP = A - B;   %delta P
S_P5D5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 5
A = mean(P5(:,1));
B = mean(P5(:,2));
dP = A - B;   %delta P
S_P5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 7.5
A = mean(P7D5(:,1));
B = mean(P7D5(:,2));
dP = A - B;   %delta P
S_P7D5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 7
A = mean(P7(:,1));
B = mean(P7(:,2));
dP = A - B;   %delta P
S_P7 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 9.5
A = mean(P9D5(:,1));
B = mean(P9D5(:,2));
dP = A - B;   %delta P
S_P9D5 = BernoulliEq(dP, R, Tatm,Patm);

%VOLTAGE = 9
A = mean(P9(:,1));
B = mean(P9(:,2));
dP = A - B;   %delta P
S_P9 = BernoulliEq(dP, R, Tatm,Patm);

%%
% Airspeed vs. Voltage
VoltagePitot = [1 1.5 3 3.5 5 5.5 7 7.5 9 9.5];
AirspeedPitot = [S_P1 S_P1D5 S_P3 S_P3D5 S_P5 S_P5D5 S_P7 S_P7D5 S_P9 S_P9D5];
save('PitotAirspeedData.mat', 'VoltagePitot', 'AirspeedPitot');

%%
%Function
function output = BernoulliEq(deltaP, R, Tatm, Patm)
     output = sqrt(2*deltaP*((R*Tatm)/Patm));
end 

