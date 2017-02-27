function [ f ] = weaselFittness(s)
%fitness function, takes a string and returns a numeric value signifying fi
%amount of characters the string shares with 'methinks it is like a weasel'
apex = 'methinks it is like a weasel';
%converts methinks string and input string into ascii16
apex16 = uint16(apex);
f = 0;
%loops for the length of the string character by character
%and adds 1 to f if characters are the same
for i = 1 : 28
    
    if s(i) == apex16(i)
        f = f + 1;
    end    

end
