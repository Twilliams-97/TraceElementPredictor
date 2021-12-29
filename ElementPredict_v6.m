%% Element Predictor
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Import all the data we need

%Sparse Matrix data to be imported

ImportBasalt = 1;           %If import = 1, data for this sparse array will be imported.
ImportVolcanicGlass = 1;
ImportTestSparse = 1;
ImportKreep = 1;
ImportAlkaliAnorthite = 1;
ImportAlkaliNorite = 1;

%Full Matrix Data to be imported

ImportTestFull = 1;
ImportJoy = 1;
ImportSaalGlass = 1;
ImportNealBasalt = 1;
ImportLaPazMareBasaltMeteorite = 1;
ImportApollo15LowTi = 0;

%Import Chosen Data from Excel

importer 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose our sparse and full arrays to be used

combinedfullelements = [SaalGlassElements NealBasaltElements LaPazMareBasaltMeteoriteElements];    %Combine all the sources for which we have full data for the wanted prediction
Allcombinedfullelements = combinedfullelements;

SparseElements = MareBasaltElements; %[MareBasaltElements VolcanicGlassElements]; %[AlkaliAnorthiteElements AlkaliNoriteElements];    %MareBasaltElements;  %VolcanicGlassElements;        % Choose the Sparse Element array for which you want predictions

%% Select Elements to Include

% '1' indicates that this element will be used, '0' if element is to be discarded.

IncludedElements = [1 ;1 ;1 ;0 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1 ;1];
                  %[La;Ce;Pr;Sr;Nd;Zr;Hf;Sm;Eu;Gd;Tb;Dy;Y ;Ho;Er;Tm;Yb;Lu]
                  
ElementChooser

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Find regressions moving forwards and backwards

DisplayForwardFits = 0;    %If these values =1, then fits will be displayed. Else they won't
DisplayBackwardFits = 0;
  
regressormodule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Find the missing elements in the sparse matrix (the one with not all elements measured)    

NearestNeighbours = 3;   %Find the number of gaps to fill. 1 will fill from nearest neighbours, 2 from next nearest, etc.

%Choosing which element pairs not to include for forward and backward prediction must be done within this module 

MissingElementModule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculate The Europium Anomaly for every sparse sample

AddEuAnomalytoArray = 0;

if AddEuAnomalytoArray

    Euanomaly = zeros(columnsparse);
    SparseEuAnomaly = SparseElements./NormaliseElements;
    SparseEuAnomaly = SparseEuAnomaly(8,:)./((SparseEuAnomaly(7,:).*SparseEuAnomaly(9,:)).^(0.5));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot our Final Results

%There are multiple options for what to include

DisplayKREEPonLogLog = 1;
DisplayAlkaliAnorthiteonLogLog = 1;
DisplayAlkaliNoriteonLogLog = 1;

Normalise = 1;
DisplayLogLog = 0;
DisplayFinalResults = 1;
plotcombined = 0;

FinalResultPlotter
%FinalPredictorPlotter

if AddEuAnomalytoArray
    
    FilledDatawithEuAnomaly = [sparseelementiterator ; SparseEuAnomaly];
    RowNames = [ElementNames; 'Eu Anomaly'];
    FilledDatawithEuAnomaly = array2table(FilledDatawithEuAnomaly,'RowNames',RowNames);
    
    filename = '/Users/tomwilliams/Desktop/Brown/Fall 2021/Trace Element/Term Paper/Matlab Code/Results/PredictData.xlsx';
    writetable(FilledDatawithEuAnomaly,filename,'Sheet','FilledData','Range','A1','WriteVariableNames',false)
    
end
