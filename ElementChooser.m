%% Removes elements that aren't wanted

for elementnumber = length(IncludedElements):-1:1
     
    if ~IncludedElements(elementnumber)
        
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
