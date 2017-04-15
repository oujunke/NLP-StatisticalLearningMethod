function [ w_out, b_out, sum_loss_out ] = batch_sgd(X, y, w, b, lr, sum_loss)
  %% 线性回归模型： y = X*w + b
  %% X: mxn,为输入样本矩阵，其中，m为样本个数，n为样本特征维度
  %% y: mX1, 为样本标签
  %% w: nx1, 为线性回归函数系数
  %% b: 1x1, 为线性回归函数bias
  %% lr:标量，为批量梯度下降学习率
  %% sum_loss, 记录每一步迭待损失函数
  iter_n = size(sum_loss, 2);
  [N_samples, x_num] = size(X);
  loss = (X * w + b - y);
  LeastSquares_loss = sum(loss.^2) / (2 * N_samples);
  sum_loss(iter_n + 1) = LeastSquares_loss;
  fprintf('第%d次迭代: LeastSquares_loss=%f\n',iter_n + 1, LeastSquares_loss)
  %%计算提梯度%%%%%
  res = zeros(1,x_num);
  for i=1:N_samples
      res = res + X(i,:) * loss(i);
  end
  w_out = w - lr * res' / N_samples;
  b_out = b - lr * sum(loss) / N_samples;
  sum_loss_out = sum_loss;
end
