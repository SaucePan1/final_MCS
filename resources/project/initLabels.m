function [labels] = initLabels(c, n)
% initializes labels with one cooperator or one detractor.
%c = 1 one cooperator , c = 0 we initialize with one detractor

index = randi(n,1);

if c
    %all detractors but one cooperator
    labels = zeros(1,n);
    labels(index) = 1;
else
    %all cooperators but one detractor
    labels = ones(1,n);
    labels(index) = 0;
end

end

