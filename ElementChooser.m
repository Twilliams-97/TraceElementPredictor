%% Removes elements that aren't wanted

for elementnumber = 1:length(IncludedElements)
     
    if IncludedElements(elementnumber) == 0
        
        [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);

    end

end

%%%%%%%% Function

function [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements)

    combinedfullelements(elementnumber,:) = [];
    SparseElements(elementnumber,:) = [];
    ElementNames(elementnumber,:) = [];
    NormaliseElements(elementnumber,:) = [];

end
