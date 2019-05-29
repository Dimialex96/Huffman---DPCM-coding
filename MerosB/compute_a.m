function [a] = compute_a(q,p,m)
%initialize workspace
%first_sum,second_sum,autocorrelation_vector,autocorrelation_matrix
s_1 = zeros(p,1);
s_2 = zeros(p,p);
r = zeros(p,1);
R = zeros(p,p);
for i = 1:p
    for n = (p + 1):m                 %for-loop to compute first sum
        s_1(i)=s_1(i)+q(n)*q(n-i);
    end
    r(i)=(1/(m - p))*s_1(i);          %compute autocorrelation vector using first sum
end
for i = 1:p
    for j = 1:p
        for n = (p + 1):m
            s_2(i, j)=s_2(i, j)+q(n - j)*q(n - i);
        end
        R(i, j)=(1/(m - p))*s_2(i, j);%compute autocorrelation matrix using second sum
    end
end
a=R\r;                                %compute a
end