function [sino, theta] = acquire_sinogram(P, nProj, thetaMax)
% acquire_sinogram
% ---------------------------------------------
% Computes the Radon transform (sinogram) of phantom P.
%
% INPUTS:
%   P        : ground truth phantom
%   nProj    : number of projection angles
%   thetaMax : maximum angle in degrees (180, 150, 120, 90)
%
% OUTPUTS:
%   sino  : sinogram image
%   theta : vector of projection angles

if nargin < 2
    nProj = 180;
end
if nargin < 3
    thetaMax = 180;
end

% Evenly spaced projection angles from 0 to thetaMax
theta = linspace(0, thetaMax, nProj);

% Perform Radon transform
sino = radon(P, theta);

end
