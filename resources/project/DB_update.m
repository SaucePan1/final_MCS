function [labels] = DBweighted_strat_update(b,c, w,n, graph, labels)
% Updates strategies
%


    %select vertex at random (this one dies)
    v = randi(n,1);

    %kill the vertex~
    temp = graph;
    temp(v,:) = zeros(1,n);
    temp(:,v) = zeros(n,1);
    
    %get fitness score of cooperators
    %get neighbours
    neigh = find(graph(v,:));
    %get fitness score of each neighbour 
    fit_neigh = zeros(1, length(neigh));
    for ng=neigh
       fit_neigh(ng) = get_fitness_weights(); %to do
    end
    
    %get probability of updating to cooperation
    w_c = graph(v,:).*labels; %get weights of cooperators
    fitness_C= w_c(neigh).*fit_neigh;  %proportional to strenght of the link and strenght of the strategy
    
    w_d = graph(v,:).*(~labels); %get weights of detractors
    fitness_D = w_d(neigh).*fit_neigh;
    
    
    
    

end
