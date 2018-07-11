%%%%%%%%%%Delta Link Algorithm%%%%%%%%%%%%%
%Rewritten Code as justified in the project submission,
% although not the project code. For that see ~/ProjectCode/deltalink.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function timeSeries=delta(nodeCount,linkDensity,mcmcSample,maxDelta)
    %distribution=string(distribution);
    %Gcurr=spalloc(nodeCount,nodeCount,linkDensity*nodeCount^2);
    Gcurr=ergraph(nodeCount,linkDensity);
    edgeCountcurr=full(sum(sum(Gcurr)))/2;
    timeSeries=zeros(mcmcSample,1);
    timeSeries(1)=edgeCountcurr;

    for k=2:mcmcSample
        Gprop=Gcurr;

        %%First swap a random number of links
        delta=randi([-maxDelta,maxDelta]);

        if (edgeCountcurr<=-delta)||(edgeCountcurr>=(nchoosek(nodeCount,2)-delta))||(delta==0)
            %Reject if no change proposed, or not enough/too many edges on
            %graph
			timeSeries(k)=edgeCountcurr;
			continue
        end
        i=zeros(1,abs(delta));
        j=i;
        %Create vectors of indices to change
        for z=1:abs(delta)
            %Choose edges to change randomly
            i(z)=randi(nodeCount);
            j(z)=randi(nodeCount);
            %If adding make sure not deleting and vice versa, no self edges
            while (i(z)==j(z)) || (delta>0 && Gcurr(i(z),j(z)) ==1) || (delta<0 && Gcurr(i(z),j(z)) ==0)
                i(z)=randi(nodeCount);
                j(z)=randi(nodeCount);
            end
        %Change these elements
        Gprop(i(z),j(z))=1-Gcurr(i(z),j(z)); %Change the link
        Gprop(j(z),i(z))=Gprop(i(z),j(z)); %Force symmetry in adjacency matrix
        end
        %%Links are swapped, now to decide whether or not to accept the
        %%change using MH rejection
        
        %deltaH = H(G')-H(G)
        deltaH=rhamiltonian(Gprop,linkDensity)-rhamiltonian(Gcurr,linkDensity);
        
        %deltaH = q(G,G')-q(G',G)
        deltaQ=newlogq(Gcurr,Gprop,nodeCount,maxDelta)-newlogq(Gprop,Gcurr,nodeCount,maxDelta);
        deltaQ=-deltaQ;
        if log(rand)<=min(0,deltaH-deltaQ)
            Gcurr=Gprop;
        end

        edgeCountcurr=full(sum(sum(Gcurr)))/2;
        timeSeries(k)=edgeCountcurr;
    end
end

