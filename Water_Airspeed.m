%% Cleaning
clear all;
clc;

%% Water manometer
%row 1: Pitot : 1-9
%row 1: Pitot : 1-9
%row 1: Venturi : 2-10
%row 1: Pitot : 2-10
%row 1: Pitot : 2-10
%row 1: Venturi : 1-9
%row 1: Pitot : 1-9
%row 1: Venturi : 2-10
%row 1: Venturi : 2-10
%row 1: Venturi : 1.5-9.5
%row 1: Venturi : 1-9
%row 1: Pitot : 1-9
%row 1: Venturi : 2-10
%row 1: Venturi : 2-10
%row 1: Pitot : 2-10
%row 1: Pitot : 1.5-9.5
%row 1: Pitot : 1.5-9.5
%row 1: Pitot : 2-10
%row 1: Pitot : 1.5-9.5
%row 1: Pitot : 0.5-8.5
%row 1: Pitot : 0.5-8.5
%row 1: Venturi : 0.5-8.5
%row 1: Pitot : 0.5-8.5
%row 1: Venturi : 0.5-8.5
%row 1: Venturi : 1.5-9.5
%row 1: Pitot : 0.5-8.5

%% Load Water manometer data
load('WaterManometerDataFile');

%% Organize table data
WMR.Properties.VariableNames = {'Timestamp', 'GroupNumber', 'TubeType', 'Voltage1', 'HeightVoltage1', 'Voltage2', 'HeightVoltage2', 'Voltage3', 'HeightVoltage3', 'Voltage4', 'HeightVoltage4', 'Voltage5', 'HeightVoltage5'};
WMR.TubeType = categorical(WMR.TubeType);
WMR = sortrows(WMR, {'TubeType', 'Timestamp'});

%% Calculations
% Pgage = rho * g * h
% Pabs = Patm + Pgage