%%TEST%%
%Produce QQ Plots, KS stat, 
function convtest(fn)
nodes=[50,100,250,500,750,1000];
linkDensity=[0.1,0.05,0.01];
ks=zeros(length(nodes),length(linkDensity));
mcmcSample=10^4;
for n=1:length(nodes)
    for m=1:length(linkDensity)
        tic
        sample=zeros(4,(mcmcSample)/4);
        %Turn off large n warning%
        parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient');
        parfor i =1:4
            sample(i,:)=fn(nodes(n),linkDensity(m),(mcmcSample)/4,1);
        end
        sample=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];
        
        analyticMean=nchoosek(nodes(n),2)*linkDensity(m);
        %%QQ Plot %%
        qq(sample,nodes,linkDensity,analyticMean)
        
        %%Calculate K-S Statistic%%
        ks(n,m)=ksstat(sample,analyticMean);
        toc
    end
end
        