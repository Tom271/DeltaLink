%%Naive Parallelisation of passed MCMC function%%
function samp=parallel(fn,nodeCount,linkDensity,mcmcSample)
sample=zeros(4,(mcmcSample)/4);
maxDelta=1;
%Turn off large n warning%
%parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient')
    parfor i =1:4
        sample(i,:)=fn(nodeCount,linkDensity,(mcmcSample)/4,maxDelta);
    end
samp=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];
end