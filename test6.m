clc
clear all
close all


load a1;
b=a1(1:50,1:12);
I=b';
O=a1(1:50,13)';
a=b';
for ii=1:1:12
    val= findminmax(a(ii,1:50));
    RS(ii,1)=val(1,1);
    RS(ii,2)=val(1,2);
end
S=[12 10 1];
[trainV, valV, testV] = dividevec(a, O, 0.10, 0.10);

net = newff(RS,S,{'tansig','tansig','purelin'});


net.trainParam.epochs = 500;
% net = train(net, trainV.P, trainV.T, [], [], valV); % train network
[net tr]=train(net,I,O);

Opt2=sim(net,I(1:12,2))

for ii=1:50
    Opt(ii)=(sim(net,I(1:12,ii)));
end


mse_error1=calc_mse(Opt,O);
% input_weights=net.IW;
% new_weights=input_weights{1,1};

% Opt1 = double(uint64(Opt2));
% if Opt1 ~= 1
%     for it=1:5
    net=apply_ga(net,Opt,O);
    net.trainParam.epochs = 50;

    [net tr]=train(net,I,O);
    for ii=1:50
        Optga(ii)=(sim(net,I(1:12,ii)));
    end
    
%     Opt3=(sim(net,I(1:12,2)))

%     end
% end
mse_error2=calc_mse(Optga,O);


% Opt3=round(sim(net,I(1:12,2)))
% Opt3=(sim(net,I(1:12,2)))

figure;
plot(mse_error1,'-k.');
hold on
plot(mse_error2,'-r*');
legend('error befor ga','error after ga')

