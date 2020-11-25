%% Clean up
clear all;
clc;

%% Load airfoil data
load('AirfoilPressureData.mat');

%% Reorganize table data
% Combine into one collective table
grandTable = [AP1; AP2; AP3; AP4; AP5; AP6; AP7; AP8; AP9; AP10; AP11; AP12; AP13; AP14; AP15; AP16; AP17; AP18; AP19; AP20; AP21; AP22; AP23; AP24; AP25; AP26];

% Sort table by angle of attack
grandTable = sortrows(grandTable, {'AngleOfAttack_deg_', 'Airspeed_m_s_'});
grandArray = table2array(grandTable);

% Find indexing values
sz = size(grandArray);
row = sz(1);
col = sz(2);
minAngle = grandArray(1, 23);
maxAngle = grandArray(end, 23);

%% Find averages

% Initialize array for storing average values
avgArr = zeros(1, col);
tempArr = zeros(1, col);
tempArr2 = zeros(1, col);

for i = minAngle:maxAngle
    % Split table according to current index
    tempArr = grandArray((grandArray(:, 23) == i), :); % Create smaller array of just values containing desired angle
    airspeed = ceil(max(tempArr(:, 4))); % Calculate max airspeed at given angle
    
    idx1 = find(tempArr(:, 4) < 10);
    idx2 = find(tempArr(:, 4) >= 10 & tempArr(:, 4) < 20);
    idx3 = find(tempArr(:, 4) >= 20 & tempArr(:, 4) < 30);
    idx4 = find(tempArr(:, 4) >= 30);
    
    if idx1
        tempArr2 = mean(tempArr(idx1, :), 1);
        avgArr = [avgArr; tempArr2];
    end
    
    if idx2 
        tempArr2 = mean(tempArr(idx2, :), 1);
        avgArr = [avgArr; tempArr2];
    end
    
    if idx3
        tempArr2 = mean(tempArr(idx3, :), 1);
        avgArr = [avgArr; tempArr2];
    end
    
    if idx4
        tempArr2 = mean(tempArr(idx4, :), 1);
        avgArr = [avgArr; tempArr2];
    end
    
%     for j = 1:airspeed % Loop from 1 to highest airspeed at given angle
%         idx = find(floor(tempArr(:, 4)) == j); % Find index for values within integer
%         if (idx) % Only add to array if index contains values
%             tempArr2 = mean(tempArr(idx, :), 1);
%             avgArr = [avgArr; tempArr2];
%         end
%     end
end

avgArr(1, :) = [];

%% Convert averages back to a table
varNames = {'AtmosphericPressure', 'AtmosphericTemperature', 'AtmosphericDensity', 'Airspeed', 'PitotDynamicPressure', 'AuxDynamicPressure', 'ScanivalvePressure1', 'ScanivalvePressure2', 'ScanivalvePressure3', 'ScanivalvePressure4', 'ScanivalvePressure5', 'ScanivalvePressure6', 'ScanivalvePressure7', 'ScanivalvePressure8', 'ScanivalvePressure9', 'ScanivalvePressure10', 'ScanivalvePressure11', 'ScanivalvePressure12', 'ScanivalvePressure13', 'ScanivalvePressure14', 'ScanivalvePressure15', 'ScanivalvePressure16', 'AngleofAttack', 'StingNormalForce', 'StingAxialForce', 'StingPitchingMoment', 'ELDProbeXAxis', 'ELDProbeYAxis'};
varUnits = {'Pa', 'K', 'kg/m^3', 'm/s', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'deg', 'N', 'N', 'N-m', 'mm', 'mm'};
AirfoilData = array2table(avgArr);
AirfoilData.Properties.VariableNames = varNames;
AirFoilData.Properties.VariableUnits = varUnits;

%% Save table
save('AirfoilData.mat', 'AirfoilData');