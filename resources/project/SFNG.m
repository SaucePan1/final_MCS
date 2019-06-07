function SFNet = SFNG(Nodes, mlinks)
seed=sparse(5,5);
    for i = 1:5
        flag1=1;
        while flag1 > 0
            chosen=randi(5);
            if chosen ~= i
                seed(chosen,i)=1;
                seed(i,chosen)=1;
                flag1=0;
            end
        end
    end
seed = full(seed);
pos = length(seed);
rand('state',sum(100*clock));
Net = zeros(Nodes, Nodes);
Net(1:pos,1:pos) = seed;
sumlinks = sum(sum(Net));
while pos < Nodes
    pos = pos + 1;
    linkage = 0;
    while linkage ~= mlinks
        rnode = ceil(rand * pos);
        deg = sum(Net(:,rnode)) * 2;
        rlink = rand * 1;
        if rlink < deg / sumlinks && Net(pos,rnode) ~= 1 && Net(rnode,pos) ~= 1
            Net(pos,rnode) = 1;
            Net(rnode,pos) = 1;
            linkage = linkage + 1;
            sumlinks = sumlinks + 2;
        end
    end
end
clear Nodes deg linkage pos rlink rnode sumlinks mlinks
SFNet = sparse(Net);