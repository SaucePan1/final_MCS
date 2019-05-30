function [labels] = DB_sim(b,c, w,n, graph, labels)
% Does one run of the simulation 
%
    %select vertex at random (this one dies)
    v = randi(n,1);

    %get neighbours that cooperate
    neig_c = find(graph(v,:).*labels);
    %get detractors
    neig_d = find(graph(v,:).*(~labels));

    %kill the vertex~
    temp = graph;
    temp(v,:) = zeros(1,n);
    temp(:,v) = zeros(n,1);

    c_score = 0;
    d_score = 0;
    
    %get fitness score for cooperators
    for nc =neig_c
        fitness = getFitness(b, c,w, temp, labels, nc);
        c_score = c_score + fitness;
    end
    %get fitness score for detractors

    for nd =neig_d
        fitness = getFitness(b, c, w, temp, labels, nd);
        d_score = d_score + fitness;
    end
    
    p_c = c_score/(c_score + d_score);
    p_d = d_score/(c_score + d_score);
    %birth according to probs
    if rand < p_c
        %becomes a cooperator
        labels(v) = 1;
    else
        %becomes detractor
        labels(v) = 0;
    end
 

end

