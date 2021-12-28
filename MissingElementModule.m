%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
[rowsparse,columnsparse] = size(SparseElements);    %Find number or rows and columns to iterate over 
                                                    %to fill the spare elements with predictions

%% Find fits from the element before the missing element 

sparseelementiterator = SparseElements;

for repeat = 1:(NearestNeighbours)
 
sparseelementiterator(sparseelementiterator==0)=9999;
%sparseelementiterator(isnan(sparseelementiterator)) = 9999;    %NewTest

[blankrow,blankcolumn] = find(sparseelementiterator == 9999);

%% Predict the missing elements. Do this in a for loop.

forwardelements = zeros(rowsparse,columnsparse);  %Save these into a matrix the same size as the 'missing' matrix 

for index = 1:length(blankrow)
    
    if blankrow(index) ~=1 && sparseelementiterator(blankrow(index)-1,blankcolumn(index)) ~= 9999 
    
        forwardelements(blankrow(index),blankcolumn(index)) = sparseelementiterator(blankrow(index)-1,blankcolumn(index))*forwardregressor(blankrow(index)-1,1) + forwardregressor(blankrow(index)-1,2);
        
    end
    
end

%% Find fits from the element after the missing element 
    
    backwardelements = zeros(rowsparse,columnsparse);
    
    %remove any in the last row
     
    for index = 1:length(blankrow)
        
        if blankrow(index) ~=17 && sparseelementiterator(blankrow(index)+1,blankcolumn(index)) ~= 9999    
                     
            backwardelements(blankrow(index),blankcolumn(index)) = sparseelementiterator(blankrow(index)+1,blankcolumn(index))*backwardregressor(blankrow(index),1) + backwardregressor(blankrow(index),2);
        
        end
    end
 
    %% Remove elements where visually the fit was found to be poor
    % Needs to happen inside the for loop
    % Do this for the bad fits in forwardelements and backwards elements

    %GlassElements(7,:)=0; 
    %SparseElements(8,:)=0;

    sparseelementiterator(sparseelementiterator==9999)=0;

    %Need to get it so it only divides by two if both have a value!

    forwardnormaliser = forwardelements./forwardelements;
    backwardnormaliser = backwardelements./backwardelements;
    
    forwardnormaliser(isnan(forwardnormaliser)) = 0;
    backwardnormaliser(isnan(backwardnormaliser)) = 0;

    predictedelementaverager = 1./(forwardnormaliser + backwardnormaliser);     %divide by number of predictions (max two)
    predictedelementaverager(isinf(predictedelementaverager)) = 0;              %replaces inf values with 0
 
     %Adds our forwards and backward predicted elements to where they are missing in the sparse matrix
     %If two predictions are made, this will take the average
    
    sparseelementiterator = sparseelementiterator + (forwardelements + backwardelements).*predictedelementaverager; 
    
end

sparseelementiterator(sparseelementiterator==9999)=NaN;
