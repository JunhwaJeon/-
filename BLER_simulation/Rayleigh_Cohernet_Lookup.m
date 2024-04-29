close all;clear; clc;
%% Rayleigh fading & Coherent Detection Lookup Table
BP_rayleigh=BLER(20,'BPSK','Rayleigh','Rayleigh_coherent');

QP_rayleigh=BLER(20,'QPSK','Rayleigh','Rayleigh_coherent');

P8_rayleigh=BLER(20,'8-PSK','Rayleigh','Rayleigh_coherent');

Q16_rayleigh=BLER(20,'16-QAM','Rayleigh','Rayleigh_coherent');

Q64_rayleigh=BLER(20,'64-QAM','Rayleigh','Rayleigh_coherent');

save("Rayleigh_Coherent.mat")