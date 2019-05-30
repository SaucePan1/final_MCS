%model parameters
n= 100 %number of vertices
b=1
c=0.2
w = 0.1 %strength of fitness score 


%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;

graph = cycle; %we rename it since in 
%the future we will try different tiypes of graphs

%create label vector 1 is Cooperator 0 is Detractor
%init labels with one cooperator
labels = initLabels(1,n);

max_runs = 10*n;

%fix prob vector
n_bvalues = 20;
fix_prob_coop = zeros(1,n_bvalues);



invaded_count = 0;
for run = 1:max_runs
    stop = 0;
    count=0;
    
    %init labels for one D 
    labels = initLabels(1,n); %change 1 to 0 for detractors
 
    
    while ~stop
        count = count +1;
        labels = DB_sim(b,c,w, n, graph, labels);
        all_c = all(labels); %returns 1 if all 1
        all_d = all(~labels);%returns 1 if all 0
        invaded_count = invaded_count + all_c;
        stop = or(all_c , all_d); %returns one if all 1 or all 0
    end
    run
end

fixation_prob = invaded_count/max_runs;