function R = reconstruct_ct(sino, theta, N)
% reconstruct_ct
% ---------------------------------------------
% Performs filtered backprojection reconstruction 
% using MATLAB's iradon function.
%
% INPUTS:
%   sino  : sinogram (Radon transform)
%   theta : projection angles (degrees)
%   N     : reconstruction output size NxN
%
% OUTPUT:
%   R     : reconstructed CT image

if nargin < 3
    N = 256;
end

% Filtered Backprojection (Ram-Lak filter)
R = iradon(sino, theta, "Ram-Lak", "linear", 1, N);

end
