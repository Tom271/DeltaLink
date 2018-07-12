%%Naive Parallelisation of delta.m%%%
function samp=parDelta(nodeCount,linkDensity,mcmcSample)
sample=zeros(4,(mcmcSample)/4);
%Turn off large n warning%
%parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient')
    parfor i =1:4
        sample(i,:)=delta(nodeCount,linkDensity,(mcmcSample)/4,1);
    end
samp=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];
end
