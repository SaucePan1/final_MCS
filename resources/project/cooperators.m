%model parameters
n= 5 %number of vertices
b=1
c=0.2
w = 0.1 %strength of fitness score 

%meta parameters
max_reps = 5;
p = 0.5; %prob of initial dist of cooperators

%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;

graph = cycle; %we rename it since in 
%the future we will try different tiypes of graphs

%create label vector 1 is Cooperator 0 is Detractor
%labels = initLabels(p, n);

labels = [0,0,1,1,0]
% algorithm

for i =1:max_reps
    og_labels = labels;
    %select vertex at random (this one dies)
    v = randi(n,1)

    %get neighbours that cooperate
    neig_c = find(graph(v,:).*labels)
    %get detractors
    neig_d = find(graph(v,:).*(~labels))

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

    c_score
    d_score
    p_c = c_score/(c_score + d_score)
    p_d = d_score/(c_score + d_score)

    %birth according to probs
    if rand < p_c
        %becomes a cooperator
        fprintf("it became a c")
        labels(v) = 1;
    else
        %becomes detractor
        fprintf("it became a d")
        labels(v) = 0;
    end
    og_labels
    labels
 end

