function [timeSeries] = deltalink(n,p,iterations,windowWidth,Ginit)
%edgedist,timeSeries
    %force window to be even width
    windowWidth=2*floor(windowWidth/2);
    G=Ginit; %preallocate sparse matrix
    edgesum=zeros(p*n^2,1);
    timeSeries=zeros(iterations,1);
    DeltaQ=zeros(iterations,1);
    DeltaH=zeros(iterations,1);
    timeSeries(1)=full(sum(sum(G)))/2;
    propedges=0;
    for k=1:iterations
        curredges=propedges;
        Gprop=G; %Proposed G
     %%%%%%%%%%%%nchoosek delta uniformly on [-W/2,W/2] %%%%%%%%%
        delta =randi([-windowWidth/2,windowWidth/2]);
        %%%%% Reject if no additions or removals possible%%%%%%%%
        if (curredges<=-delta)||(curredges>=(nchoosek(n,2)-delta))||(delta==0)
            edgesum(curredges+1)=edgesum(curredges+1)+1;
			timeSeries(k+1)=curredges;
			continue
        end
        %%%%%%Change Edges%%%%%%%%%
        for z=1:abs(delta)
            i(z)=randi(n);
            j(z)=randi(n);
            while (i(z)==j(z)) || (delta>0 && G(i(z),j(z)) ==1) || (delta<0 && G(i(z),j(z)) ==0)
                i(z)=randi(n);
                j(z)=randi(n);
            end
            Gprop(i(z),j(z))=1-G(i(z),j(z)); %Add a link
            Gprop(j(z),i(z))=Gprop(i(z),j(z)); %Force symmetry
        end
        
        deltaQ=+logq(Gprop,n,windowWidth)-logq(G,n,windowWidth);
        deltaH=hamiltonian(Gprop,p)-hamiltonian(G,p);

        if log(rand)<=min(0,deltaH-deltaQ)
            G=Gprop;
        end
        propedges=full(sum(sum(G))/2);
        edgesum(propedges+1)=edgesum(propedges+1)+1;
        timeSeries(k+1)=propedges;
    end
    edgedist=edgesum/sum(edgesum);
end

