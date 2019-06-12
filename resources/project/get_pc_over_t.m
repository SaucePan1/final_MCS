b = 1;
c= 0.2;
w= 0.01;
dt = 0.01;
Bs = 1;
delta = 1
b/c
Bw = delta*Bs;
n=100;
T= 10;
max_runs = 5;

b_ratios = [4, 4.5, 5, 5.5, 6]
k= 4; % num of neighbours

%create graph (sparse matrix)
%create cycle

og_graph = getGraph("rrg", 100, 4);

Bs*dt*n
%
pc_t_all_sim= zeros(length(b_ratios),max_runs,T);
for count =1:length(b_ratios)
    b = c*b_ratios(count)
    tic
    pc_t_all_sim(count,:,:) = get_final_cooperators(b,c,w,Bs,Bw,dt,n, og_graph, T, max_runs);
    toc
end