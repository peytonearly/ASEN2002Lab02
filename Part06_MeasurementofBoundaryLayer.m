%% Clean up
clear all;
clc;

%% Load Port Data
load('PitotProbeDataFile.mat');

%% Calculate density and velocity
S = struct('Tables', {PP1, PP2, PP3, PP4, PP5, PP6, PP7, PP8, PP9, PP10, PP1, PP12}); % Put tables into struct to be easily looped
R = 287; % Gas constant [J/kgK]

for i = 1:length(S)
   t = S(i).Tables; % Assign current table into temporary variable
   t.Density = t.x_AtmosphericPressure_Pa_ ./ (R .* t.AtmosphericTemperature_K_); % Calculate density for each measurement
   t.FreestreamVelocity = sqrt((2 .* t.AirspeedDifferentialPressure_Pa_) ./ t.Density);
   t.BoundaryLayerVelocity = sqrt((2 .* t.AuxDifferentialPressure_Pa_) ./ t.Density);
   t.Port = i * ones(2500, 1);
   t = sortrows(t, {'ELDProbeYAxis_mm_'});
   S(i).Tables = t;
end

T = vertcat(S(1).Tables, S(2).Tables, S(3).Tables, S(4).Tables, S(5).Tables, S(6).Tables, S(7).Tables, S(8).Tables, S(9).Tables, S(10).Tables, S(11).Tables, S(12).Tables);
T = sortrows(T, {'Port', 'Voltage_V_', 'ELDProbeYAxis_mm_'});

%% Plot Results
for i = 1:length(S)
    subplot(3, 4, i);
    plot(S(i).Tables.ELDProbeYAxis_mm_, S(i).Tables.FreestreamVelocity);
    hold on;
    plot(S(i).Tables.ELDProbeYAxis_mm_, S(i).Tables.BoundaryLayerVelocity);
    hold off;
    title("Velocty vs Y Location - Port " + i);
    xlabel("ELD Probe Y-Location [mm]");
    ylabel("Velocity [m/s]");
    legend('Freestream', 'Boundary Layer');
end

%% Calculate Boundary Layer
% Find velocity at edge of boundary layer
T.BoundaryLayerEdgeVelocity = T.FreestreamVelocity .* 0.95; % Boundary layer velocity is 95% of freestream velocity

% Calculate area at end of boundary layer?
% A1V1 = A2V2 --> A2 = A1V1/V2
T.ATestSection = 144 * ones(height(T), 1); % Area of test section in in^2
T.BoundaryLayerArea = (T.ATestSection .* T.FreestreamVelocity) ./ T.BoundaryLayerEdgeVelocity;
T.HeightBoundaryLayer = T.BoundaryLayerArea .^ .5 - T.ATestSection .^ .5;