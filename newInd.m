function [ indi ] = newInd( )
%Returns a new individual 
%   An individual is a random hescii code of 28 characters from the list
%   variable named 'Set' (lower case a-z and a space)

Set = char(['a':'z' ' ']);
indi = uint16(Set(ceil(length(Set)*rand(1,28))));


end

