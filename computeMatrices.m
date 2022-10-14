addpath('scriptCollection')

% optimization approach
computeMatricesForN24
computeMatricesForN15
computeMatricesForN8
computeMatricesForN35

% longterm limit estimation
computeMatricesLongTerm

% export for julia
addpath('Data')
export2Julia()
rmpath('Data')