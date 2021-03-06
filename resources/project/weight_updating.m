%model parameters
max_runs = 10*n;
n= 10 %number of vertices
b=5
c=0.2
w = 0.01 %strength of fitness score 
Bs = 5; %rate of strategy update
Bw = 5; %rate of weigth update 
dt=0.01;
%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;

graph = cycle; %we rename it since in 
%the future we will try different tiypes of graphs

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
    graph = cycle;
    
    count = 0;
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
    invaded_count = invaded_count + coop*all_c + (~coop)*all_d %increases if minority invaded
end

fp = invaded_count/max_runs;


