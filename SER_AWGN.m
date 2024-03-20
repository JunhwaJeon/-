close all; clear; clc

iter=10^6; % number of iterations
P_db=0:2:20; % power in decibel
P=10.^(P_db./10); % power in linear
SER=zeros(3,length(P)); % SER information

for mod_case=1:3
    %% QPSK case
    if mod_case==1 
        % QPSK Constellation
        x(1)=(1+1j)/sqrt(2); x(3)=(-1-1j)/sqrt(2); x(2)=conj(x(3)); x(4)=conj(x(1));
        
        for j=1:length(P)
            err=0;
            for i=1:iter
                n=(randn()+1j*randn())/sqrt(2); % Compex Gaussian Noise
                dist=zeros(length(x)); % 거리 정보 담을 리스트
                s=randi(4); % Signal Index Number
                y=x(s)*sqrt(P(j))+n; % Received Signal
                for k=1:length(x)
                    dist(k)=abs(y-x(k)*sqrt(P(j)));
                end
                [m,l]=min(dist);
                if l~=s
                    err=err+1; 
                end
            end
            SER(mod_case,j)=err/iter;
        end
    %% 8-PSK case
    elseif mod_case==2
        % 8-PSK Constellation
        x(1)=(1+1j)/sqrt(2); x(5)=(-1-1j)/sqrt(2); x(3)=conj(x(5)); x(7)=conj(x(1)); 
        x(2)=1j; x(4)=-1; x(6)=-1j; x(8)=1;

        for j=1:length(P)
            err=0;
            for i=1:iter
                n=(randn()+1j*randn())/sqrt(2); % Compex Gaussian Noise
                dist=zeros(length(x)); % 거리 정보 담을 리스트
                s=randi(8); % Signal Index Number
                y=x(s).*sqrt(P(j))+n; % Received Signal
                for k=1:length(x)
                    dist(k)=abs(y-x(k)*sqrt(P(j)));
                end
                [m,l]=min(dist);
                if l~=s
                    err=err+1; 
                end
            end
            SER(mod_case,j)=err/iter;
        end
    %% 16-QAM case
    else 
        % 16-QAM Constellation
        x(1)=sqrt(1/10)*(1+1j); x(2)=sqrt(1/10)*(3+1j); x(3)=sqrt(1/10)*(3+3j); x(4)=sqrt(1/10)*(1+3j);
        x(5)=sqrt(1/10)*(-1+1j); x(6)=sqrt(1/10)*(-3+1j); x(7)=sqrt(1/10)*(-3+3j); x(8)=sqrt(1/10)*(-1+3j);
        x(9)=conj(x(5)); x(10)=conj(x(6)); x(11)=conj(x(7)); x(12)=conj(x(8));
        x(13)=conj(x(1)); x(14)=conj(x(2)); x(15)=conj(x(3)); x(16)=conj(x(4));

        for j=1:length(P)
            err=0;
            for i=1:iter
                n=(randn()+1j*randn())/sqrt(2); % Compex Gaussian Noise
                dist=zeros(length(x)); % 거리 정보 담을 리스트
                s=randi(16); % Signal Index Number
                y=x(s).*sqrt(P(j))+n; % Received Signal
                for k=1:length(x)
                    dist(k)=norm(y-x(k)*sqrt(P(j)));
                end
                [m,l]=min(dist);
                if l~=s
                    err=err+1; 
                end
            end
            SER(mod_case,j)=err/iter;
        end
    end
end

%% Plotting
semilogy(P_db,SER(1,:),'r-'); hold on; grid on;
semilogy(P_db,SER(2,:),'g-');
semilogy(P_db,SER(3,:),'b-');
xlabel('Signal Power [dB]'); ylabel('Symbol Error Rate');
title('Signal Power vs. SER')
legend('QPSK','8-PSK','16-QAM');
   