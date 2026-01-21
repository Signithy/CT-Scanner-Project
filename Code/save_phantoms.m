function save_phantoms()
% save_phantoms
% ----------------------------------------------------
% Generates and saves standalone phantom images for 
% use in the Methods section of the project report.
%
% This script creates:
%   - simple_phantom.png
%   - shepp_phantom.png
%
% These are saved inside the "results" folder.
%
% No inputs.
% No outputs.
%
% REQUIREMENTS:
%   - generate_phantom.m
%   - MATLAB Image Processing Toolbox

clear; close all; clc;

% Image size for both phantoms
N = 256;

% ----------------------------------------------------
% Generate phantoms using our main phantom generator
% ----------------------------------------------------
P_simple = generate_phantom("simple", N);
P_shepp  = generate_phantom("shepp",  N);

% ----------------------------------------------------
% Ensure the results folder exists
% ----------------------------------------------------
if ~exist("results", "dir")
    mkdir results
end

% ----------------------------------------------------
% Save Simple Phantom Image
% ----------------------------------------------------
figure;
imshow(P_simple, []);
title("Simple Phantom");
saveas(gcf, fullfile("results", "simple_phantom.png"));
close(gcf);

% ----------------------------------------------------
% Save Shepp–Logan Phantom Image
% ----------------------------------------------------
figure;
imshow(P_shepp, []);
title("Shepp-Logan Phantom");
saveas(gcf, fullfile("results", "shepp_phantom.png"));
close(gcf);

disp("Phantom images successfully saved to /results/");

end
