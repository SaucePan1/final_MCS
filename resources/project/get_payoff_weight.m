function [u] = get_payoff_weight(b,c, w, v,labels, graph)
%gets average payoff of a vertex
% 

    k = length(find(graph(v,:))); %number of neighbours
    w_ben = sum(graph(v,:).*labels); %weighted benefits given by neigh cooperators
    node_str = sum(graph(v,:)); %in case of unweighted graph node_str = k

    if labels(v) && node_str >0
        %get fitness according to cooperation strategy
        u = 1/node_str*b*w_ben - c;
    elseif ~labels(v) && node_str >0
        %get fitness according to detraction strategy
        u = 1/node_str*b*w_ben;
    else 
        u=0;
    end
    
    %average_payoff = (1-w) + w*u;  %introduce weak selection
    
end

