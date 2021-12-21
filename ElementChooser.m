%% Removes elements that aren't wanted


if ~Include_Lu
    
    elementnumber = 18;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Yb 
    
    elementnumber = 17;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Tm 
    
    elementnumber = 16;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Er 
    
    elementnumber = 15;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Ho 
    
    elementnumber = 14;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Y 
    
    elementnumber = 13;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Dy 
    
    elementnumber = 12;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Tb 
    
    elementnumber = 11;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Gd 
    
    elementnumber = 10;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Eu  
    
    elementnumber = 9;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
   
end

if ~Include_Sm 
    
    elementnumber = 8;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Hf 
    
    elementnumber = 7;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Zr  
    
    elementnumber = 6;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Nd  
    
    elementnumber = 5;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
  
end

if ~Include_Sr  
    
    elementnumber = 4;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
 
end

if ~Include_Pr 
    
    elementnumber = 3;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
    
end 

if ~Include_Ce  
    
    elementnumber = 2;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);

end

if ~Include_La 
    
    elementnumber = 1;
    [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements);
    
end

%%%%%%%% Function

function [combinedfullelements,SparseElements,ElementNames,NormaliseElements] = elementchoice(elementnumber,combinedfullelements,SparseElements,ElementNames,NormaliseElements)

    combinedfullelements(elementnumber,:) = [];
    SparseElements(elementnumber,:) = [];
    ElementNames(elementnumber,:) = [];
    NormaliseElements(elementnumber,:) = [];


end
