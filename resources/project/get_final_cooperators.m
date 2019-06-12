function [p] = get_final_cooperators(b,c,w,Bs,Bw,dt,n,og_graph, T, max_runs)
%This function initialize labels at random at 50% probability then runs
%max_runs simulations for T steps and returns mean over runs of the percentage of cooperators
%in the graph at each time step.  



%prepare payoff matrix
payoff_matrix = [[0,b];[-c, b-c]];

%init labels with 1 cooperator
%labels = initLabels(1,n);

%get fraction of death in each time step
deaths = Bs*dt*n;

%to save fraction of cooperators at each time step
pi_c(max_runs,T)=0;

for run =1:max_runs
    %init labels for one coop and n-1 detractors (or viceversa if coop=0)
    labels = init_rand_labels(0.5,n);
    %init graph 
    graph = og_graph;

    %run T time steps
    tic
    for step =1:T
        % update strategy
        
        %get fraction of vertices to update synchronously
        %tot_vert is +1 if rand < decimal part 
        tot_vert = floor(deaths) + (rand < (deaths-floor(deaths))); %decimal part is random 
        labels = DBweighted_strat_update(b,c, w,n, tot_vert, graph, labels);
        %update weights 
        %calculate payoffs for each vertex
        u(n) = 0;   
        for i=1:n
            u(i) = get_payoff_weight(b,c, w, i,labels, graph);
        end
        graph = update_weights(b,c,w,n, payoff_matrix, u, Bw, dt, labels, graph);
        p(run,step) = sum(labels == 1);
    end
    toc
    run
end
%get the mean over all runs

end

