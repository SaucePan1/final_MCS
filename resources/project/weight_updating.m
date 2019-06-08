%model parameters
n= 100 %number of vertices
b=1
c=0.2
w = 0.01 %strength of fitness score 
Bs = 1; %rate of strategy update
Bw = 1; %rate of weigth update 

%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;

graph = cycle; %we rename it since in 
%the future we will try different tiypes of graphs

