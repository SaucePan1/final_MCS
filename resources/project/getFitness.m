function [score] = getFitness(b, c, w, graph,labels, v)
%this is tested for cycle 
%Gets fitness score of vertex, labels is label vector
% label 1/0  = cooperator/detractor
fprintf("for vertex")
v
fprintf("fitness is")

%get number of cooperators
n_c = sum(graph(v,:)*labels');
k = sum(graph(v,:)); % get number of neighbours
fitness = b*n_c - c*k*labels(v)
score = (1-w) + w*fitness;

end

