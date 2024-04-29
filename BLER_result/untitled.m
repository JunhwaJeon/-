close all; clear; clc;

P_db=0:2:20;

% AWGN Plotting
plot(P_db,BLER(20,'BPSK','AWGN','Rayleigh_coherent'),'-or'); grid on; hold on;
plot(P_db,BLER(20,'QPSK','AWGN','Rayleigh_coherent'),'-og');
plot(P_db,BLER(20,'8-PSK','AWGN','Rayleigh_coherent'),'-ob');
plot(P_db,BLER(20,'16-QAM','AWGN','Rayleigh_coherent'),'-om');

title('Signal Power vs. Throughput (Block length=20, Coherent detection)');
legend('BPSK-Rayleigh','QPSK-Rayleigh','8-PSK-Rayleigh','16-QAM-Rayleigh');
xlabel('Signal Power [dB]'); ylabel('Throughput [bps]');