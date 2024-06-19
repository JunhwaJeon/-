close all; clear; clc;

%% Parameter Setting
P_db=0:4:40;
P=10.^(P_db/10);
iter=10^5;
sq=sqrt(1/2);
RZF_ergodic_rate=zeros(1,length(P));
N=4; % MIMO Scale

for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        H=sq*complex(randn(N),randn(N)); % channel generation
        W=ctranspose(H)*inv(H*ctranspose(H)+(4/P(j))*eye(N));
        A=normalize(W,'norm'); % normalizing column vector of inverse channel matrix
        Z=H*A; % Regularized Zero-Forced channel
        S=svd(Z);

        % waterfilling algorithm
        Sigma=0;
        for k=1:N
            Sigma=Sigma+1/(S(k)^2); end
        
        mu=(P(j)+Sigma)/N;
        power_alloc=zeros(1,N);
        
        for k=1:N
            power_alloc(k)=max(mu-1/(S(k)^2),0); end
    
        for k=1:N
            P_int=0;
            for l=1:N
                if l~=k
                    P_int=P_int+(norm(Z(k,l))^2)*power_alloc(l);
                end
            end
            rate_sum=rate_sum+log2(1+(norm(Z(k,k))^2)*power_alloc(k)/(1+P_int));
        end
    end
    RZF_ergodic_rate(j)=rate_sum/iter;
end

ZF_svdWaterfill_ergodic_rate=load('ZF_Waterfilling.mat').ergodic_rate(3,:);
original_ZF=load('ZF_Waterfilling.mat').ergodic_rate(1,:);

plot(P_db,ZF_svdWaterfill_ergodic_rate,'b-'); hold on; grid on;
plot(P_db,RZF_ergodic_rate,'r-');
plot(P_db,original_ZF,'g--');

title('Ergodic Rate');
legend('Zero-Forcing 4x4MIMO')
xlabel('Transmit SNR [dB]'); ylabel('Ergodic Rate [bps]');
legend('ZF-Waterfilling-SVD','Regularized-ZF','Inversion-ZF');