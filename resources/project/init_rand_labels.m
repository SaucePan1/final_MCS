function [labels] = init_rand_labels(p,n)
%p is prob of initial C
%

labels = zeros(1,n);

for i=1:n
    if rand < p
        labels(i) = 1;
    end
end
end

