%model parameters
max_runs = 100;
n= 10 %number of vertices
b=1
c=0.2
w = 0.01 %strength of fitness score 
Bs = 1; %rate of strategy update
Bw = 10; %rate of weigth update 
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
labels = [1,0,1,0,1,0,0,1,0,1];

%get fraction of death in each time step
deaths = Bs*dt*n;

for run =1:max_runs
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
end
