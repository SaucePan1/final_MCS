%model parameters
c= 0.2;
w= 0.01;
dt = 0.01;
Bs = 5;
n=100;
%graph neigh
k= 4;

%sim parameters
T= 500;
max_runs = 10;


% REMEMBER TO ADD SMALL/MEDIUM/BIG DELTA TO FILENAME
d_ratios = [0.001, 0.05, 0.1, 0.15,0.25];
b_c_ratios = [3, 3.5, 4, 4.5, 5];
k= 4; % num of neighbours

%create graph (sparse matrix)
%create cycle

og_graph = getGraph("rrg", n, k);

deaths= Bs*dt*n
%
pc_t_all_sim= zeros(max_runs,T, length(d_ratios), length(b_c_ratios));

for count1 =1:length(b_c_ratios)
    b = b_c_ratio*c
    for count =1:length(d_ratios)
        delta = d_ratios(count)
        Bw = delta*Bs;
        tic
        %delta, sim, T
        pc_t_all_sim(:,:,count, count1) = get_final_cooperators(b,c,w,Bs,Bw,dt,n, og_graph, T, max_runs);
        toc
    end
end
filename = strcat("rrg_k_4", "T_", num2str(T), "_max_runs", num2str(20), "small_delta");
save(filename, "pc_t_all_sim")