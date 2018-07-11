%%%%%%%%%%%%%%%%NEWLOGQ%%%%%%%%%%%%%%%%%%%%%%%
% Trying 1/bincoeff for transition density   %
% INPUT: G,G',nodeCount                      %
% OUPUT: logq                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function newlogq=newlogq(Gcurr,Gprop,nodeCount,maxDelta)
    edgeCountCurr=full(sum(sum(Gcurr)))/2;
    edgeCountProp=full(sum(sum(Gprop)))/2;
    
    if edgeCountCurr>edgeCountProp
        q=1/(2*maxDelta*(nchoosek(0.5*nodeCount*(nodeCount-1)-edgeCountCurr...
            ,abs(edgeCountCurr-edgeCountProp))));
    end
    if edgeCountCurr<edgeCountProp
        q=1/(2*maxDelta*(nchoosek(edgeCountCurr...
            ,abs(edgeCountCurr-edgeCountProp))));
    end
    newlogq=log(q);
end
