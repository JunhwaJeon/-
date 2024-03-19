close all
clear all
clc

iter=10^6; % number of iterations
P_db=0:2:20; % power in decibel
P=10.^(P_db./10); % power in linear

for mod_case=1:3
    if mod_case==1 % QPSK case
        SER=zeors(mod_case,length(P));
        for j=1:length(P)
            err=0;
            for i=1:iter
                x=randi(4)
            end
        end
    elseif mod_case==2 % 8-PSK case
        SER=zeros(mod_case,length(P));
    else % 16-QAM case
        SER=zeros(mod_case,length(P));
    end
end
   