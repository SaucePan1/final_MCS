function [labels] = DBweighted_strat_update(b,c, w,n, graph, labels)

% Update strategies
%   

    
    %select vertex at random (this one dies)
    labels
    v = randi(n,1)

    %kill the vertex~
    temp = graph;
    temp(v,:) = zeros(1,n);
    temp(:,v) = zeros(n,1);
    
    %get fitness score of cooperators
    %get neighbours
    neigh = find(graph(v,:));
    %get fitness score of each neighbour 
    for ng=1:length(neigh)
       %apply weak selection
       fit_neigh(ng) = (1-w) + w*get_payoff_weight(b,c, w, neigh(ng),labels, graph);
    end
    
    %get probability of updating to cooperation
    w_c = graph(v,:).*labels; %get weights of cooperators
    fitness_C= sum(w_c(neigh).*fit_neigh)  %proportional to strenght of the link and strenght of the strategy
    
    w_d = graph(v,:).*(~labels); %get weights of detractors
    fitness_D = sum(w_d(neigh).*fit_neigh)
    
    prob_C = fitness_C/(fitness_D+fitness_C)
    
    
    if rand <prob_C
        %v updates to cooperation
        labels(v) = 1;
        
    else
        %v updates to detraction
        labels(v) = 0;
    end
    
    labels
    
    

end
