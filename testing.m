nodes=logspace(2,4,3);
linkDensity=logspace(-1,-2,2);
ks=zeros(3,2);
mcmcSample=10^6;
for n=1:3
    for m=1:2
        tic
        sample=zeros(4,(mcmcSample)/4);
        %Turn off large n warning%
        parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient')
        parfor i =1:4
            sample(i,:)=delta(nodes(n),linkDensity(m),(mcmcSample)/4,1);
        end
        sample=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];
        analyticMean=nchoosek(nodes(n),2)*linkDensity(m);
        qq(sample,nodes,linkDensity,analyticMean)
        ks(n,m)=ksstat(sample,analyticMean);
        toc
    end
end
        