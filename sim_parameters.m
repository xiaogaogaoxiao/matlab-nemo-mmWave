% PARAMETERS OF THE SYSTEM

% TOPOLOGY
areaSide = 200; % meters
interSiteDistance_vector = 10.^((5:1:23)/10); % meters
numberOfIterations = 800;
apHeight_vector = 10; % height above UE plane (meters)
ppm2 = [.0001 .5]; % people per square meter
numberOfRandomBodies_vector = ceil(ppm2.*(areaSide^2)); %6*10.^(0:1:5); %[ 1 20 50 100 200 500 1000] - 1 ;

% USER BODY PARAMETERS
bodyAttenuation_vector = db2pow( -40 );
bodyWide = 0.4; % meters
distanceToUserBody_vector = .3; %[ 0 .05 .15 .3 inf ]; % meters
distanceToTopHead = 0.4; % meters

% POWER
txPower = db2pow( 20 ); %dBm to power
bandWidth = 100;    % MHz
frequency = 60;     % GHz
noiseFig = 9;       % dB
noisePower = db2pow( -174 + noiseFig + 10*log10( bandWidth*1e6 ) );
rxPower_threshold = db2pow( -65 ); %dBm threshold for AP association

% DIRECTIVITY GAIN
beamWidth_vector = deg2rad( [ 90 120 ] ); %2.*atan( .5 .* 10.^( (-1:22/36:29) / 10  ) ./ 10 );
beamWidthRx = deg2rad( 360 );
sideLobeGainTx = db2pow( -10 );
sideLobeGainRx = db2pow( -10 );
MainLobeGain = @(beamWidth,sideLobe) (2-sideLobe.*(1+cos(beamWidth./2))) ... 
                                        ./(1-cos(beamWidth./2));
mainLobeGainRx = MainLobeGain( beamWidthRx, sideLobeGainRx );

% PATH LOSS
% Free-space
n_L = 2; % attenuation exponent

% SMALL-SCALE FADING
% Nakagami distribution
% Shape parameter \mu
mu_R = .2; % reflected fading
mu_S = .5; % scattered fading
mu_D = 3; % direct fading
% Scale parameter \omega
om = 1;

