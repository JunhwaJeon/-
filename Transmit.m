%% input symbol 을 Transmit 했을때 출력
function output=Transmit(input,chan_type,sig_power_linear)
switch chan_type
    case {'AWGN','awgn'}
        output=sqrt(sig_power_linear)*input+sqrt(1/2)*(randn()+1j*randn());
    case 'Rayleigh'
        output=sqrt(1/2)*(randn()+1j*randn())*sqrt(sig_power_linear)*input+sqrt(1/2)*(randn()+1j*randn());
end
end