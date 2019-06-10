function [graph] = update_weights(b,c,w,payoff_matrix, u, rate_w, labels, graph)
% Updates weights of graph according to benefits recieved

v = sum(graph);
w_average_u = v*u / sum(v);
for i =1:n
    for j =1:(i-1)
        delta_ij = (payoff_matrix(labels(i), labels(j)) - u(i))*graph(i,j)/w_average_u;s
        delta_ji = (payoff_matrix(labels(j), labels(i)) - u(j))*graph(j,i)/w_average_u;
        
        w_ij = graph(i,j) +(delta_ij + delta_ji)*rate_w;
        graph(i,j) = max(0, w_ij);
        graph(j,i)= graph(i,j);
    end
end

end

