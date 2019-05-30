function [fp] = getFP(b,c,w, n, graph, coop)
%UNTITLED3 Summary of this function goes here
% Gets the FP calculated over 10*n runs for parameters given and graph. 
%Coop = 1 returns FP for Cooperators, (if 0 returns for detractors)  
%


%create label vector 1 is Cooperator 0 is Detractor
%init labels with one cooperator

max_runs = 10*n;

labels = initLabels(coop,n);
invaded_count = 0;
for run = 1:max_runs
    stop = 0;
    count=0;
    
    %init labels for one coop and n-1 detractors (or viceversa if coop=0)
    labels = initLabels(coop,n); 
    while ~stop
        count = count +1;
        labels = DB_sim(b,c,w, n, graph, labels);
        all_c = all(labels); %returns 1 if all 1
        all_d = all(~labels);%returns 1 if all 0
        stop = or(all_c , all_d); %returns one if all 1 or all 0
    end
    invaded_count = invaded_count + coop*all_c + (~coop)*all_d; %increases if minority invaded
end

fp = invaded_count/max_runs;



end

