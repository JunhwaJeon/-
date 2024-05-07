%% Rayleigh Channel에서 Convolution Code 적용시 
% 각 modulation에서의 throughput
% AMC 적용했을 때의 throughput plotting

close all; clear; clc;

% 각 modulation에서의 throughput data load
Throughput=load('Conv_code_Rayleigh_original.mat').Throughput;

% AMC 적용시 throughput data load
Throughput_AMC=load('Conv_code_Rayleigh_AMC.mat').Throughput;

P_db=0:1:30;
plot(P_db,Throughput(1,:),':r','LineWidth',2); hold on; grid on;
plot(P_db,Throughput(2,:),':g','LineWidth',2);
plot(P_db,Throughput(3,:),':m','LineWidth',2);
plot(P_db,Throughput(4,:),':y','LineWidth',2);
plot(P_db,Throughput(5,:),':c','LineWidth',2);
plot(P_db,Throughput_AMC,'-b','LineWidth',3);

title('Signal Power vs Throughput [Block length=20, Rayleigh Channel, Code rate=1/2]');
xlabel('Signal Power [dB]');
ylabel('Throughput [bps]');
legend('BPSK','QPSK','8-PSK','16-QAM','64-QAM','AMC');