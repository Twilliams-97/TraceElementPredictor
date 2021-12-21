%% Find the missing elements in the sparse matrix (the one with not all elements measured)    
    
[rowsparse,columnsparse] = size(SparseElements);    %Find number or rows and columns to iterate over 
                                                    %to fill the spare elements with predictions

%% Find fits from the element before the missing element 

sparseelementiterator = SparseElements;

for repeat = 1:(NearestNeighbours)
 
sparseelementiterator(sparseelementiterator==0)=9999;
    
forwardelements = zeros(rowsparse,columnsparse);  %Save these into a matrix the same size as the 'missing' matrix 

%% Predict the missing elements. Do this in a for loop.


    for i = 1:(rowsparse-1)  %Goes to i=1,i=2,...i=n-1. Will iterate for every pair of elements in the sparse matrix.

        for j = 1:columnsparse %j=1,j=2,...j=n. Will iterate for every individual sample in the sparse matrix.

            if sparseelementiterator(i+1,j) == 9999 %Use this to fill values
                if sparseelementiterator(i,j) ~= 9999

                    forwardelements(i+1,j) = sparseelementiterator(i,j)*forwardregressor(i,1) + forwardregressor(i,2);

                end
            end

        end
    end

    %% Find fits from the element after the missing element   

    backwardelements = zeros(rowsparse,columnsparse);

    for i = 1:(rowsparse-1) %Goes to i=1,i=2,...i=n-1. Will iterate for every pair of elements in the sparse matrix.

        for j = 1:columnsparse %Goes to j=1,j=2,...j=n. Will iterate for every individual sample in the sparse matrix.

            if sparseelementiterator(i,j) == 9999 %Use this to fill values
                if sparseelementiterator(i+1,j) ~= 9999

                    backwardelements(i,j) = sparseelementiterator(i+1,j)*backwardregressor(i,1) + backwardregressor(i,2);

                end
            end

        end
    end
    
    %% Remove elements where visually the fit was found to be poor
    % Needs to happen inside the for loop
    % Do this for the bad fits in forwardelements and backwards elements

    %GlassElements(7,:)=0; 
    %SparseElements(8,:)=0;
    %PredictedElements(8,:)=0;

    PredictedElements = sparseelementiterator;
    sparseelementiterator(sparseelementiterator==9999)=0;
    PredictedElements(PredictedElements==9999)=0;

    %Need to get it so it only divides by two if both have a value!

    forwardnormaliser = forwardelements./forwardelements;
    forwardnormaliser(isnan(forwardnormaliser)) = 0;
    backwardnormaliser = backwardelements./backwardelements;
    backwardnormaliser(isnan(backwardnormaliser)) = 0;

    predictedelementaverager = 1./(forwardnormaliser + backwardnormaliser);     %divide by number of predictions (max two)
    predictedelementaverager(isinf(predictedelementaverager)) = 0;              %replaces inf values with 0

    PredictedElements = (forwardelements + backwardelements).*predictedelementaverager; %If two predictions are made, this will take

    sparseelementiterator = sparseelementiterator + PredictedElements; %Adds our predicted elements where they are missing in the sparse matrix
    %sparseelementiterator(1:3,1:6)
    
end

sparseelementiterator(sparseelementiterator==9999)=NaN;