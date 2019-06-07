function [graph] = getGraph(type, n, k)
%Creates a graph of the type specified with n vertex
%'cyc' creates a cycle, regardless of k
%'lat' created a lattice with n^2 vertex, regardless of k
%'rrg' creates a regular random cycle, where each vertex has k neighbours
%'rg' creates a random graph, where the average of neighbours is k
%'sfn' creates a graph with preferential network, where each vertex has k
%neighbours
graph=sparse(n,n);
if strcmp(type, 'lat') == 1
    if k == 2 
        graph=graph+sparse(2:n,1:(n-1),ones(1,n-1),n,n); %connects each vertex to the next
        graph=graph+sparse(1:(n-1),2:n,ones(1,n-1),n,n); %(link is reflexive)
        graph=graph+sparse([1,n],[n,1],ones(1,2),n,n); %links the last vertex with the first
    elseif k == 4
        graph=graph+sparse(2:n,1:(n-1),ones(1,n-1),n,n); %distance 1
        graph=graph+sparse(1:(n-1),2:n,ones(1,n-1),n,n);
        graph=graph+sparse([1,n],[n,1],ones(1,2),n,n);
        
        graph=graph+sparse(3:n,1:(n-2),ones(1,n-2),n,n); %distance 2
        graph=graph+sparse(1:(n-2),3:n,ones(1,n-2),n,n);
        graph=graph+sparse([1,2,n-1,n],[n-1,n,1,2],ones(1,4),n,n);
    elseif k == 6
        graph=graph+sparse(2:n,1:(n-1),ones(1,n-1),n,n); %distance 1
        graph=graph+sparse(1:(n-1),2:n,ones(1,n-1),n,n);
        graph=graph+sparse([1,n],[n,1],ones(1,2),n,n);
        
        graph=graph+sparse(3:n,1:(n-2),ones(1,n-2),n,n); %distance 2
        graph=graph+sparse(1:(n-2),3:n,ones(1,n-2),n,n);
        graph=graph+sparse([1,2,n-1,n],[n-1,n,1,2],ones(1,4),n,n);
        
        graph=graph+sparse(4:n,1:(n-3),ones(1,n-3),n,n); %distance 3
        graph=graph+sparse(1:(n-3),4:n,ones(1,n-3),n,n);
        graph=graph+sparse([1,2,3,n-2,n-1,n],[n-2,n-1,n,1,2,3],ones(1,6),n,n);
    end
elseif strcmp(type, 'lat') == 1
    if k == 3
        if n == 100
            for i = 0:9 %links rows
                graph=graph+sparse(10*i+(1:9),10*i+(2:10),ones(1,9),n,n);
                graph=graph+sparse(10*i+(2:10),10*i+(1:9),ones(1,9),n,n);
                graph=graph+sparse([10*i+1,10*i+10],[10*i+10,10*i+1],ones(1,2),n,n);
            end
            for i = 0:4 %link an even row with the next one
                graph=graph+sparse(i*20-1+(2:2:10),i*20+9+(2:2:10),ones(1,5),n,n); 
                graph=graph+sparse(i*20+9+(2:2:10),i*20-1+(2:2:10),ones(1,5),n,n);
            end
            for i = 0:3 %link an odd row with the next one
                graph=graph+sparse(i*20+10+(2:2:10),i*20+20+(2:2:10),ones(1,5),n,n);
                graph=graph+sparse(i*20+20+(2:2:10),i*20+10+(2:2:10),ones(1,5),n,n);
            end
            %link last row with first
            graph=graph+sparse([2,4,6,8,10],[92,94,96,98,100],ones(1,5),n,n); 
        elseif n == 500
            for i = 0:24 %links rows
                graph=graph+sparse(20*i+(1:19),20*i+(2:20),ones(1,19),n,n);
                graph=graph+sparse(20*i+(2:20),20*i+(1:19),ones(1,19),n,n);
                graph=graph+sparse([20*i+1,20*i+20],[20*i+20,20*i+1],ones(1,2),n,n);
            end
            for i = 0:11 %link an even row with the next one
                graph=graph+sparse(i*40-1+(2:2:20),i*40+19+(2:2:20),ones(1,10),n,n);
                graph=graph+sparse(i*40+9+(2:2:20),i*40-1+(2:2:20),ones(1,10),n,n);
            end
            for i = 0:11 %link an odd row with the next one
                graph=graph+sparse(i*40+20+(2:2:20),i*40+40+(2:2:20),ones(1,10),n,n);
                graph=graph+sparse(i*40+40+(2:2:20),i*40+20+(2:2:20),ones(1,10),n,n);
            end
            %link last row with first
            graph=graph+sparse(2:2:20,480+(2:2:20),ones(1,10),n,n);
        end
    elseif k == 4
        if n == 100
            %links rows
            for i = 0:9 
                graph=graph+sparse(10*i+(1:9),10*i+(2:10),ones(1,9),n,n);
                graph=graph+sparse(10*i+(2:10),10*i+(1:9),ones(1,9),n,n);
                graph=graph+sparse([10*i+1,10*i+10],[10*i+10,10*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(11:100,1:90,ones(1,90),n,n);
            graph=graph+sparse(1:90,11:100,ones(1,90),n,n);
            graph=graph+sparse(91:100,1:10,ones(1,10),n,n);
            graph=graph+sparse(1:10,91:100,ones(1,10),n,n);
        elseif n == 500 
            %links rows
            for i = 0:24 
                graph=graph+sparse(20*i+(1:19),20*i+(2:20),ones(1,19),n,n);
                graph=graph+sparse(20*i+(2:20),20*i+(1:19),ones(1,19),n,n);
                graph=graph+sparse([20*i+1,20*i+20],[20*i+20,20*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(21:500,1:480,ones(1,480),n,n);
            graph=graph+sparse(1:480,21:500,ones(1,480),n,n);
            graph=graph+sparse(481:500,1:20,ones(1,20),n,n);
            graph=graph+sparse(1:20,481:500,ones(1,20),n,n);
        end
    elseif k == 6
        if n == 100
            %links rows
            for i = 0:9 
                graph=graph+sparse(10*i+(1:9),10*i+(2:10),ones(1,9),n,n);
                graph=graph+sparse(10*i+(2:10),10*i+(1:9),ones(1,9),n,n);
                graph=graph+sparse([10*i+1,10*i+10],[10*i+10,10*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(11:100,1:90,ones(1,90),n,n); 
            graph=graph+sparse(1:90,11:100,ones(1,90),n,n);
            graph=graph+sparse(91:100,1:10,ones(1,10),n,n);
            graph=graph+sparse(1:10,91:100,ones(1,10),n,n);
            %links diagonally
            graph=graph+sparse(12:100,1:89,ones(1,89),n,n); 
            graph=graph+sparse(1:89,12:100,ones(1,89),n,n);
            graph=graph+sparse(2:10,91:99,ones(1,9),n,n);
            graph=graph+sparse(91:99,2:10,ones(1,9),n,n);
            graph(1,100)=1;
            graph(100,1)=1;
        elseif n == 500
            %links rows
            for i = 0:24 
                graph=graph+sparse(20*i+(1:19),20*i+(2:20),ones(1,19),n,n);
                graph=graph+sparse(20*i+(2:20),20*i+(1:19),ones(1,19),n,n);
                graph=graph+sparse([20*i+1,20*i+20],[20*i+20,20*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(21:500,1:480,ones(1,480),n,n); 
            graph=graph+sparse(1:480,21:500,ones(1,480),n,n);
            graph=graph+sparse(481:500,1:20,ones(1,20),n,n);
            graph=graph+sparse(1:20,481:500,ones(1,20),n,n);
            %links diagonally
            graph=graph+sparse(1:479,22:500,ones(1,479),n,n); 
            graph=graph+sparse(22:500,1:479,ones(1,479),n,n);
            graph=graph+sparse(2:20,481:499,ones(1,19),n,n);
            graph=graph+sparse(481:499,2:20,ones(1,19),n,n);
            graph(1,500)=1;
            graph(500,1)=1;
        end
    elseif k == 8
        if n == 100
            %links rows
            for i = 0:9 
                graph=graph+sparse(10*i+(1:9),10*i+(2:10),ones(1,9),n,n);
                graph=graph+sparse(10*i+(2:10),10*i+(1:9),ones(1,9),n,n);
                graph=graph+sparse([10*i+1,10*i+10],[10*i+10,10*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(11:100,1:90,ones(1,90),n,n); 
            graph=graph+sparse(1:90,11:100,ones(1,90),n,n);
            graph=graph+sparse(91:100,1:10,ones(1,10),n,n);
            graph=graph+sparse(1:10,91:100,ones(1,10),n,n);
            %links diagonally
            graph=graph+sparse(12:100,1:89,ones(1,89),n,n); 
            graph=graph+sparse(1:89,12:100,ones(1,89),n,n);
            graph=graph+sparse(2:10,91:99,ones(1,9),n,n);
            graph=graph+sparse(91:99,2:10,ones(1,9),n,n);
            graph(1,100)=1;
            graph(100,1)=1;
            %the other diagonal
            for i = 2:10
                graph=graph+sparse(i+10*(0:8),i+10*(1:9),ones(1,9),n,n);
                graph=graph+sparse(i+10*(1:9),i+10*(0:8),ones(1,9),n,n);
            end
            graph=graph+sparse(1+10*(0:8),10*(2:9),ones(1,9),n,n);
            graph=graph+sparse(10*(2:9),1+10*(0:8),ones(1,9),n,n);
            graph=graph+sparse(90+(2:10),1:9,ones(1,9),n,n);
            graph=graph+sparse(1:9,90+(2:10),ones(1,9),n,n);
            graph=graph+sparse(91,10,1,n,n);
        elseif n == 500
            %links rows
            for i = 0:24 
                graph=graph+sparse(20*i+(1:19),20*i+(2:20),ones(1,19),n,n);
                graph=graph+sparse(20*i+(2:20),20*i+(1:19),ones(1,19),n,n);
                graph=graph+sparse([20*i+1,20*i+20],[20*i+20,20*i+1],ones(1,2),n,n);
            end
            %links columns
            graph=graph+sparse(21:500,1:480,ones(1,480),n,n); 
            graph=graph+sparse(1:480,21:500,ones(1,480),n,n);
            graph=graph+sparse(481:500,1:20,ones(1,20),n,n);
            graph=graph+sparse(1:20,481:500,ones(1,20),n,n);
            %links diagonally
            graph=graph+sparse(1:479,22:500,ones(1,479),n,n); 
            graph=graph+sparse(22:500,1:479,ones(1,479),n,n);
            graph=graph+sparse(2:20,481:499,ones(1,19),n,n);
            graph=graph+sparse(481:499,2:20,ones(1,19),n,n);
            graph(1,500)=1;
            graph(500,1)=1;
            %the other diagonal
            for i = 2:20
                graph=graph+sparse(i+20*(0:23),i+20*(1:24),ones(1,19),n,n);
                graph=graph+sparse(i+20*(1:24),i+20*(0:23),ones(1,19),n,n);
            end
            graph=graph+sparse(1+20*(0:23),20*(2:25),ones(1,24),n,n);
            graph=graph+sparse(20*(2:25),1+20*(0:23),ones(1,24),n,n);
            graph=graph+sparse(480+(2:20),1:19,ones(1,19),n,n);
            graph=graph+sparse(1:19,480+(2:20),ones(1,19),n,n);
            graph=graph+sparse(481,20,1,n,n);
        end
    end
elseif strcmp(type, 'rrg') == 1 
    createRandRegGraph(n,k);
elseif strcmp(type, 'rg') == 1
    linksleft=n*k;
    disp(linksleft)
    while linksleft > 0
        chosen=randperm(n,2);
        if chosen(1) ~= chosen(2) && graph(chosen(1),chosen(2)) ~= 1
            graph=graph+sparse([chosen(1),chosen(2)],[chosen(2),chosen(1)],[1,1],n,n);
        end
        linksleft=linksleft-1;
    end
elseif strcmp(type, 'sfn') == 1
    graph=SFNG(n,k);
end
end