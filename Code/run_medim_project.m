clear; close all; clc;

% Ensure results folder exists
if ~exist("results", "dir")
    mkdir results
end

% Phantom sizes and parameter sweeps
N = 256;
phantomTypes = {"simple", "shepp"};
nProjList = [30 60 90 180];
thetaMaxList = [180 150 120 90];

% Total number of experiments
numComb = numel(phantomTypes) * numel(thetaMaxList) * numel(nProjList);

% Preallocate results struct using template
tmp = compute_metrics(zeros(N), zeros(N));
tmp.phantom_type = "";
tmp.nProj = 0;
tmp.thetaMax = 0;

results = repmat(tmp, numComb, 1);

idx = 1;

% ----------------------------------------------
% Run all phantom / acquisition combinations
% ----------------------------------------------
for p = 1:numel(phantomTypes)

    % Generate ground truth
    P = generate_phantom(phantomTypes{p}, N);
    
    for t = 1:numel(thetaMaxList)
        thetaMax = thetaMaxList(t);
        
        for k = 1:numel(nProjList)
            nProj = nProjList(k);
            
            % Acquire projections
            [sino, theta] = acquire_sinogram(P, nProj, thetaMax);

            % Reconstruct
            R = reconstruct_ct(sino, theta, N);

            % Compute metrics
            m = compute_metrics(P, R);
            m.phantom_type = phantomTypes{p};
            m.nProj = nProj;
            m.thetaMax = thetaMax;
            results(idx) = m;
            idx = idx + 1;

            % --------------------------------------
            % Save image figure with 4 subplots
            % --------------------------------------
            f = figure;
            subplot(2,2,1); imshow(P, []); 
            title(sprintf("GT (%s)", phantomTypes{p}));

            subplot(2,2,2); imshow(R, []); 
            title(sprintf("Recon: nProj=%d, θ_{max}=%d°", nProj, thetaMax));

            subplot(2,2,3); 
            imshow(sino, [], "XData", theta, "YData", 1:size(sino,1));
            xlabel("Angle (deg)");
            ylabel("Detector");
            title("Sinogram");

            subplot(2,2,4); imshow(abs(P-R), []);
            title("Abs Error Map");

            fname = sprintf("results_%s_theta%d_nProj%d.png", ...
                phantomTypes{p}, thetaMax, nProj);

            saveas(f, fullfile("results", fname));
            close(f);
        end
    end
end

% Save results table
T = struct2table(results);
writetable(T, fullfile("results", "metrics_results.csv"));
disp(T);
