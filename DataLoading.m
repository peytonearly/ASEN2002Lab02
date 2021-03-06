%% Cleaning
clear all;
clc;
warning('off');
%% Windtunnel Data
% Venturi Tube to Pressure Transducer
VT2PT = dir("AeroLabWindtunnelCalibration\VelocityVoltageData\VenturiTubeToPressureTransducer\");
VV1 = readtable(strcat(VT2PT(3).folder, '\', VT2PT(3).name));
VV2 = readtable(strcat(VT2PT(4).folder, '\', VT2PT(4).name));
VV3 = readtable(strcat(VT2PT(5).folder, '\', VT2PT(5).name));
VV4 = readtable(strcat(VT2PT(6).folder, '\', VT2PT(6).name));
VV5 = readtable(strcat(VT2PT(7).folder, '\', VT2PT(7).name));
VV6 = readtable(strcat(VT2PT(8).folder, '\', VT2PT(8).name));
VV7 = readtable(strcat(VT2PT(9).folder, '\', VT2PT(9).name));
VV8 = readtable(strcat(VT2PT(10).folder, '\', VT2PT(10).name));
VV9 = readtable(strcat(VT2PT(11).folder, '\', VT2PT(11).name));
VV10 = readtable(strcat(VT2PT(12).folder, '\', VT2PT(12).name));
VV11 = readtable(strcat(VT2PT(13).folder, '\', VT2PT(13).name));
VV12 = readtable(strcat(VT2PT(14).folder, '\', VT2PT(14).name));
save('VenturiDataFile.mat', 'VV1', 'VV2', 'VV3', 'VV4', 'VV5', 'VV6', 'VV7', 'VV8', 'VV9', 'VV10', 'VV11', 'VV12');

% Pitot Probe to Pressure Transducer
PP2PT = dir("AeroLabWindtunnelCalibration\VelocityVoltageData\PitotProbeToPressureTransducer\");
PP1 = readtable(strcat(PP2PT(3).folder, '\', PP2PT(3).name));
PP2 = readtable(strcat(PP2PT(4).folder, '\', PP2PT(4).name));
PP3 = readtable(strcat(PP2PT(5).folder, '\', PP2PT(5).name));
PP4 = readtable(strcat(PP2PT(6).folder, '\', PP2PT(6).name));
PP5 = readtable(strcat(PP2PT(7).folder, '\', PP2PT(7).name));
PP6 = readtable(strcat(PP2PT(8).folder, '\', PP2PT(8).name));
PP7 = readtable(strcat(PP2PT(9).folder, '\', PP2PT(9).name));
PP8 = readtable(strcat(PP2PT(10).folder, '\', PP2PT(10).name));
PP9 = readtable(strcat(PP2PT(11).folder, '\', PP2PT(11).name));
PP10 = readtable(strcat(PP2PT(12).folder, '\', PP2PT(12).name));
PP11 = readtable(strcat(PP2PT(13).folder, '\', PP2PT(13).name));
PP12 = readtable(strcat(PP2PT(14).folder, '\', PP2PT(14).name));
save('PitotProbeDataFile.mat', 'PP1', 'PP2', 'PP3', 'PP4', 'PP5', 'PP6', 'PP7', 'PP8', 'PP9', 'PP10', 'PP11', 'PP12');

% Extra Files in Velocity Voltage Data Folder
% LATVV1 = readtable("AeroLabWindtunnelCalibration\VelocityVoltageData\LA_Test_VelocityVoltage_1.csv");
WMR = readtable("AeroLabWindtunnelCalibration\VelocityVoltageData\Water manometer readings (Responses).xlsx");
save('WaterManometerDataFile', 'WMR');

% Boundary Layer Data
P1BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 1\BoundaryLayer_S301_1.csv");
P1BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 1\BoundaryLayer_S301_2.csv");
P2BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 2\BoundaryLayer_S302_1.csv");
P2BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 2\BoundaryLayer_S302_2.csv");
P3BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 3\BoundaryLayer_S303_1.csv");
P3BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 3\BoundaryLayer_S303_2.csv");
P4BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 4\BoundaryLayer_S301_3.csv");
P4BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 4\BoundaryLayer_S301_4.csv");
P5BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 5\BoundaryLayer_S302_3.csv");
P5BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 5\BoundaryLayer_S302_4.csv");
P5BL3 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 5\BoundaryLayer_S303_3.csv");
P5BL4 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 5\BoundaryLayer_S303_4.csv");
P6BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 6\BoundaryLayer_S301_6.csv");
P6BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 6\BoundaryLayer_S301_9.csv");
P7BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 7\BoundaryLayer_S301_5.csv");
P7BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 7\BoundaryLayer_S303_5.csv");
P7BL3 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 7\BoundaryLayer_S303_6.csv");
P8BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 8\BoundaryLayer_S302_5.csv");
P8BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 8\BoundaryLayer_S302_6.csv");
P9BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 9\BoundaryLayer_S303_7.csv");
P9BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 9\BoundaryLayer_S303_8.csv");
P10BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 10\BoundaryLayer_S301_7.csv");
P10BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 10\BoundaryLayer_S301_8.csv");
P11BL1 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 11\BoundaryLayer_S302_7.csv");
P11BL2 = readtable("AeroLabWindtunnelCalibration\BoundaryLayerData\Port 11\BoundaryLayer_S302_8.csv");
save('BoundaryLayerDataFile.mat', 'P1BL1', 'P1BL2', 'P2BL1', 'P2BL2', 'P3BL1', 'P3BL2', 'P4BL1', ...
    'P4BL2', 'P5BL1', 'P5BL2', 'P5BL3', 'P5BL4', 'P6BL1', 'P6BL2', 'P7BL1', 'P7BL2', 'P7BL3', ...
    'P8BL1', 'P8BL2', 'P9BL1', 'P9BL2', 'P10BL1', 'P10BL2', 'P11BL1', 'P11BL2');

%% Airfoil Data
% Airfoil Pressure Data
ALAT = dir("AeroLabAirfoilTesting\");
AP1 = readtable(strcat(ALAT(3).folder, '\', ALAT(3).name));
AP2 = readtable(strcat(ALAT(4).folder, '\', ALAT(4).name));
AP3 = readtable(strcat(ALAT(5).folder, '\', ALAT(5).name));
AP4 = readtable(strcat(ALAT(6).folder, '\', ALAT(6).name));
AP5 = readtable(strcat(ALAT(7).folder, '\', ALAT(7).name));
AP6 = readtable(strcat(ALAT(8).folder, '\', ALAT(8).name));
AP7 = readtable(strcat(ALAT(9).folder, '\', ALAT(9).name));
AP8 = readtable(strcat(ALAT(10).folder, '\', ALAT(10).name));
AP9 = readtable(strcat(ALAT(11).folder, '\', ALAT(11).name));
AP10 = readtable(strcat(ALAT(12).folder, '\', ALAT(12).name));
AP11 = readtable(strcat(ALAT(13).folder, '\', ALAT(13).name));
AP12 = readtable(strcat(ALAT(14).folder, '\', ALAT(14).name));
AP13 = readtable(strcat(ALAT(15).folder, '\', ALAT(15).name));
AP14 = readtable(strcat(ALAT(16).folder, '\', ALAT(16).name));
AP15 = readtable(strcat(ALAT(17).folder, '\', ALAT(17).name));
AP16 = readtable(strcat(ALAT(18).folder, '\', ALAT(18).name));
AP17 = readtable(strcat(ALAT(19).folder, '\', ALAT(19).name));
AP18 = readtable(strcat(ALAT(20).folder, '\', ALAT(20).name));
AP19 = readtable(strcat(ALAT(21).folder, '\', ALAT(21).name));
AP20 = readtable(strcat(ALAT(22).folder, '\', ALAT(22).name));
AP21 = readtable(strcat(ALAT(23).folder, '\', ALAT(23).name));
AP22 = readtable(strcat(ALAT(24).folder, '\', ALAT(24).name));
AP23 = readtable(strcat(ALAT(25).folder, '\', ALAT(25).name));
AP24 = readtable(strcat(ALAT(26).folder, '\', ALAT(26).name));
AP25 = readtable(strcat(ALAT(27).folder, '\', ALAT(27).name));
AP26 = readtable(strcat(ALAT(28).folder, '\', ALAT(28).name));
save('AirfoilPressureData.mat', 'AP1', 'AP2', 'AP3', 'AP4', 'AP5', ...
    'AP6', 'AP7', 'AP8', 'AP9', 'AP10', 'AP11', 'AP12', 'AP13', ...
    'AP14', 'AP15', 'AP16', 'AP17', 'AP18', 'AP19', 'AP20', 'AP21', ...
    'AP22', 'AP23', 'AP24', 'AP25', 'AP26');
