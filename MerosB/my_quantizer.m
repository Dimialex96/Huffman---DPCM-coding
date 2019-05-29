function [quant] = my_quantizer(x,N,min_value,max_value)
if ( x < min_value )                    %if statement for x < min then x = min and quant as min
    x = min_value;
end
if (x > max_value )                     %if statement for x > max then x = max and quant as max
    x = max_value;
end
levels = 2^N;
delta = (max_value - min_value)/levels; %delta distance = max - min value divided by number of levels
centers = zeros(levels,1);              %initialize centers vector
centers(1) = max_value-delta/2;         %calculate of first center (top)
for i=2:levels
    centers(i) = centers(i-1) - delta;  %for-loop for second and on center, every center is - delta from the previous
end
for i=1:levels                          %for-loop to quant every signal according to centers
    if ((x <= max_value-(i-1)*delta) && (x >= max_value-i*delta)) %if statement to check region of x
        quant = centers(i);             %return quant vector
    end
end
end