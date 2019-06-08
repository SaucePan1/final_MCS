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
       fit_neigh(ng) = get_payoff_weight(b,c, w, v,labels, graph);
    end
    
    %get probability of updating to cooperation
    w_c = graph(v,:).*labels; %get weights of cooperators
    fitness_C= sum(w_c(neigh).*fit_neigh);  %proportional to strenght of the link and strenght of the strategy
    
    w_d = graph(v,:).*(~labels); %get weights of detractors
    fitness_D = sum(w_d(neigh).*fit_neigh);
    
    prob_C = fitness_C/(fitness_D+fitness_C);
    
    if rand <prob_C
        %v updates to cooperation
        labels(v) = 1;
    else
        %v updates to detraction
        labels(v) = 0;
    end
    
    
    
    
    

end
