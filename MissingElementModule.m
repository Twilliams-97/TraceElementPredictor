%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
sparseelementiterator = SparseElements; %Create an array that will be filled with predicted values
sparseelementiterator(isnan(sparseelementiterator)) = 0;

for repeat = 1:(NearestNeighbours)
     
    [missingrow,missingcolumn] = find(sparseelementiterator == 0);
    
%% Find fits from the element before the missing element:

    forwardelements = zeros(size(sparseelementiterator));   %We'll save these into a matrix the same size as the 'missing' matrix 

    for index = 1:length(missingrow)

        if missingrow(index) ~=1 && sparseelementiterator(missingrow(index)-1,missingcolumn(index)) ~= 0 

            forwardelements(missingrow(index),missingcolumn(index)) = sparseelementiterator(missingrow(index)-1,missingcolumn(index))*forwardregressor(missingrow(index)-1,1) + forwardregressor(missingrow(index)-1,2);

        end

    end

%% Find fits from the element after the missing element: 

        backwardelements = zeros(size(sparseelementiterator));
        lastrownumber = length(sparseelementiterator(:,1));

        for index = 1:length(missingrow)

            if missingrow(index) ~=lastrownumber && sparseelementiterator(missingrow(index)+1,missingcolumn(index)) ~= 0    

                backwardelements(missingrow(index),missingcolumn(index)) = sparseelementiterator(missingrow(index)+1,missingcolumn(index))*backwardregressor(missingrow(index),1) + backwardregressor(missingrow(index),2);

            end
        end

%% Remove elements where visually the fit was found to be poor (in either forward or backward fitting)

        %GlassElements(7,:)=0; 
        %SparseElements(8,:)=0;
        
%% Insert our predicted elements into the sparse array to create an array with both measuered and predicted values
        
        %We have 1s in positions in the matrix where one prediction has been made, 2 where 2, and 0 where none.
        %Use to take average where there is more than one prediction (i.e. value for both forwards and backwards)

        divider = (forwardelements ~= 0) + (backwardelements ~= 0);
        combinedpredictions = (forwardelements+backwardelements)./divider; %divide by number of predictions (max two)
        combinedpredictions(isnan(combinedpredictions)) = 0;    %replaces NaN values with 0

        %Insert our predicted elements into where they are missing
        sparseelementiterator = sparseelementiterator + combinedpredictions;

end
