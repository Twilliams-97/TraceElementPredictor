%% Term Paper

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

Include_La = 1;
Include_Ce = 1;
Include_Pr = 1;
Include_Sr = 0;
Include_Nd = 1;
Include_Zr = 1;
Include_Hf = 1;
Include_Sm = 1;
Include_Eu = 1;
Include_Gd = 1;
Include_Tb = 1;
Include_Dy = 1;
Include_Y  = 1;
Include_Ho = 1;
Include_Er = 1;
Include_Tm = 1;
Include_Yb = 1;
Include_Lu = 1;

ElementChooser

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Find regressions moving forwards and backwards

DisplayForwardFits = 0;    %If these values =1, then fits will be displayed. Else they won't
DisplayBackwardFits = 0;
  
regressormodule

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Find the missing elements in the sparse matrix (the one with not all elements measured)    

NearestNeighbours = 3;   %Find the number of gaps to fill. 1 will fill from nearest neighbours, 2 from next etc.

%Choosing which element pairs not to include for forward and backward
%prediction must be done within this module 

MissingElementModule  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculate The Europium Anomaly for every sparse sample

AddEuAnomalytoArray = 1;

if AddEuAnomalytoArray

    Euanomaly = zeros(columnsparse);
    SparseEuAnomaly = SparseElements./NormaliseElements;
    SparseEuAnomaly = SparseEuAnomaly(8,:)./((SparseEuAnomaly(7,:).*SparseEuAnomaly(9,:)).^(0.5));

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot our Final Results

%There are multiple options for what to include

IsBasalt = 0;
IncludeLowTiBasalt = 1;     %If using Basalt, do you want to plot LowTiBasalt?
DisplayKREEPonLogLog = 1;
DisplayAlkaliAnorthiteonLogLog = 1;
DisplayAlkaliNoriteonLogLog = 1;

Normalise = 1;
DisplayLogLog = 1;
DisplayFinalResults = 0;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

