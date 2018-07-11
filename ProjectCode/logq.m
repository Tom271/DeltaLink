%%%%%%%LOGQ%%%%%%%%%%%%%
%
%Calculates the probability of moving from a graph G to a graph G' i.e. q(G,G')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%

function logQ = logq(G,n,windowWidth)
    edgeCount=full(sum(sum(G)))/2;
    negSummand=zeros(windowWidth/2,1);
    posSummand=negSummand;
    %Probabilities of removing edges

    if edgeCount>=windowWidth/2
        %Sum runs from 1 to W/2
        for q=1:windowWidth/2
            negSummand(q)=nchoosek(edgeCount,q);
        end
    end
    %If there are fewer edges than can possibly be removed, the
    %probability of removing an edge is zero, so fill in the remaining vector entries
    % with zeroes.
    if edgeCount<windowWidth/2
        %This is sum of a row of Pascal's triangle, 2^m??
        %negSummand=nchoosek(edgeCount,1:edgeCount);
        negSummand=2^edgeCount;
        %negSummand(edgeCount+1:end)=0;
    end

    %Probabilities of adding edges
    %Sum runs from 1 to W/2
    for q=1:windowWidth/2
        posSummand(q)=nchoosek(0.5*n*(n-1)-edgeCount,q);
    end

    logQ=log(sum(negSummand)+sum(posSummand));

    logQ=logQ-log(nchoosek(0.5*n*(n-1),edgeCount));
end
