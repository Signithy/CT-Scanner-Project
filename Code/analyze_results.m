clear; close all; clc;

% Load table of all metric results
T = readtable(fullfile("results", "metrics_results.csv"));

phantoms = unique(T.phantom_type);
thetaVals = unique(T.thetaMax);

% ---------------------------------------------------
% Create metric plots for each phantom
% ---------------------------------------------------
for p = 1:numel(phantoms)
    pt = phantoms{p};
    mask_p = strcmp(T.phantom_type, pt);
    
    figure;
    legend_entries = cell(numel(thetaVals),1);
    
    for t = 1:numel(thetaVals)
        thetaMax = thetaVals(t);
        mask = mask_p & T.thetaMax == thetaMax;
        Tsub = T(mask, :);

        % Sort rows by number of projections for clean plotting
        [~, order] = sort(Tsub.nProj);
        Tsub = Tsub(order, :);

        % -----------------------------
        % Plot MSE
        % -----------------------------
        subplot(2,2,1);
        hold on;
        plot(Tsub.nProj, Tsub.mse, "-o");
        title(sprintf("MSE vs nProj (%s)", pt));
        xlabel("nProj");
        ylabel("MSE");
        legend_entries{t} = sprintf("\\theta_{max}=%d°", thetaMax);

        % -----------------------------
        % Plot SSIM
        % -----------------------------
        subplot(2,2,2);
        hold on;
        plot(Tsub.nProj, Tsub.ssim, "-o");
        title(sprintf("SSIM vs nProj (%s)", pt));
        xlabel("nProj");
        ylabel("SSIM");

        % -----------------------------
        % Plot Gradient Error
        % -----------------------------
        subplot(2,2,3);
        hold on;
        plot(Tsub.nProj, Tsub.gradient_error, "-o");
        title(sprintf("Gradient Error vs nProj (%s)", pt));
        xlabel("nProj");
        ylabel("Gradient Error");

        % -----------------------------
        % Plot Laplacian Variance
        % -----------------------------
        subplot(2,2,4);
        hold on;
        plot(Tsub.nProj, Tsub.laplacian_var_recon, "-o");
        title(sprintf("Var(Laplacian) vs nProj (%s)", pt));
        xlabel("nProj");
        ylabel("Var(Laplacian)");
    end
    
    subplot(2,2,1);
    legend(legend_entries, "Location", "best");

    % Save plot image
    fname = sprintf("metrics_plots_%s.png", pt);
    saveas(gcf, fullfile("results", fname));
end
