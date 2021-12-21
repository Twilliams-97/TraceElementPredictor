%Import stuff

%% Choose the Excel File to import from

ExcelFile = '/Users/tomwilliams/Desktop/Brown/Fall 2021/Trace Element/Term Paper/AllSamples.xlsx';

%% Get Element Nams

ElementNames = readtable(ExcelFile, 'Sheet', 'Names', 'VariableNamingRule', 'preserve');
ElementNames = ElementNames{:,1};
AllElementNames = ElementNames;

%% Import CI Chondrite values to normalise plots! ATM these are PUM

Normalise = readtable(ExcelFile, 'Sheet', 'CI Chondrite', 'VariableNamingRule', 'preserve');

NormaliseElements = Normalise{2:end, 2};

AllNormaliseElements = NormaliseElements;

%%%%%%%%%%%%%%%%%%%%%%%%%%% Actual Sparse Data

if ImportBasalt   
    
    MareBasaltElements = elementreader(ExcelFile,'All_MareNoSm');
    MareBasaltElements = MareBasaltElements(2:end,:);

end

if ImportVolcanicGlass
    
    VolcanicGlassElements = elementreader(ExcelFile,'Volcanic Glasses');
    
end

if ImportKreep
   
    KREEPElements = elementreader(ExcelFile,'KREEP');
    
end

if  ImportAlkaliAnorthite

    AlkaliAnorthiteElements = elementreader(ExcelFile,'AlkaliAnorthite');
    
end

if ImportAlkaliNorite

    AlkaliNoriteElements = elementreader(ExcelFile,'AlkaliNorite');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Actual Full Data

if ImportJoy  
    JoyElements = elementreader(ExcelFile,'Joy'); %Regolith Breccias
end

if ImportSaalGlass 
    SaalGlassElements = elementreader(ExcelFile,'Saal Glass'); %Glass  
    
    %Remove LowTi?
    SaalGlassElements(:,3:4) = [];
    
end

if ImportNealBasalt
    NealBasaltElements = elementreader(ExcelFile,'NealBasalt'); %Basalt
    NealBasaltElements = NealBasaltElements(2:end,:);
    %RemoveApollo11Basalts
    NealBasaltElements(:,1:8) = [];
end

if ImportApollo15LowTi
    
    Apollo15LowTiElements = elementreader(ExcelFile,'Apollo15LowTi'); %Low Ti Basalt
  
end

if ImportLaPazMareBasaltMeteorite
    LaPazMareBasaltMeteoriteElements = elementreader(ExcelFile,'LaPazMareBasaltMeteorite'); %Mare Basalt Meteorite
end
%%%%%%%%%%%%%%%%%%%%%%%%%%% Data Used For Testing

%% Import Full Data from Excel (all elements characterised,modern)

if ImportTestFull

    TestFull = readtable(ExcelFile, 'Sheet', 'TestFull', 'VariableNamingRule', 'preserve');

    TestFull = TestFull{:, :};  % Get relevant elements

end



%% Import Sparse Data from Excel (elements missing, legacy)

if ImportTestSparse

    TestSparse = readtable(ExcelFile, 'Sheet', 'TestSparse', 'VariableNamingRule', 'preserve');

    % Get relevant elements

    TestSparse = TestSparse{:, :};
    TestSparse(isnan(TestSparse)) = 9999;  %Sets all NaN values to 9999. Needed for computational methods.

end



function elementread = elementreader(ExcelFile,SheetName)

    
    elementread = readtable(ExcelFile,'Sheet', SheetName, 'VariableNamingRule', 'preserve');
            
    elementread = elementread{:, 2:end};
            
    elementread(isnan(elementread)) = 9999;
            

end