%%%%%%%%%%%RHAMILTONIAN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate the graph Hamiltonian for the Erd\"os-Renyi Model          %%
%% Ideally this will eventually be extended to the 2* model             %%
%%                                                                      %%        
%% INPUTS: G - a sparse adjacency matrix of a graph                     %%
%%         linkDensity -the desired link density of the graph           %%
%%                                                                      %%
%% OUTPUTS: H - the graph Hamiltonian                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H=rhamiltonian(G,linkDensity)
    edgeCount=full(sum(sum(G))/2);
    Beta=log(linkDensity/(1-linkDensity));
    H=Beta*edgeCount;
end