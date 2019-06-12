b = 1;
c= 0.2;
w= 0.01;
dt = 0.01;
Bs = 1;
delta = 1
b/c
Bw = delta*Bs;
n=100;
T= 1000;
max_runs = 1;

b_ratios = [4, 4.5, 5, 5.5, 6]
k= 4; % num of neighbours

%create graph (sparse matrix)
%create cycle

og_graph = 

Bs*dt*n
for b
tic
pc_t_all_sim = get_final_cooperators(b,c,w,Bs,Bw,dt,n, og_graph, T, max_runs);
toc