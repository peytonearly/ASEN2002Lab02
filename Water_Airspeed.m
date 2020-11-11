%% Cleaning
clear all;
clc;

%% Load Water manometer data
load('WaterManometerDataFile');

%% Organize table data
WMR.Properties.VariableNames = {'Timestamp', 'GroupNumber', 'TubeType', 'Voltage1', 'HeightVoltage1', 'Voltage2', 'HeightVoltage2', 'Voltage3', 'HeightVoltage3', 'Voltage4', 'HeightVoltage4', 'Voltage5', 'HeightVoltage5'};
WMR.TubeType = categorical(WMR.TubeType);
WMR = sortrows(WMR, {'TubeType', 'Timestamp'});
WMR(2, :) = []; % Remove second row because data seemed off by order of magnitude
WMRP = WMR(1:14, 4:end);
WMRV = WMR(15:end, 4:end);

%% Calculations
% Pitot Static voltage-height measurements
fullVP = zeros((14*5), 1);
    fullVP(1:14) = WMRP.Voltage1(:);
    fullVP(15:28) = WMRP.Voltage2(:);
    fullVP(29:42) = WMRP.Voltage3(:);
    fullVP(43:56) = WMRP.Voltage4(:);
    fullVP(57:70) = WMRP.Voltage5(:);
fullHP = zeros((14*5), 1);
    fullHP(1:14) = WMRP.HeightVoltage1(:);
    fullHP(15:28) = WMRP.HeightVoltage2(:);
    fullHP(29:42) = WMRP.HeightVoltage3(:);
    fullHP(43:56) = WMRP.HeightVoltage4(:);
    fullHP(57:70) = WMRP.HeightVoltage5(:);
fullP = table(fullVP, fullHP, 'VariableNames', {'Voltage', 'Height'});
fullP = sortrows(fullP, 'Voltage', 'ascend');
avgVP = zeros(20, 1);
avgHP = zeros(20, 1);

% Venturi voltage-height measurements
fullVV = zeros((11*5), 1);
    fullVV(1:11) = WMRV.Voltage1(:);
    fullVV(12:22) = WMRV.Voltage2(:);
    fullVV(23:33) = WMRV.Voltage3(:);
    fullVV(34:44) = WMRV.Voltage4(:);
    fullVV(45:55) = WMRV.Voltage5(:);
fullHV = zeros((11*5), 1);
    fullHV(1:11) = WMRV.HeightVoltage1(:);
    fullHV(12:22) = WMRV.HeightVoltage2(:);
    fullHV(23:33) = WMRV.HeightVoltage3(:);
    fullHV(34:44) = WMRV.HeightVoltage4(:);
    fullHV(45:55) = WMRV.HeightVoltage5(:);
fullV = table(fullVV, fullHV, 'VariableNames', {'Voltage', 'Height'});
fullV = sortrows(fullV, 'Voltage', 'ascend');
avgVV = zeros(20, 1);
avgHV = zeros(20, 1);

% Calculate averages
for i = .5:.5:10
   avgVV(2*i) = i;
   avgVP(2*i) = i;
   
   avgHP(2*i) = mean(fullHP(fullVP == i));
   avgHV(2*i) = mean(fullHV(fullVV == i));
end

finalAvg = table(avgVP,avgHP, avgHV, 'VariableNames', {'Voltage', 'HeightPitot', 'HeightVenturi'});

%% Calculate change in pressure
% Initialize constants
rho = 997; % [kg/m^3]
g = 9.81; % [m/s^2]
R = 8.314; % [J/mol*K]

% Pgage = rho * g * h
finalAvg.PgageP = rho .* g .* finalAvg.HeightPitot;
finalAvg.PgageV = rho .* g .* finalAvg.HeightVenturi;

%% Import temperature data
load('VenturiDataFile.mat');
load('PitotProbeDataFile.mat');

% Venturi data
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
PatmV = (sum(VV1(:,1)) + sum(VV2(:,1)) + sum(VV3(:,1)) + sum(VV4(:,1)) + sum(VV5(:,1)) + sum(VV6(:,1)) + sum(VV7(:,1)) + sum(VV8(:,1)) + sum(VV9(:,1)) + sum(VV10(:,1)) + sum(VV11(:,1)) + sum(VV12(:,1))) / (N*12);
TatmV = (sum(VV1(:,2)) + sum(VV2(:,2)) + sum(VV3(:,2)) + sum(VV4(:,2)) + sum(VV5(:,2)) + sum(VV6(:,2)) + sum(VV7(:,2)) + sum(VV8(:,2)) + sum(VV9(:,2)) + sum(VV10(:,2)) + sum(VV11(:,2)) + sum(VV12(:,2))) / (N*12);

% Pitot data
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
PatmP = (sum(PP1(:,1)) + sum(PP2(:,1)) + sum(PP3(:,1)) + sum(PP4(:,1)) + sum(PP5(:,1)) + sum(PP6(:,1)) + sum(PP7(:,1)) + sum(PP8(:,1)) + sum(PP9(:,1)) + sum(PP9(:,1)) + sum(PP11(:,1)) + sum(PP12(:,1))) / (N*12);
TatmP = (sum(PP1(:,2)) + sum(PP2(:,2)) + sum(PP3(:,2)) + sum(PP4(:,2)) + sum(PP5(:,2)) + sum(PP6(:,2)) + sum(PP7(:,2)) + sum(PP8(:,2)) + sum(PP9(:,2)) + sum(PP9(:,2)) + sum(PP11(:,2)) + sum(PP12(:,2))) / (N*12);

%% Calculate airspeed using Bernoulli's equation
finalAvg.AirspeedP = sqrt(2 * finalAvg.PgageP * ((R * TatmP) / PatmP));
finalAvg.AirspeedV = sqrt(2 * finalAvg.PgageV * ((R * TatmV) / PatmV));

save('WaterAirspeedData.mat', 'finalAvg');