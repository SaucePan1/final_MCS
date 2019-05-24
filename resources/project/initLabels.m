function [labels] = initLabels(p, n)
% initializes labels with prob of Cooperator = p


labels = zeros(1,n);
for i=1:n
    labels(i) = labels(i) + (rand < p);
end

end

