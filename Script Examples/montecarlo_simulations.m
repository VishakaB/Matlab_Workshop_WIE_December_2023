% MIMO Outage Probability Analysis with Monte Carlo Simulation
close all;
clear all;
clc;

% Seed for reproducibility
seedvalue = 0;
rng(seedvalue);

% Initialization
mT = 2;               % Number of transmit antennas
mR = 3;               % Number of receive antennas
N = 100;              % Number of random channel realizations
SNRdB = 1:25;         % SNR range in dB
SNR = 10.^(SNRdB/10);  % Convert SNR from dB to linear scale
rateth = 5;           % Threshold data rate (in bits/sec)
maxmonte_iterations = 100;

% Initialize variables for outage probabilities
avg_p_outage_SISO = zeros(maxmonte_iterations, length(SNR));
avg_p_outage_SIMO = zeros(maxmonte_iterations, length(SNR));
avg_p_outage_MISO = zeros(maxmonte_iterations, length(SNR));
avg_p_outage_MIMO = zeros(maxmonte_iterations, length(SNR));

% Monte Carlo simulations
for montid = 1:maxmonte_iterations
    for snr_idx = 1:length(SNR)
        % Initialize outage arrays
        outage_SISO = zeros(1, N);
        outage_SIMO = zeros(1, N);
        outage_MISO = zeros(1, N);
        outage_MIMO = zeros(1, N);
        
        % Generate random channel matrices for each configuration
        H_SISO = (randn + 1i * randn) / sqrt(2);
        H_SIMO = (randn(mR, 1) + 1i * randn(mR, 1)) / sqrt(2);
        H_MISO = (randn(1, mT) + 1i * randn(1, mT)) / sqrt(2);
        H_MIMO = (randn(mR, mT) + 1i * randn(mR, mT)) / sqrt(2);
        
        % Calculate the capacity for each configuration
        C_SISO = log2(1 + SNR(snr_idx) * abs(H_SISO).^2);
        C_SIMO = sum(log2(1 + SNR(snr_idx) * abs(H_SIMO).^2));
        C_MISO = log2(1 + SNR(snr_idx) * sum(abs(H_MISO).^2) / mT);
        C_MIMO = log2(abs(det(eye(size(H_MIMO, 1)) + SNR(snr_idx) * (H_MIMO * H_MIMO') / mT)));
        
        % Check for outage and update probabilities
        outage_SISO = (C_SISO < rateth);
        outage_SIMO = (C_SIMO < rateth);
        outage_MISO = (C_MISO < rateth);
        outage_MIMO = (C_MIMO < rateth);
        
        % Store outage probabilities
        avg_p_outage_SISO(montid, snr_idx) = mean(outage_SISO);
        avg_p_outage_SIMO(montid, snr_idx) = mean(outage_SIMO);
        avg_p_outage_MISO(montid, snr_idx) = mean(outage_MISO);
        avg_p_outage_MIMO(montid, snr_idx) = mean(outage_MIMO);
    end
end

% Calculate mean and standard deviation over Monte Carlo iterations
mean_outage_SISO = mean(avg_p_outage_SISO, 1);
mean_outage_SIMO = mean(avg_p_outage_SIMO, 1);
mean_outage_MISO = mean(avg_p_outage_MISO, 1);
mean_outage_MIMO = mean(avg_p_outage_MIMO, 1);

% Plot the results with error bars
figure;
plot(SNRdB, mean_outage_SISO, 'r','LineWidth', 2);
hold on;
plot(SNRdB, mean_outage_SIMO, 'b--','LineWidth', 2);
plot(SNRdB, mean_outage_MISO, 'k-','LineWidth', 2);
plot(SNRdB, mean_outage_MIMO, 'g-','LineWidth', 2);

legend('SISO', 'SIMO', 'MISO', 'MIMO');
xlabel('SNR (dB)');
ylabel('Outage Probability');
xlim([min(SNRdB), max(SNRdB)]);
title('Outage Probability vs. SNR with Monte Carlo Simulation');
grid on;
