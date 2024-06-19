close all; clear; clc;

%% Parameter Setting
P_db=0:4:40;
P=10.^(P_db/10);
iter=10^5;
sq=sqrt(1/2);
ergodic_rate=zeros(3,length(P));
N=4; % MIMO Scale

for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        H=sq*complex(randn(N),randn(N)); % channel generation
        A=normalize(inv(H),'norm'); % normalizing column vector of inverse channel matrix
        Z=H*A; % Zero-Forced channel
        for k=1:N
            rate_sum=rate_sum+log2(1+(norm(Z(k,k))^2)*P(j)/N);
        end
    end
    ergodic_rate(1,j)=rate_sum/iter;
end

for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        H=sq*complex(randn(N),randn(N)); % channel generation
        A=normalize(inv(H),'norm'); % normalizing column vector of inverse channel matrix
        Z=H*A; % Zero-Forced channel

        % waterfilling algorithm
        Sigma=0;
        for k=1:N
            Sigma=Sigma+1/(Z(k,k)^2); end
        
        mu=(P(j)+Sigma)/N;
        power_alloc=zeros(1,N);
        
        for k=1:N
            power_alloc(k)=max(mu-1/(Z(k,k)^2),0); end

        for k=1:N
            rate_sum=rate_sum+log2(1+(norm(Z(k,k))^2)*power_alloc(k));
        end
    end
    ergodic_rate(2,j)=rate_sum/iter;
end

for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        H=sq*complex(randn(N),randn(N)); % channel generation
        S=svd(H);

        % waterfilling algorithm
        Sigma=0;
        for k=1:N
            Sigma=Sigma+1/(S(k)^2); end
        
        mu=(P(j)+Sigma)/N;
        power_alloc=zeros(1,N);
        
        for k=1:N
            power_alloc(k)=max(mu-1/(S(k)^2),0); end

        A=normalize(inv(H),'norm'); % normalizing column vector of inverse channel matrix
        Z=H*A; % Zero-Forced channel
        for k=1:N
            rate_sum=rate_sum+log2(1+(norm(Z(k,k))^2)*power_alloc(k));
        end
    end
    ergodic_rate(3,j)=rate_sum/iter;
end

save("ZF_Waterfilling.mat","ergodic_rate");

plot(P_db,ergodic_rate(1,:),'g-'); hold on; grid on;
plot(P_db,ergodic_rate(2,:),'b-');
plot(P_db,ergodic_rate(3,:),'r-');

title('Ergodic Rate');
legend('Zero-Forcing 4x4MIMO')
xlabel('Transmit SNR [dB]'); ylabel('Ergodic Rate [bps]');
legend('ZF','ZF-Waterfilling','ZF-Waterfilling-SVD');