%%
%House Cleaning
clear all
clc
close
load('VenturiDataFile.mat')
%%
% Base Calculations
N = height(VV1); % Number of elements 
I = 500; 
 VV1 = table2array(VV1);
 VV2 = table2array(VV2);
 VV3 = table2array(VV3);
 VV4 = table2array(VV4);
 VV5 = table2array(VV5);
 VV6 = table2array(VV6);
 VV7 = table2array(VV7);
 VV8 = table2array(VV8);
 VV9 = table2array(VV9);
 VV10 = table2array(VV10);
 VV11 = table2array(VV11);
 VV12 = table2array(VV12);
%average value of the atmospheric temperature and pressure 
Patm = (sum(VV1(:,1)) + sum(VV2(:,1)) + sum(VV3(:,1)) + sum(VV4(:,1)) + sum(VV5(:,1)) + sum(VV6(:,1)) + sum(VV7(:,1)) + sum(VV8(:,1)) + sum(VV9(:,1)) + sum(VV10(:,1)) + sum(VV11(:,1)) + sum(VV12(:,1))) / (N*12);
Tatm = (sum(VV1(:,2)) + sum(VV2(:,2)) + sum(VV3(:,2)) + sum(VV4(:,2)) + sum(VV5(:,2)) + sum(VV6(:,2)) + sum(VV7(:,2)) + sum(VV8(:,2)) + sum(VV9(:,2)) + sum(VV10(:,2)) + sum(VV11(:,2)) + sum(VV12(:,2))) / (N*12);

R = 8.314; %[J/mol·K]
A1 = 42.5^2; 
A2 = 28^2;

%%
% Obtaining the various pressures with respect to their voltage
for Q = 1:500
	%VOLTAGE = 0.5
    VD5(:,1) = VV3(Q,3) + VV4(Q,3) + VV7(Q,3) + VV8(Q,3) + VV11(Q,3) + VV12(Q,3);
    VD5(:,2) = VV3(Q,4) + VV4(Q,4) + VV7(Q,4) + VV8(Q,4) + VV11(Q,4) + VV12(Q,4);
    %VOLTAGE = 2
    V2(:,1) = VV1(Q,3) + VV2(Q,3) + VV5(Q,3) + VV6(Q,3) + VV9(Q,3) + VV10(Q,3);
    V2(:,2) = VV1(Q,3) + VV2(Q,4) + VV5(Q,4) + VV6(Q,4) + VV9(Q,4) + VV10(Q,4);
    
    %VOLTAGE = 2.5
    V2D5(:,1) = VV3(Q+I,3) + VV4(Q+I,3) + VV7(Q+I,3) + VV8(Q+I,3) + VV11(Q+I,3) + VV12(Q+I,3);
    V2D5(:,2) = VV3(Q+I,4) + VV4(Q+I,4) + VV7(Q+I,4) + VV8(Q+I,4) + VV11(Q+I,4) + VV12(Q+I,4);
    %VOLTAGE = 4
    V4(:,1) = VV1(Q+I,3) + VV2(Q+I,3) + VV5(Q+I,3) + VV6(Q+I,3) + VV9(Q+I,3) + VV10(Q+I,3);
    V4(:,2) = VV1(Q+I,3) + VV2(Q+I,4) + VV5(Q+I,4) + VV6(Q+I,4) + VV9(Q+I,4) + VV10(Q+I,4);
   
    %VOLTAGE = 4.5
    V4D5(:,1) = VV3(Q+2*I,3) + VV4(Q+2*I,3) + VV7(Q+2*I,3) + VV8(Q+2*I,3) + VV11(Q+2*I,3) + VV12(Q+2*I,3);
    V4D5(:,2) = VV3(Q+2*I,4) + VV4(Q+2*I,4) + VV7(Q+2*I,4) + VV8(Q+2*I,4) + VV11(Q+2*I,4) + VV12(Q+2*I,4);
    %VOLTAGE = 6
    V6(:,1) = VV1(Q+2*I,3) + VV2(Q+2*I,3) + VV5(Q+2*I,3) + VV6(Q+2*I,3) + VV9(Q+2*I,3) + VV10(Q+2*I,3);
    V6(:,2) = VV1(Q+2*I,3) + VV2(Q+2*I,4) + VV5(Q+2*I,4) + VV6(Q+2*I,4) + VV9(Q+2*I,4) + VV10(Q+2*I,4);

    %VOLTAGE = 6.5
    V6D5(:,1) = VV3(Q+3*I,3) + VV4(Q+3*I,3) + VV7(Q+3*I,3) + VV8(Q+3*I,3) + VV11(Q+3*I,3) + VV12(Q+3*I,3);
    V6D5(:,2) = VV3(Q+3*I,4) + VV4(Q+3*I,4) + VV7(Q+3*I,4) + VV8(Q+3*I,4) + VV11(Q+3*I,4) + VV12(Q+3*I,4);
    %VOLTAGE = 8
    V8(:,1) = VV1(Q+3*I,3) + VV2(Q+3*I,3) + VV5(Q+3*I,3) + VV6(Q+3*I,3) + VV9(Q+3*I,3) + VV10(Q+3*I,3);
    V8(:,2) = VV1(Q+3*I,3) + VV2(Q+3*I,4) + VV5(Q+3*I,4) + VV6(Q+3*I,4) + VV9(Q+3*I,4) + VV10(Q+3*I,4);

    %VOLTAGE = 8.5
    V8D5(:,1) = VV3(Q+4*I,3) + VV4(Q+4*I,3) + VV7(Q+4*I,3) + VV8(Q+4*I,3) + VV11(Q+4*I,3) + VV12(Q+4*I,3);
    V8D5(:,2) = VV3(Q+4*I,4) + VV4(Q+4*I,4) + VV7(Q+4*I,4) + VV8(Q+4*I,4) + VV11(Q+4*I,4) + VV12(Q+4*I,4);
    %VOLTAGE = 10
    V10(:,1) = VV1(Q+4*I,3) + VV2(Q+4*I,3) + VV5(Q+4*I,3) + VV6(Q+4*I,3) + VV9(Q+4*I,3) + VV10(Q+4*I,3);
    V10(:,2) = VV1(Q+4*I,3) + VV2(Q+4*I,4) + VV5(Q+4*I,4) + VV6(Q+4*I,4) + VV9(Q+4*I,4) + VV10(Q+4*I,4);
end

%VOLTAGE = 0.5
A = mean(VD5(:,1)); % Airspeed Differential Pressure [Pa]
B = mean(VD5(:,2)); % Aux Differential Pressure [Pa]
dP = A - B;   %delta P
S_VD5 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 2
A = mean(V2(:,1));
B = mean(V2(:,2));
dP = A - B;   %delta P
S_V2 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 2.5
A = mean(V2D5(:,1));
B = mean(V2D5(:,2));
dP = A - B;   %delta P
S_V2D5 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 4
A = mean(V4(:,1));
B = mean(V4(:,2));
dP = A - B;   %delta P
S_V4 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 4.5
A = mean(V4D5(:,1));
B = mean(V4D5(:,2));
dP = A - B;   %delta P
S_V4D5 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 6 
A = mean(V6(:,1));
B = mean(V6(:,2));
dP = A - B;   %delta P
S_V6 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 6.5
A = mean(V6D5(:,1));
B = mean(V6D5(:,2));
dP = A - B;   %delta P
S_V6D5 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 8
A = mean(V8(:,1));
B = mean(V8(:,2));
dP = A - B;   %delta P
S_V8 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 8.5
A = mean(V8D5(:,1));
B = mean(V8D5(:,2));
dP = A - B;   %delta P
S_V8D5 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%VOLTAGE = 10
A = mean(V10(:,1));
B = mean(V10(:,2));
dP = A - B;   %delta P
S_V10 = VenturiTubeConfig(dP, R, Tatm,Patm,A1,A2);

%%
% Airspeed vs. Voltage
Voltage = [0.5 2 2.5 4 4.5 6 6.5 8 8.5 10];
Airspeed = [S_V2 S_V2 S_V2D5 S_V4 S_V4D5 S_V6 S_V6D5 S_V8 S_V8D5 S_V10];

plot(Voltage, Airspeed);
xlabel('Voltage [V]');
ylabel('Airspeed [m/s]');
title('Venturi Airspeed vs Voltage');

%%
%Function
function output = VenturiTubeConfig(deltaP, R, Tatm, Patm, A1, A2) 
    output = sqrt((2 * deltaP * R * Tatm) / (Patm * (1 - (A2/A1)^2)));
end