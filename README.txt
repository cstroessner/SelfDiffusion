Code to reproduce the figures in "Tensor approximation of the self-diffusion matrix of tagged
particle processes" by J. Dabaghi, V. Ehrlacher and C. Strössner.
(Arxiv: https://arxiv.org/abs/2204.03943.)

All numerical experiments can be reproduced by running the script runEverything which calls the individual fuctions in scriptCollection. This takes several hours. The function computeMatrices computes the approximation of the self-diffusion coefficient for N=8, N=15 and N=24 for all ell using both the optimization approach and the Monte Carlo approach. 
The folders functionsNsuccessive contain the necessary function to compute the self-diffusion coefficient using the optimization approach with parameter N. The folders StochasticApproachN contain the corresponding Monte Carlo algorithms.
The MATLAB code is selfcontained. 

In the folder Data we additionally provide the files matrices.csv and interpolation.ipynb, which can be used to evaluate the computed self-diffusion coefficient computed for N=24 using the optimization approach for arbitrary values of rho in Julia.
The Julia code requires the packages CSV, Plots, Interpolations and DataFrames.
