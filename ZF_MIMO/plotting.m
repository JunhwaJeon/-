close all; clear; clc;

P_db=0:4:40;

ZF_MIMO=load('ZR_MIMO_rate.mat').ergodic_rate;
load('Ergodic_rate.mat','ergodic_rate');
Beamforming_MIMO=ergodic_rate(3,:);


plot(P_db,Beamforming_MIMO,'g-'); hold on; grid on;
plot(P_db,ZF_MIMO,'b-');
title('Ergodic Rate');
legend('Beamforming 4x4MIMO','Zero-Forcing 4x4MIMO');
xlabel('Transmit SNR [dB]'); ylabel('Ergodic Rate [bps]');