close all; clear; clc;

AMC_throughput=load('Rayleigh_AMC.mat');
Throughput=load("Rayleigh_Coherent.mat");
Rayleigh=[Throughput.BP_rayleigh; Throughput.QP_rayleigh; ...
    Throughput.P8_rayleigh; Throughput.Q16_rayleigh; Throughput.Q64_rayleigh];

P_db=0:0.1:30;
plot(P_db,Throughput.BP_rayleigh,':r'); hold on; grid on;
plot(P_db,Throughput.QP_rayleigh,':g');
plot(P_db,Throughput.P8_rayleigh,':m');
plot(P_db,Throughput.Q16_rayleigh,':y');
plot(P_db,Throughput.Q64_rayleigh,':c');
P_db=0:1:30;
plot(P_db,AMC_throughput.Throughput,'-b')