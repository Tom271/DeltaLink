%%%%%%%LOGQ%%%%%%%%%%%%%
%
%Calculates the probability of moving from a graph G to a graph G' i.e. q(G,G')
%
%As in report -- Converges for n=100, not so good for large n=1000%
%%%%%%%%%%%%%%%%%%%%%%%%

function logQ = logq(G,nodeCount,maxDelta)
    edgeCount=full(sum(sum(G)))/2;
    remove=zeros(windowWidth/2,1);
    add=remove;
    %Probabilities of removing edges

    if edgeCount>=maxDelta
        %Sum runs from 1 to W/2
        for q=1:maxDelta
            remove(q)=nchoosek(edgeCount,q);
        end
    end
    %If there are fewer edges than can possibly be removed, the
    %probability of removing an edge is zero, so fill in the remaining vector entries
    % with zeroes.
    if edgeCount<maxDelta
        %This is sum of a row of Pascal's triangle, 2^m??
        %negSummand=nchoosek(edgeCount,1:edgeCount);
        remove=2^edgeCount;
        %negSummand(edgeCount+1:end)=0;
    end

    %Probabilities of adding edges
    %Sum runs from 1 to W/2
    for q=1:maxDelta
        add(q)=nchoosek(0.5*nodeCount*(nodeCount-1)-edgeCount,q);
    end

    logQ=log(sum(remove)+sum(add));

    logQ=logQ-log(nchoosek(0.5*nodeCount*(nodeCount-1),edgeCount));
end
