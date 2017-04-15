%%%准备数据
clear;clc
x_data = (1:100)';
y_data = 3 * x_data + 5 + randn(100,1);
% plot(x_data, y_data)
w =2;
b=4;
sum_loss=[];
epoch = 10000;
for i=1:epoch
    %%%步长对结果影响非常大
    [w,b,sum_loss] = batch_sgd(x_data,y_data,w,b,.0001,sum_loss);
end
plot(sum_loss(epoch-1000:end))
xlabel('epoch','FontSize',14)
ylabel('loss','FontSize',14)
title('损失函数变化曲线','FontSize',14)
