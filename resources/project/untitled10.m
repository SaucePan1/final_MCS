b = 1;
c= 0.2;
w= 0.01;
dt = 0.1;
Bs = 2;
Bw = 2;
n=100;

%create graph (sparse matrix)
%create cycle

A = sparse(2:n, 1:n-1, ones(1,n-1), n, n);
B = sparse(1:n-1, 2:n, ones(1,n-1), n, n);
C = sparse([1,n],[n,1], [1,1], n, n);

cycle = A + B + C;
og_graph=cycle;

tic
get_fp_w_weights(b,c,w,Bs,Bw,dt,n, og_graph)
toc