%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
sparseelementiterator = SparseElements; %Create an array that will be filled with predicted values

for repeat = 1:(NearestNeighbours)
 
    sparseelementiterator(sparseelementiterator==0)=9999;
    [blankrow,blankcolumn] = find(sparseelementiterator == 9999);
    
%% Find fits from the element before the missing element:

    forwardelements = zeros(size(sparseelementiterator));   %We'll save these into a matrix the same size as the 'missing' matrix 

    for index = 1:length(blankrow)

        if blankrow(index) ~=1 && sparseelementiterator(blankrow(index)-1,blankcolumn(index)) ~= 9999 

            forwardelements(blankrow(index),blankcolumn(index)) = sparseelementiterator(blankrow(index)-1,blankcolumn(index))*forwardregressor(blankrow(index)-1,1) + forwardregressor(blankrow(index)-1,2);

        end

    end

%% Find fits from the element after the missing element: 

        backwardelements = zeros(size(sparseelementiterator));
        lastrownumber = length(sparseelementiterator(:,1));

        for index = 1:length(blankrow)

            if blankrow(index) ~=lastrownumber && sparseelementiterator(blankrow(index)+1,blankcolumn(index)) ~= 9999    

                backwardelements(blankrow(index),blankcolumn(index)) = sparseelementiterator(blankrow(index)+1,blankcolumn(index))*backwardregressor(blankrow(index),1) + backwardregressor(blankrow(index),2);

            end
        end

%% Remove elements where visually the fit was found to be poor (in either forward or backward fitting)

        %GlassElements(7,:)=0; 
        %SparseElements(8,:)=0;
        
%% Insert our predicted elements into the sparse array to create an array with both measuered and predicted values

        sparseelementiterator(sparseelementiterator==9999)=0;

        %Take average of of there is more than one prediction (i.e. value for both forwards and backwards)

        forwardnormaliser = forwardelements./forwardelements;
        backwardnormaliser = backwardelements./backwardelements;

        forwardnormaliser(isnan(forwardnormaliser)) = 0;
        backwardnormaliser(isnan(backwardnormaliser)) = 0;

        predictedelementaverager = 1./(forwardnormaliser + backwardnormaliser);     %divide by number of predictions (max two)
        predictedelementaverager(isinf(predictedelementaverager)) = 0;              %replaces inf values with 0

         %Inserts our predicted elements into where they are missing

        sparseelementiterator = sparseelementiterator + (forwardelements + backwardelements).*predictedelementaverager; 

end

sparseelementiterator(sparseelementiterator==9999)=NaN;
