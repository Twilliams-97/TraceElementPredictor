%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
[rowsparse,columnsparse] = size(SparseElements);    %Find number or rows and columns to iterate over 
                                                    %to fill the spare elements with predictions

%% Find fits from the element before the missing element 

sparseelementiterator = SparseElements;

for repeat = 1:(NearestNeighbours)
 
sparseelementiterator(sparseelementiterator==0)=9999;
%sparseelementiterator(isnan(sparseelementiterator)) = 9999;    %NewTest
    
forwardelements = zeros(rowsparse,columnsparse);  %Save these into a matrix the same size as the 'missing' matrix 

%% Predict the missing elements. Do this in a for loop.


    for row = 1:(rowsparse-1)  %Goes to i=1,i=2,...i=n-1. Will iterate for every pair of elements in the sparse matrix.

        for column = 1:columnsparse %j=1,j=2,...j=n. Will iterate for every individual sample in the sparse matrix.

            if sparseelementiterator(row+1,column) == 9999 && sparseelementiterator(row,column) ~= 9999 %Use this to fill values
                
                    forwardelements(row+1,column) = sparseelementiterator(row,column)*forwardregressor(row,1) + forwardregressor(row,2);
                    
            end

        end
    end

    %% Find fits from the element after the missing element   

    backwardelements = zeros(rowsparse,columnsparse);

    for row = 1:(rowsparse-1) %Goes to i=1,i=2,...i=n-1. Will iterate for every pair of elements in the sparse matrix.

        for column = 1:columnsparse %Goes to j=1,j=2,...j=n. Will iterate for every individual sample in the sparse matrix.

            if sparseelementiterator(row,column) == 9999 && sparseelementiterator(row+1,column) ~= 9999 %Use this to fill values
                
                    backwardelements(row,column) = sparseelementiterator(row+1,column)*backwardregressor(row,1) + backwardregressor(row,2);

            end

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
