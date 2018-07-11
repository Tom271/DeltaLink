%%%%%%%LOGQ%%%%%%%%%%%%%
%
%Calculates the probability of moving from a graph G to a graph G'
% i.e. DeltaQ(G,G')
%
%%%%%%%%%%%%%%%%%%%%%%%%

function DeltaQ = deltaQ(G,G',windowWidth)
    edgeCount=full(sum(sum(G)))/2;
    negsummand=zeros(windowWidth/2,1);

    %Probabilities of removing edges

    if edgeCount>=windowWidth/2
        %Sum runs from 1 to W/2
        negsummand=bincoeff(edgeCount,1:windowWidth/2);
    end

    %If there are fewer edges than can possibly be removed, the
    %probability of removing an edge is zero, so fill in the remaining
    %vector entries with zeroes.
    if edgeCount<windowWidth/2
        negsummand=bincoeff(edgeCount,1:edgeCount);
        negsummand(edgeCount+1:end)=0;
    end

    %Probabilities of adding edges
    %Sum runs from 1 to W/2
    possummand=bincoeff(0.5*n*(n-1)-edgeCount,1:windowWidth/2);

    logQ=log(sum(negsummand)+sum(possummand));
    logQ=logQ-log(nchoosek(0.5*n*(n-1),edgeCount));
end
