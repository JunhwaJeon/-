close all; clear; clc;

%% AWGN data load
BP_awgn=load("BPSK_AWGN.mat").BP_awgn;
QP_awgn=load("QPSK_AWGN.mat").QP_awgn;
P8_awgn=load("8_PSK_AWGN.mat").P8_awgn;
Q16_awgn=load("16QAM_AWGN.mat").Q16_awgn;
Q64_awgn=load("64QAM_AWGN.mat").Q64_awgn;

%% Parameter Setting
Throughput=[BP_awgn; QP_awgn; P8_awgn; Q16_awgn; Q64_awgn];
P_db=0:0.1:30;
P=10.^(P_db./10);

%% Obtain SNR information
channel_info=sqrt(1/2)*(randn()+1j*randn())*sqrt(P);
SNR=norm(channel_info)^2;