%model parameters
c= 0.2;
w= 0.01;
dt = 0.01;
Bs = 5;
n=100;
%graph neigh
k= 4;

%sim parameters
T= 200;
max_runs = 20;


% REMEMBER TO ADD SMALL/MEDIUM/BIG DELTA TO FILENAME
%low d_ratios = [0.001, 0.05, 0.1, 0.15,0.25]
%middle d_ratios = [0.8, 0.9, 1, 1.1, 1.2]
%big d = [4, 1/0.15, 1/0.1, 1/0.05, 1/0.001]
d_ratios_tot = ((1:15)-1) *0.02;
d_ratios_tot(1)= 0.001;
b_c_ratios = ((1:15)-1)*0.2 +2;
k= 4; % num of neighbours

d_ratios = d_ratios_tot(7:8);
%create graph (sparse matrix)
%create cycle

og_graph = createSmallWorld(n,k);

deaths= Bs*dt*n
%
pc_t_all_sim= zeros(max_runs,T, length(d_ratios), length(b_c_ratios));

for count1 =1:length(b_c_ratios)
    b = b_c_ratios(count1)*c
    for count =1:length(d_ratios)
        delta = d_ratios(count)
        Bw = delta*Bs;
        tic
        %delta, sim, T
        pc_t_all_sim(:,:,count, count1) = get_final_cooperators(b,c,w,Bs,Bw,dt,n, og_graph, T, max_runs);
        toc
    end
end
filename = strcat("sw_");
save(filename, "pc_t_all_sim")