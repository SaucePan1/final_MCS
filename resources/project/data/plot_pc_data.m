%plotting 
d_ratios = [0.001, 0.05, 0.1, 0.15,0.25];
T= 250;
pc_data = importdata("sfn_k_4T_250_max_runs20small_delta.mat");
labels = {'b/c =3','b/c =3.5','b/c =4','b/c =4.5','b/c =5', 'b/c =3','b/c =3.5','b/c =4','b/c =4.5','b/c =5','b/c =3','b/c =3.5','b/c =4','b/c =4.5','b/c =5', 'b/c =3','b/c =3.5','b/c =4','b/c =4.5','b/c =5', 'b/c =3','b/c =3.5','b/c =4','b/c =4.5','b/c =5'};
data = zeros(10,25);
for i=1:5
    for b=1:5
        col = (i-1)*5 + b;
        data(:,col) = pc_data(:,end,i,b);
    end
end
hold off
data = data/100;
boxplot(data, 'PlotStyle', 'compact', 'Labels', labels)
hold on
%define invisible axes to add labels on top
box off
delta_labels = {'', '', 'd=0.001', '', '','', '', 'd=0.05', '', '', '', '', 'd=0.1', '', '', '', '', 'd=0.15', '', '', '', '', 'd=0.25', '', ''};
%axes('xlim', [1 25], 'ylim', [0 1], 'color', 'none',  'XAxisLocation', 'top')

y = linspace(0,1);
x= 5*ones(length(y));
plot(x+0.5,y,'--', 'Color', 'r')
plot(x+5.5,y,'--', 'Color', 'r')
plot(x+10.5,y,'--', 'Color', 'r')
plot(x+15.5,y,'--', 'Color', 'r')
plot(x+20.5,y,'--', 'Color', 'r')
title("Scale Free Network (k=4)")
xlabel("Increasing Values of \delta -->")
ylabel("Fraction of Cooperators at T=250 (S=20)")

