%%%%%%%%%%%ERGRAPH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate a random sparse adjacency matrix for a simple graph         %%
%% For seeding an mcmc chain from stationarity                          %%
%%                                                                      %%        
%% INPUTS: n - number of nodes on the graph                             %%
%%         p - desired link density                                     %%
%%                                                                      %%
%% OUTPUTS: A - a symmetric sparse matrix whose only non-zero elements  %%
%%          are 1. Contains zero on the main diagonal                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A=ergraph(n,p)
    A=sprandsym(n,p);
    A(:,:)=logical(A(:,:)); % Set nonzero elements to 1
    A(logical(eye(n)))=0; %Set diagonal to 0
end