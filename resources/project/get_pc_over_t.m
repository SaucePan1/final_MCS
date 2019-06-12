%model parameters
b_c_ratio = 3;
c= 0.2;
b = b_c_ratio*c;
w= 0.01;
dt = 0.01;
Bs = 5;
n=100;
%graph neigh
k= 4;

%sim parameters
T= 500;
max_runs = 20;


d_ratios = [0.001, 0.05, 0.1, 0.15,0.25];
k= 4; % num of neighbours

%create graph (sparse matrix)
%create cycle

og_graph = getGraph("rrg", n, k);

deaths= Bs*dt*n
%
pc_t_all_sim= zeros(max_runs,T, length(d_ratios));
for count =1:length(d_ratios)
    delta = d_ratios(count)
    Bw = delta*Bs;
    tic
    %delta, sim, T
    pc_t_all_sim(:,:,count) = get_final_cooperators(b,c,w,Bs,Bw,dt,n, og_graph, T, max_runs);
    toc
end
sb_c = num2str(b_c_ratio);
filename = strcat("rrg_k_4_bc_ratio_", sb_c, "T_", num2str(T), "_max_runs", num2str(20));
save(filename, "pc_t_all_sim")