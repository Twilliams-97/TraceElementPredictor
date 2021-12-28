%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
[rowsparse,columnsparse] = size(SparseElements);    %Find number or rows and columns to iterate over 
                                                    %to fill the spare elements with predictions

%% Find fits from the element before the missing element 

sparseelementiterator = SparseElements;

for repeat = 1:(NearestNeighbours)
 
sparseelementiterator(sparseelementiterator==0)=9999;
%sparseelementiterator(isnan(sparseelementiterator)) = 9999;    %NewTest\

[blankrow,blankcolumn] = find(sparseelementiterator == 9999);

%% Predict the missing elements. Do this in a for loop.

forwardelements = zeros(rowsparse,columnsparse);  %Save these into a matrix the same size as the 'missing' matrix 

row = blankrow;
column = blankcolumn;

firstrow = find(row == 1);
row(firstrow) = [];  column(firstrow) = []; 

for index = 1:length(row)
    
    if sparseelementiterator(row(index)-1,column(index)) ~= 9999 
    
        forwardelements(row(index),column(index)) = sparseelementiterator(row(index)-1,column(index))*forwardregressor(row(index)-1,1) + forwardregressor(row(index)-1,2);
        
    end
    
end

%% Find fits from the element after the missing element 
    
    backwardelements = zeros(rowsparse,columnsparse);
    
    %remove any in the last row
    
    row = blankrow;
    column = blankcolumn;
    
    lastrow = find(blankrow == rowsparse);
    row(lastrow) = [];  column(lastrow) = []; 
     
    for index = 1:length(row)
        
        if sparseelementiterator(row(index)+1,column(index)) ~= 9999    
                     
            backwardelements(row(index),column(index)) = sparseelementiterator(row(index)+1,column(index))*backwardregressor(row(index),1) + backwardregressor(row(index),2);
        
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
