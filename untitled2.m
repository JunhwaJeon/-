close all; clear; clc;

P_db=0:2:20;

% AWGN Plotting
plot(P_db,BLER(20,'BPSK','AWGN'),'-or'); grid on; hold on;
plot(P_db,BLER(20,'QPSK','AWGN'),'-og');
plot(P_db,BLER(20,'8-PSK','AWGN'),'-ob');
plot(P_db,BLER(20,'16-QAM','AWGN'),'-om');

% Rayleigh Plotting
plot(P_db,BLER(20,'BPSK','Rayleigh'),'-xr');
plot(P_db,BLER(20,'QPSK','Rayleigh'),'-xg');
plot(P_db,BLER(20,'8-PSK','Rayleigh'),'-xb');
plot(P_db,BLER(20,'16-QAM','Rayleigh'),'-xm');

title('Signal Power vs. Throughput (Block length=20)');
legend('BPSK-AWGN','QPSK-AWGN','8-PSK-AWGN','16-QAM-AWGN'...
    ,'BPSK-Rayleigh','QPSK-Rayleigh','8-PSK-Rayleigh','16-QAM-Rayleigh');
xlabel('Signal Power [dB]'); ylabel('Throughput [bps]');