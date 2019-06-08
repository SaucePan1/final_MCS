function [expected_percent] = getPercentage(b,c,w, n, graph,steps, runs, coop)
% Returns percentge of cooperators /detractors after selected number of
% runs
%

%initialize with one coop / detractor

labels = initLabels(coop, n); %if coop = 1 lablers is initialized with one cooperator

%get percentage vector
percent_invaded = zeros(1,runs);

%run simulations
for run =1:runs
    for step =1:steps
        labels = DB_sim(b,c,w, n, graph, labels);
    end
    percent_invaded(run) = sum(labels == coop);
end

expected_percent = mean(percent_invaded);
end

