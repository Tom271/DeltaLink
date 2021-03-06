%% M-H Algorithm for producing random graphs
%%     on n vertices with predefined link probability p
%%     by changing one link at a time.

function [edgesum,timeSeries]=onelink(n,p,iterations)

    function hamiltonian=H(G,n,p)
        m=sum(sum(G))/2; %number of edges on graph
        b=log(p/(1-p)); %log odds p
        hamiltonian=(m*b);
    end

    G=spalloc(n,n,(n^2)*p); %preallocate sparse matrix
    edgesum=zeros(p*n^2,1);
    time=zeros(iterations,1);
    time(1)=0;

    for k=1:iterations
        Gprop=G; %Proposed G
        i=randi(n);
        j=randi(n);
        while i==j  %make sure not changing diagonal entries
            i=randi(n);
        end

        Gprop(i,j)=1-G(i,j); %Break a link if there is one, make one if there isn't
        Gprop(j,i)=Gprop(i,j); %Force symmetry in the matrix

        if log(rand)<=min(0,(H(Gprop,n,p)-H(G,n,p)))
            G=Gprop;
        end

        m=full(sum(sum(G))/2); %count number of edges
        edgesum(m+1)=edgesum(m+1)+1;
        timeSeries(k+1)=m;
    end
    edgesum=edgesum/sum(edgesum); %pdf of edges
end

