%% input symbol 을 Transmit 했을때 출력
function output=Transmit(input,chan_type)
switch chan_type
    case chan_type=='AWGN' | chan_type=='awgn'
        output=input+sqrt(1/2)*(randn()+1j*randn());
    case chan_type=='Rayleigh'
        output=sqrt(1/2)*(randn()+1j*randn())*input+sqrt(1/2)*(randn()+1j*randn());
end
end