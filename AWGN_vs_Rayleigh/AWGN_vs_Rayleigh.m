close all; clear; clc;

Bpsk=load("BPSK_AWGN.mat").BP_awgn;
Qpsk=load("QPSK_AWGN.mat").QP_awgn;
Eight_psk=load("8_PSK_AWGN.mat").P8_awgn;
Sixteen_qam=load("16QAM_AWGN.mat").Q16_awgn;
Sixtyfour_qam=load("64QAM_AWGN.mat").Q64_awgn;
Throughput=load("Rayleigh_Coherent.mat");

awgn=[Bpsk; Qpsk; Eight_psk; Sixteen_qam; Sixtyfour_qam;];
Rayleigh=[Throughput.BP_rayleigh; Throughput.QP_rayleigh; ...
    Throughput.P8_rayleigh; Throughput.Q16_rayleigh; Throughput.Q64_rayleigh];

P_db=0:0.1:30;

plot(P_db,awgn(1,:),'--ro', 'MarkerIndices',1:20:length(P_db)); hold on; grid on;
plot(P_db,awgn(2,:),'--go', 'MarkerIndices',1:20:length(P_db));
plot(P_db,awgn(3,:),'--mo', 'MarkerIndices',1:20:length(P_db));
plot(P_db,awgn(4,:),'--yo', 'MarkerIndices',1:20:length(P_db));
plot(P_db,awgn(5,:),'--co', 'MarkerIndices',1:20:length(P_db));

plot(P_db,Rayleigh(1,:),'-rx', 'MarkerIndices',1:20:length(P_db));
plot(P_db,Rayleigh(2,:),'-gx', 'MarkerIndices',1:20:length(P_db));
plot(P_db,Rayleigh(3,:),'-mx', 'MarkerIndices',1:20:length(P_db));
plot(P_db,Rayleigh(4,:),'-yx', 'MarkerIndices',1:20:length(P_db));
plot(P_db,Rayleigh(5,:),'-cx', 'MarkerIndices',1:20:length(P_db));

title("AWGN vs Rayleigh Datarate (Block Length=20)")
xlabel("Signal Power [dB]");
ylabel("Throughput [bps]");
legend("BPSK-AWGN", "QPSK-AWGN","8-PSK-AWGN","16-QAM-AWGN","64-QAM-AWGN",...
    "BPSK-Rayleigh", "QPSK-Rayleigh","8-PSK-Rayleigh","16-QAM-Rayleigh","64-QAM-Rayleigh")