%MicrobialMeThinks

%IF YOU ARE GETTING AN ERROR REGARDING SOMETHING TO DO WITH STRING JUST
%COMMENT OUT LINES 64 AND 104. THEY ARE JUST COSMETIC. FOR SOME REASON
%SOME OF THE UNIVERSITY COMPUTERS DONT LIKE THE string() COMMAND. PERHAPS
%DIFFERENT VERSION OF MATLAB

clear;
popCycle = 0; %For cycling through each population systematically
popSize = 100; %Population size
Pop1 = zeros(popSize,28); %Pre-allocating matrix space because matlab likes it that way.
Pop2 = zeros(popSize,28); %Pre-allocating matrix space because it saves lots of time/re-allocation of memory.
crossOverPoint = round(rand); %Straight Crossover, this decides which halves to use 
i = 1; % Used for generating population
b = 0; %For infinite while loop, set to true when fitness is found (see below)
bestP1 = 0; % initial fitness plot, which will be added to array for population 1
bestP2 = 0; % initial fitness plot, which will be added to array for population 2
bestP1i = []; % array fittnes plot for population 1
bestP2i = []; % array fitness plot for population 2


while i <= popSize %Generate a (population)landscape/2d grid of individuals for each Pop
    Pop1(i,:) = newInd;
    Pop2(i,:)= newInd;
    i = i + 1;
end
        
while 1 == 1 %loop runs forever(condition to end is inside loop as peak fitness)
if b == 1 % checks if soulution has been found (see below where b is set)
    break
end   

    bestP1i = [bestP1i,  bestP1]; %each itteration through above loop adds the best fitness onto the array for each pop(same below)
    bestP2i = [bestP2i, bestP2]; %first itteration is 0
    

    j = 0; %For cycling through individuals in Pop1
    k = 0; %For cycling through individuals in Pop2
    while k < popSize %Run once through each member in each population.
        
        
        %This if statement allows circular selection of individuals within
        %3 spaces.       
        r = randi([-3, 3]); 
        if (j + r) > popSize 
            shift = (j+r) - popSize;
        elseif (j + r) <1
            shift = (j+r) + popSize;
        else
            shift = j + r;
        end
        
          
        if mod(popCycle,2) == 0 % Checks to see which cycle we are on to ensure both populations are rotated through.
        popCycle = popCycle + 1;
        j = j + 1;
        ind1 = Pop1(j,:); %Creating variable for the individual to be refered to for crossover(below), as matlab cant access temporary arrays
        ind2 = Pop2(shift,:); %Same as above.
            
            if weaselFittness(ind1) > bestP1
               bestP1 = weaselFittness(ind1);            
            end
                
            if weaselFittness(Pop1(j,:)) == 28 %Checking to see if fitness has been reached
               Solution = char(Pop1(j,:)) % If so returning answer
               plot(bestP1i) % plotting winning population
               Location = 'Pop1, row ' + string(j)
               b = 1; %first while loop condition to false
               break %exit "while k < popSize"
            end
            
            if weaselFittness(Pop1(j,:)) > weaselFittness(Pop2(shift,:))
                    %Pop2(shift,:) = mutate(Pop1(j,:))    %no cross over
                    if crossOverPoint == 1
                        Pop2(shift,:) = mutate([ind1(1:14), ind2(15:end)]);
                    else
                        Pop2(shift,:) = mutate([ind2(1:14), ind1(15:end)]); 
                    end
                
            elseif weaselFittness(Pop1(j,:)) < weaselFittness(Pop2(shift,:))
                    %Pop2(shift,:) = mutate(Pop1(j,:))    %no cross over
                    if crossOverPoint == 1
                        Pop1(j,:) = mutate([ind1(1:14), ind2(15:end)]);  
                    else
                        Pop1(j,:) = mutate([ind2(1:14), ind1(15:end)]);  
                    end
            else
                % mutate both no crossover
                Pop1(j,:) = mutate(ind1);
                Pop2(shift,:) = mutate(ind2);
                
            end
            
        else %This else is for the if refering to popCycle. I.e this itteration is for cycling through Pop2
        popCycle = popCycle + 1;
        k = k + 1;    
        ind1 = Pop2(k,:); %Creating variable for the individual to be refered to for crossover(below), as matlab cant access temporary arrays
        ind2 = Pop1(shift,:); %Same as above.
        
            if weaselFittness(ind1) > bestP2
               bestP2 = weaselFittness(ind1);            
            end
            
            if weaselFittness(Pop2(k,:)) == 28 %Checking to see if fitness has been reached
               Solution = char(Pop2(k,:)) % If so returning answer
               plot(bestP2i) % plotting winning population
               Location = 'Pop2, row ' + string(k)
               b = 1; % while loop condition to false
               break %exit for loop
            end
            
            if weaselFittness(Pop2(k,:)) > weaselFittness(Pop1(shift,:))
                    %Pop1(shift,:) = mutate(Pop2(k,:))    %no cross over
                    if crossOverPoint == 1
                        Pop1(shift,:) = mutate([ind1(1:14), ind2(15:end)]);
                    else
                        Pop1(shift,:) = mutate([ind2(1:14), ind1(15:end)]); 
                    end
                
            elseif weaselFittness(Pop2(k,:)) < weaselFittness(Pop1(shift,:))
                    %Pop2(k,:) = mutate(Pop1(shift,:))    %no cross over
                    if crossOverPoint == 1
                        Pop2(k,:) = mutate([ind1(1:14), ind2(15:end)]);  
                    else
                        Pop2(k,:) = mutate([ind2(1:14), ind1(15:end)]);  
                    end
                    
            else
                % mutate both no crossover
                Pop2(k,:) = mutate(ind1);
                Pop1(shift,:) = mutate(ind2);
            end
        end
    end
end        
% Cross over is slower because you are mutation an individual that is
% likely to be lesser, if you clone the original and then mutate you reach
% fitness faster. However this does not allow for netural drift. You could
% adjust, on the fly, the allowance of cross over to enable faster hill
% climbing and then switch to neutral drift untill fittness starts to climb
% again.

