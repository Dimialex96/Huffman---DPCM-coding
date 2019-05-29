clear;
clc;
load source.mat;
n = length(x);
min_value = -3.5;
max_value = 3.5;
quant = zeros(n,1);                       %initialize workspace
pred = zeros(n,1);
MSE = zeros(5,3);
reconst = zeros(n,1);
for N = 1:3
    disp(['N=',num2str(N)])
    for p = 4:8
        a_quant = zeros(p,1);
        a_pred = compute_a(x,p,n);        %compute values of contributor a based on p previous values of signal x
        for i = 1:p                       %for-loop to quant every value of contributor a
            a_quant(i) = my_quantizer(a_pred(i),8,-2,2);
        end
        for i = (p+1):n                   %for-loop to quant the difference of initial signal x and its prediction and reconstruct
            for j = 1:p                   %for-loop to compute prediction using the quant contributors a
                pred(i) = pred(i) + a_quant(j) * x(i - j);
            end
            quant(i) = my_quantizer(x(i)-pred(i),N,min_value,max_value);
            reconst(i) = (pred(i) + quant(i))/14.45;%final reconstructed signal using predicted and its quant difference
        end
        disp(['p=',num2str(p)])           %display various values of contributor a
        disp(a_quant)
        MSE(p-3,N) = immse(x,pred/14.45); %mean squared error between x and its prediction
        if ( p==6 || p==8 )               %if statement to plot two random p e.g. p=6 & p=8
            figure                        %initial signal x and prediction error
            plot(1:10000,x,1:10000,quant)
            legend('x','error')
            title(['N=',num2str(N),' p=',num2str(p)])
        end
        if ( p == 4 || p == 8 )           %if statement to plot only p=4 & p=8
            figure
            subplot(2,1,1)
            plot(100:150,x(100:150),100:150,reconst(100:150))
            legend('x','Reconstructed')
            title(['N=',num2str(N),' p=',num2str(p)])
            subplot(2,1,2)
            plot(1:10000,x(1:10000),1:10000,reconst(1:10000))
            legend('x','Reconstructed')
            title(['N=',num2str(N),' p=',num2str(p)])
        end
    end
end
figure                                    %plot mean squared error
plot(1:3,MSE,'-d')
legend('p=4','p=5','p=6','p=7','p=8')
title('Mean Squared Error')
