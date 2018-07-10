%Log probability of moving from the current graph G to a graph G'

function logq=rlogq(G,nodeCount,maxDelta)
   %(Gcurr,Gprop,nodeCount)
   % currEdge=full(sum(sum(Gcurr)))/2;
   % propEdge=full(sum(sum(Gprop)))/2;
   % d=propEdge-currEdge;
   % if d>0
   %     logq=-log(nchoosek(0.5*nodeCount*(nodeCount-1)-currEdge,d));
   % end

   % if d<0
   %     logq=-log(nchoosek(currEdge,-d));
   % end
    
    edgeCount=full(sum(sum(G)))/2;
    remove=zeros(maxDelta,1);
    add=zeros(maxDelta,1);
    if edgeCount>=maxDelta
        for q=1:maxDelta
            remove(q)=nchoosek(edgeCount,q);
        end
    end
    if edgeCount<maxDelta
        remove=2^edgeCount;
    end

    for q=1:maxDelta
        add(q)=nchoosek(0.5*nodeCount*(nodeCount-1)-edgeCount,q);
    end

  logq=log(sum(remove)+sum(add))-log(nchoosek(0.5*nodeCount*(nodeCount-1),edgeCount));
end
