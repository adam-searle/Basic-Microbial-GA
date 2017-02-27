function [ mutant ] = mutate( ind )
%mutant Takes an individual and mutates

mutationRate= 1/28;
Set = char(['a':'z' ' ']); % see comment below
nSet = length(Set); %variable set here to save computing length each itteration through loop.
mutant = ind;

    for i=1:28 %mutate
        if(rand < mutationRate)
            m = uint16(Set(ceil(nSet*rand(1))));
            mutant(i) = m;
        end
    end


end

