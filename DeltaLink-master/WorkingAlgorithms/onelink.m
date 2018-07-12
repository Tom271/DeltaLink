%% M-H Algorithm for producing random graphs
%%     on n vertices with predefined link probability p
%%     by changing one link at a time.

function timeSeries=onelink(nodeCount,linkDensity,mcmcSample,maxDelta)

    Gcurr=ergraph(nodeCount,linkDensity); %preallocate sparse matrix
    edgeCountcurr=full(sum(sum(Gcurr)))/2;
    
    timeSeries=zeros(mcmcSample,1);
    timeSeries(1)=edgeCountcurr;
    
    for k=2:mcmcSample
        Gprop=Gcurr; %Proposed G
        i=randi(nodeCount);
        j=randi(nodeCount);
        
        while i==j  %make sure not changing diagonal entries
            i=randi(nodeCount);
        end

        Gprop(i,j)=1-Gcurr(i,j); %Break a link if there is one, make one if there isn't
        Gprop(j,i)=Gprop(i,j); %Force symmetry in the matrix

        if log(rand)<=min(0,(hamiltonian(Gprop,linkDensity)-hamiltonian(Gcurr,linkDensity)))
            Gcurr=Gprop;
        end
        
        edgeCountcurr=full(sum(sum(Gcurr)))/2; %count number of edges
        timeSeries(k)=edgeCountcurr;
    end
end

