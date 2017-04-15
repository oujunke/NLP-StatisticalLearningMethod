function [ table_out, pro] = forward_algorithm( A, B, pi, O)
  %%% 统计学习方法P177前向算法demo实现
  %%% 动态规划，递推公式已给，实现很简单
  %%% A: NxN, 为状态转移矩阵
  %%% B: NxM, 为观测概率矩阵
  %%% pi:Nx1, 为初始状态矩阵
  %%% O: 1xT, 为观测状态序列
  %%% pro=P(O|lambda)
  T = size(O,2);
  N = size(A,2);
  table = zeros(T,N);
  %%%计算初值
  o1 = O(1);
  for i=1:N
      table(1,i) = pi(i,1) * B(i,o1);
  end
  %%%递推计算
  for i=2:T
      oi = O(i);
      for j=1:N
          for k=1:N
              table(i,j) = table(i,j) + table(i-1,k) * A(k,j);
          end
          table(i,j) = table(i,j) * B(j,oi);
      end
  end
  table_out = table;
  pro = sum(table(T,:));
end
