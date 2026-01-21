-------------------------------
1. PROJECT DESCRIPTION
-------------------------------
This project simulates the CT imaging process using two digital phantoms
(a simple phantom and the Modified Shepp–Logan phantom). For each phantom,
the code generates projection data (sinograms) using different CT acquisition
parameters and reconstructs the CT images using filtered backprojection.

Reconstructed images are evaluated using several quantitative image quality
metrics, including:
- Mean Squared Error (MSE)
- Structural Similarity Index (SSIM)
- Gradient Error
- Gradient Entropy
- Laplacian Variance (Sharpness)

The project produces:
1) Reconstructed images, error maps, and sinograms
2) A CSV file containing all metric values
3) Summary metric plots for both phantoms
4) Phantom-only images for use in the project report


-------------------------------
2. HOW TO RUN THE PROJECT
-------------------------------

STEP 1 — Ensure MATLAB is installed with:
    - Image Processing Toolbox
    - Signal Processing Toolbox (optional but recommended)

STEP 2 — Open MATLAB and set the current folder to:
    MedIm_2025_Code_MartiniDeSouza/

STEP 3 — (Optional) Generate phantom image files for the report:
    >> save_phantoms

This creates:
    results/simple_phantom.png
    results/shepp_phantom.png

STEP 4 — Run the full CT simulation and metric computation:
    >> run_medim_project

This produces:
    - All reconstructed images (PNG)
    - metrics_results.csv in /results/

STEP 5 — Generate summary metric plots:
    >> analyze_results

This produces:
    - metrics_plots_simple.png
    - metrics_plots_shepp.png


-------------------------------
3. NOTES FOR THE GRADER
-------------------------------

- All code files contain descriptive comments as required in the project
  instructions.

- The "results" folder contains all output images produced by the code.
  These images are referenced in the finalized project report.

- The phantoms and reconstructions match the acquisition parameters
  outlined in the report.

============================================================
END OF README
============================================================
