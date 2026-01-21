function metrics = compute_metrics(gt, recon)
% compute_metrics
% ---------------------------------------------------
% Computes multiple image quality metrics comparing 
% the reconstructed image to the ground truth phantom.
%
% INPUTS:
%   gt    : ground truth image
%   recon : reconstructed image
%
% OUTPUT:
%   metrics : struct containing:
%       mse
%       ssim
%       gradient_error
%       grad_entropy_gt
%       grad_entropy_recon
%       grad_entropy_diff
%       laplacian_var_gt
%       laplacian_var_recon
%       laplacian_var_diff

% Normalize images to [0,1]
gt = mat2gray(gt);
recon = mat2gray(recon);

% -------------------------------
% 1. MSE
% -------------------------------
mse_val = mean((gt(:) - recon(:)).^2);

% -------------------------------
% 2. SSIM
% -------------------------------
ssim_val = ssim(recon, gt);

% -------------------------------
% 3. Gradient Error
% -------------------------------
[mag_gt, mag_rec] = local_gradient_maps(gt, recon);
ge_val = sum(abs(mag_gt(:) - mag_rec(:))) / numel(gt);

% -------------------------------
% 4. Gradient Entropy
% -------------------------------
gEn_gt  = local_grad_entropy(mag_gt);
gEn_rec = local_grad_entropy(mag_rec);
gEn_diff = abs(gEn_gt - gEn_rec);

% -------------------------------
% 5. Laplacian Variance (sharpness)
% -------------------------------
lap_gt  = local_laplacian(gt);
lap_rec = local_laplacian(recon);

lap_var_gt  = var(lap_gt(:));
lap_var_rec = var(lap_rec(:));
lap_var_diff = abs(lap_var_gt - lap_var_rec);

% Assemble metrics struct
metrics.mse = mse_val;
metrics.ssim = ssim_val;
metrics.gradient_error = ge_val;
metrics.grad_entropy_gt = gEn_gt;
metrics.grad_entropy_recon = gEn_rec;
metrics.grad_entropy_diff = gEn_diff;
metrics.laplacian_var_gt = lap_var_gt;
metrics.laplacian_var_recon = lap_var_rec;
metrics.laplacian_var_diff = lap_var_diff;

end


% ---------------------------------------------------
% Helper Functions
% ---------------------------------------------------

function [mag_gt, mag_rec] = local_gradient_maps(gt, recon)
% Computes gradient magnitudes for both images.

[gx_gt, gy_gt] = imgradientxy(gt);
[gx_rec, gy_rec] = imgradientxy(recon);

mag_gt  = sqrt(gx_gt.^2  + gy_gt.^2);
mag_rec = sqrt(gx_rec.^2 + gy_rec.^2);

end

function val = local_grad_entropy(mag)
% Computes entropy of gradient magnitude histogram.

mag = mag(:);
nbins = 64;
[counts, ~] = histcounts(mag, nbins);
p = counts / sum(counts);
p = p(p > 0);   % remove zeros for log computation

val = -sum(p .* log(p));

end

function lap = local_laplacian(I)
% Applies Laplacian filter for sharpness measurement.

k = [0 1 0; 1 -4 1; 0 1 0];
lap = imfilter(I, k, "replicate", "conv");

end
