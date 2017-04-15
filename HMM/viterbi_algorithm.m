function [ Pro_table_out, pro, I] = viterbi_algorithm( A, B, pi, O)
    %%%《统计学习方法》P186, 维特比算法demo实现
    T = size(O,2);
    N = size(A,2);
    Pro_table = zeros(T,N);
    Track_table = zeros(T,N);
    %%%计算初值
    o1 = O(1);
    for i=1:N
        Pro_table(1,i) = pi(i,1) * B(i,o1);
        Track_table(1,i) = 0;
    end
    %%%递推计算
    for t=2:T
        oi = O(t);
        for i=1:N
            max_tmp = 0;
            max_index = 0;
            for j=1:N
                tmp = Pro_table(t-1,j) * A(j,i);
                if tmp > max_tmp
                    max_tmp = tmp;
                    max_index = j;
                end
            end
            Pro_table(t,i) = max_tmp * B(i,oi);
            Track_table(t,i) = max_index;
        end
    end
    I = zeros(1,T);
    for t=T-1:-1:1
        [~, i_t_plus_1] = max(Pro_table(t+1,:));
        I(t) = Track_table(t+1,i_t_plus_1);
    end
    [pro, i_T] = max(Pro_table(T,:));
    I(T) = i_T;
    Pro_table_out = Pro_table;
end
