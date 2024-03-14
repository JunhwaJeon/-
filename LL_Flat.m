%% 인수
% Nt: 송신 안테나 개수
% Nr: 수신 안테나 개수
% D: Data block 개수
% Nd: Data block 길이
% Np: Pilot block 길이
% No: real/imaginary noise variance=No/sqrt(2)

%% 추가/수정 필요한 내용
% (송신측에서) 알고 있는 채널의 정보 필요할 듯

%% 목적
% Frequency Flat Channel (L=1) 에서 Likelihood Learning Method 통해 Channel Estimation 및 Detection

function LL_Flat(Nt, Nr, D, Nd, Np, No)
%% 첫 번째 과정: 신호 길이 내의 모든 i에 대해서
for i=1:2*Nr
% Pilot 신호로 LMMSE하여 H_hat구하고, p_(i,k)구함. H_hat, p_(i,k)를 이용하여 Epsilon_mod_(i,k)계산, 첫 번째 State information 영행렬로 initialize

    %% 두 번째 과정: D개의 데이터 블록 동안
    for d=1:D
    % 데이터 블록 내 n번째, 신호 종류 k번째에 대한 Posterior probability 계산, p_(i,k)를 이용하여 n번째 수신 신호에 대한 detected signal k_hat 계산

        %%세 번째 과정: 데이터 블록 내 n동안
        for n=1:Nd
        % p_hat_mod_(i,k)이용, v_hat_(i,k)계산하고, n번째 상태에 대한 optimal policy 계산

        % 계산된 optimal policy에 따라서 State information update

        %% 세 번째 루프 end
        end
    %연산된 마지막의 State information을

    %% 두 번재 루프 end
    end
%% 첫 번째 루프 end
end