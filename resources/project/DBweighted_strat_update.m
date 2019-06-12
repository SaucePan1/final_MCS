function [labels] = DBweighted_strat_update(b,c, w,n,tot_vert, graph, labels)
% Update labels for one time step
%b c w, n model parameters
%tot_vert is number of vertices to update
%   

    
    %select k vertices at random no replacement (this ones die) 
    vertices = randperm(n,tot_vert);
    labels_hat = labels; %copy labels so its synchronus updating
     for v=vertices
        %kill the vertex~
        temp = graph;
        temp(v,:) = zeros(1,n);
        temp(:,v) = zeros(n,1);

        %get fitness score of cooperators
        %get neighbours
        neigh = find(graph(v,:));
        %get fitness score of each neighbour 
        fit_neigh = 0; %init to 0 
        for ng=1:length(neigh)
           %apply weak selection
           fit_neigh(ng) = (1-w) + w*get_payoff_weight(b,c, w, neigh(ng),labels, graph);
        end

        %get probability of updating to cooperation
        w_c = graph(v,:).*labels; %get weights of cooperators
        fitness_C= sum(w_c(neigh).*fit_neigh);  %proportional to strenght of the link and strenght of the strategy

        w_d = graph(v,:).*(~labels); %get weights of detractors
        fitness_D = sum(w_d(neigh).*fit_neigh);

        prob_C = fitness_C/(fitness_D+fitness_C);


        if rand <prob_C
            %v updates to cooperation
            labels_hat(v) = 1;

        else
            %v updates to detraction
            labels_hat(v) = 0;
        end
        
     end
    
    labels=labels_hat;
    

end
