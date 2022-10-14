%% script to reproduce every single plot in the paper
addpath('scriptCollection')
clc
clear
close all

%% computation of matrices for further experiments
computeMatrices

%% Figure 7
% requires to run compute Matrices fist
FigureDifferentTraces

%% Figure 4
FigureMonteCarloStudy

%% Figure 3
FigureRankImpact

%% Figure 5
FigureStochasticParameters

%% Figure 6
FigureStochasticVariance

%% New Figures added during the revision of the paper
FigureTraceVariance
FigureVarianceRuntime

