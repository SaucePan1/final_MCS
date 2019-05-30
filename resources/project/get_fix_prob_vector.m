%model parameters
n= 100 %number of vertices
b=1
c=0.2
w = 0.01 %strength of fitness score 


%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;

graph = cycle; %we rename it since in 
%the future we will try different tiypes of graphs

%get fixation prob for different b/c ratio
n_bvalues = 10;
b_values = linspace(0,1,n_bvalues);
fix_prob_c = zeros(1, n_bvalues);
fix_prob_d = zeros(1, n_bvalues);
for indx = 1:n_bvalues
    b = b_values(indx);
    tic
    fix_prob_c(indx) = getFP(b,c,w,n, graph, 1);
    fix_prob_d(indx) = getFP(b,c,w,n, graph, 0);
    indx
    toc
end



