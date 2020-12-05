%% Clean up
clear all;
clc;

%% Load Port Data
load('BoundaryLayerDataFile.mat');

%% Organize data based on port number
port01 = [P1BL1; P1BL2];               % Consolodate data from port 1
port02 = [P2BL1; P2BL2];               % Consolodate data from port 2
port03 = [P3BL1; P3BL2];               % Consolodate data from port 3
port04 = [P4BL1; P4BL2];               % Consolodate data from port 4
port05 = [P5BL1; P5BL2; P5BL3; P5BL4]; % Consolodate data from port 5
port06 = [P6BL1; P6BL2];               % Consolodate data from port 6
port07 = [P7BL1; P7BL2; P7BL3];        % Consolodate data from port 7
port08 = [P8BL1; P8BL2];               % Consolodate data from port 8
port09 = [P9BL1; P9BL2];               % Consolodate data from port 9
port10 = [P10BL1; P10BL2];             % Consolodate data from port 10
port11 = [P11BL1; P11BL2];             % Consolodate data from port 11

% Consolodate port data into struct
portStruct = struct('Tables', {port01, port02, port03, port04, port05, port06, port07, port08, port09, port10, port11});

%% Calculate density and velocity
R = 287; % Gas constant [J/kgK]

for i = 1:length(portStruct)
   t = portStruct(i).Tables;                                                                     % Assign current table into temporary variable
   t.Density = t.x_AtmosphericPressure_Pa_ ./ (R .* t.AtmosphericTemperature_K_);       % Calculate density for each measurement
   t.FreestreamVelocity = sqrt((2 .* abs(t.AirspeedDifferentialPressure_Pa_)) ./ t.Density); % Calculate freestream velocity
   t.BoundaryLayerVelocity = sqrt((2 .* abs(t.AuxDifferentialPressure_Pa_)) ./ t.Density);   % Calculate boundary layer velocity
   t.Port = i * ones(height(t), 1);                                                          % Keep track of associated port
   t = sortrows(t, {'ELDProbeYAxis_mm_'});                                              % Sort the rows based on Y axis location
   portStruct(i).Tables = t;                                                                     % Add table to struct
end

T = vertcat(portStruct(1).Tables, portStruct(2).Tables, portStruct(3).Tables, portStruct(4).Tables, portStruct(5).Tables, portStruct(6).Tables, portStruct(7).Tables, portStruct(8).Tables, portStruct(9).Tables, portStruct(10).Tables, portStruct(11).Tables);
T = sortrows(T, {'Port', 'ELDProbeYAxis_mm_'});

% Only want to look for Y values <= 10
T(T.ELDProbeYAxis_mm_ > 10, :) = [];
for i = 1:length(portStruct)
   portStruct(i).Tables(portStruct(i).Tables.ELDProbeYAxis_mm_ > 10, :) = []; 
end

%% Create best fit lines
polyStruct = struct('LOBF', {}); % Initialize struct that will keep track of polyfit lines

% Loop through each port
for i = 1:length(portStruct)
    polyStruct(i).LOBF = polyfit(portStruct(i).Tables.BoundaryLayerVelocity, portStruct(i).Tables.ELDProbeYAxis_mm_, 2);
end

evalStruct = struct('Eval', {}); % Initialize struct that will keep track of polyfit calculations evaluated at each Y axis value
evalVec = zeros(length(portStruct), 1); % Initialize vector for keeping track of values

% Loop through each port
for i = 1:length(polyStruct)
    evalStruct(i).Eval = polyval(polyStruct(i).LOBF, portStruct(i).Tables.BoundaryLayerVelocity);
%     tempBLayer = portStruct(i).Tables.FreestreamVelocity .* 0.95;
%     evalVec(i) = evalStruct(i).Eval(find(evalStruct(i).Eval - tempBLayer >= 0, 1));
end

% Calculate 95% freestream velocity
freeS95 = zeros(length(portStruct), 1);
for i = 1:length(portStruct)
   freeS95(i) = mean(portStruct(i).Tables.FreestreamVelocity) * .95;
   evalVec(i) = polyval(polyStruct(i).LOBF, freeS95(i));
end

%% Laminar vs Turbulent Boundary Layer Flow

Re = 300;

hLam = @(x) (5.2 * x) / sqrt(Re); % Laminar Equation
hTur = @(x) (0.37 * x) / (Re ^ 0.2); % Turbulent equation

evalLam = hLam(freeS95); % Calculate theoretical boundary layer heights for laminar flow
evalTur = hTur(freeS95); % Calculate theoretical boundary layer heights for turbulent flow

% Compare calculated boundary layer height to laminar and turbulent height
lamFlow = abs(evalVec - evalLam) > abs(evalVec - evalTur);
turFlow = ~lamFlow;

%% Plot Results
for i = 1:length(portStruct)
    subplot(3, 4, i);
    plot(portStruct(i).Tables.FreestreamVelocity, portStruct(i).Tables.ELDProbeYAxis_mm_);
    hold on;
    scatter(portStruct(i).Tables.BoundaryLayerVelocity, portStruct(i).Tables.ELDProbeYAxis_mm_, '.', 'MarkerEdgeAlpha', .2);
    plot(portStruct(i).Tables.BoundaryLayerVelocity, evalStruct(i).Eval, 'k')
    xline(freeS95(i), 'g');
    hold off;
    grid on;
    title("Velocity vs Y Location - Port " + i);
    ylabel("ELD Probe Y-Location [mm]");
    xlabel("Velocity [m/s]");
    ylim([0 10]);
    legend('Freestream', 'Boundary Layer', 'Best Fit Line', '95% Freestream', 'Location', 'northwest');
end

% Plot boundary layer height vs port number
subplot(3,4,12);
plot(evalVec);
hold on;
scatter(1:length(evalLam), evalLam);
scatter(1:length(evalTur), evalTur);
grid on; grid minor;
title("Boundary Layer Height Evolution");
xlabel("Port Number")
ylabel("Boundary Layer Thickness [mm]");
% legend('Calculated Height', 'Laminar Height', 'Turbulent Height', 'Location', 'best');

% Display laminar and turbulent comparisons
for i = 1:length(evalVec)
   fprintf('Port %d is ', i);
   if lamFlow(i)
       fprintf('Laminar \n');
   else
       fprintf('Turbulent \n');
   end
end