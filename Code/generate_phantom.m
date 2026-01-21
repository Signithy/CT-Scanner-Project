function P = generate_phantom(type, N)
% generate_phantom
% ---------------------------------------------
% Generates a digital phantom image.
%
% INPUTS:
%   type : "simple" or "shepp" 
%   N    : output image size (NxN)
%
% OUTPUT:
%   P    : generated phantom image
%
% The "simple" phantom is custom-built using circles and a rectangle.
% The "shepp" phantom uses MATLAB's Modified Shepp-Logan model.

if nargin < 1
    type = "shepp";
end
if nargin < 2
    N = 256;
end

switch lower(string(type))

    case "simple"
        P = zeros(N);
        [x, y] = meshgrid(linspace(-1,1,N), linspace(-1,1,N));
        
        % Two circular shapes
        r1 = sqrt((x+0.3).^2 + (y+0.3).^2) <= 0.2;
        r2 = sqrt((x-0.25).^2 + (y-0.2).^2) <= 0.15;

        % Rectangular shape
        rect = abs(x) <= 0.15 & y >= -0.1 & y <= 0.2;

        % Assign intensities
        P(r1)  = 0.7;
        P(r2)  = 1.0;
        P(rect)= 0.4;

    case "shepp"
        % MATLAB built-in phantom
        P = phantom("Modified Shepp-Logan", N);

    otherwise
        error("Unknown phantom type.");
end

end
