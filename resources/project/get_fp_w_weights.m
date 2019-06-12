function [fp] = get_fp_w_weights(b,c,w,Bs,Bw,dt, n,og_graph)
%get fixation probability vector

%max runs is 10 times n since fp is 1/n
max_runs = 10*n;


%prepare payoff matrix
payoff_matrix = [[0,b];[-c, b-c]];

%init labels with 1 cooperator
%labels = initLabels(1,n);

%get fraction of death in each time step
deaths = Bs*dt*n;

%so we start with 1 cooperator and n-1 detractors
coop=1;
invaded_count =0;
for run =1:max_runs
    stop=0;
    count=0;
    %init labels for one coop and n-1 detractors (or viceversa if coop=0)
    labels = initLabels(coop,n);
    %init graph 
    graph = og_graph;
    
    count = 0;
    run
    while ~stop
        % update strategy
        count= count+1;
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
        
        all_c = all(labels); %returns 1 if all 1
        all_d = all(~labels);%returns 1 if all 0
        stop = or(all_c , all_d); %returns one if all 1 or all 0
        
    end
    invaded_count = invaded_count + coop*all_c + (~coop)*all_d; %increases if minority invaded
end

fp = invaded_count/max_runs;
end

