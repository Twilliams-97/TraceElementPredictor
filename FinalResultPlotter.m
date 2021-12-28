%% Plot our Final Results

combinedfullelements(combinedfullelements==9999)=NaN;
SparseElements(SparseElements==9999)=NaN;
NealBasaltElements(NealBasaltElements==9999)=NaN;
KREEPElements(KREEPElements==9999)=NaN;
AlkaliAnorthiteElements(AlkaliAnorthiteElements==9999)=NaN;
AlkaliNoriteElements(AlkaliNoriteElements==9999)=NaN;
%Apollo15LowTiElements(Apollo15LowTiElements==9999)=NaN;

if Normalise
    
    FinalNormaliseElements = NormaliseElements;
    FianlAllNormaliseElements = AllNormaliseElements;
    
else
    
    FinalNormaliseElements = ones(length(NormaliseElements),1);
    FinalAllNormaliseElements = ones(length(AllNormaliseElements),1);
    
end


if DisplayFinalResults

    plotter(sparseelementiterator,SparseElements,combinedfullelements,FinalNormaliseElements,IncludeLowTiBasalt,IsBasalt)

    xticks([1:(length(SparseElements(:,1)))])
    xticklabels(ElementNames)
    xlim([1 (length(SparseElements(:,1)))])
    xlabel('Element Name')

    ylabel('Concentration/CI Chondrite')
    ylim([1 4000])

    set(gcf,'position',[300,300,1000,500])

end

if DisplayLogLog

    for i = 1:(rowsfullcombined-1)

        if i == 1 || i==9
            figure()
        end

        if i <= 8
            subplot(2,4,i)
        else
            subplot(2,4,(i-8))
        end

        loglog(combinedfullelements(i,:),combinedfullelements((i+1),:),'m+'...
            ,'DisplayName','Modern Measurements',...
            'MarkerSize',8,...
            'MarkerfaceColor','m')
        hold on
        loglog(sparseelementiterator(i,:),sparseelementiterator((i+1),:),'k^','DisplayName','Predicted Elements','MarkerfaceColor','k')   
        loglog(SparseElements(i,:),SparseElements((i+1),:),'b.','DisplayName','Legacy Measurements')

        if DisplayKREEPonLogLog

            loglog(KREEPElements(i,:),KREEPElements((i+1),:),'cd','DisplayName','KREEP','MarkerfaceColor','c')

        end

        if DisplayAlkaliAnorthiteonLogLog

            loglog(AlkaliAnorthiteElements(i,:),AlkaliAnorthiteElements((i+1),:),'rp','DisplayName','Alkali Anorthite and Norite','MarkerfaceColor','r')

        end

        if i == 1 || i==9

            legend('Autoupdate','off','Location','NorthWest')

        end


        if DisplayAlkaliNoriteonLogLog

            loglog(AlkaliNoriteElements(i,:),AlkaliNoriteElements((i+1),:),'rp','DisplayName','Alkali Norite Elements','MarkerfaceColor','r')

        end

        %fittedforwardregression = refline(forwardregressor(i,1),forwardregressor(i,2));

        xlabel(ElementNames(i))
        ylabel(ElementNames(i+1))

        %{
        %B(B<=0.001)=0; %Sets values to zero if they are negligible,

        %lower = refline(BINT(2,1),BINT(1,1));
        %lower.LineStyle = '--';
        %upper = refline(BINT(2,2),BINT(1,2));
        %upper.LineStyle = ':';


        if -0.001 <= forwardregressor(1) && forwardregressor(1) <= 0.001  %Ignores the intercept if it is negligible, otherwise it will display it
            fittedregression.DisplayName = strcat('y =',num2str(forwardregressor(2)),'x . R^2 = ', num2str(STATS(1)));  
        elseif B(i,1) >=0.001     %This is for positive intercepts           
            fittedregression.DisplayName = strcat('y =',num2str(forwardregressor(2)),'x +',num2str(forwardregressor(1)), '. R^2 = ', num2str(STATS(1)));
        else                    %This is for negative intercepts
            fittedregression.DisplayName = strcat('y =',num2str(forwardregressor(2)),'x',num2str(forwardregressor(1)), '. R^2 = ', num2str(STATS(1)));
        end

        %}

        set(gcf,'position',[300,300,1300,600])
        
        hold off

    end

end

if plotcombined

    figure()
    semilogy(Allcombinedfullelements./AllFinalNormaliseElements,'-b')  %Plot the elements we used to predict values
    hold on 
    semilogy(NealBasaltElements./AllFinalNormaliseElements,'-k')
    %semilogy(Apollo15LowTiElements./FinalNormaliseElements,'-r')
    semilogy(LaPazMareBasaltMeteoriteElements./AllFinalNormaliseElements,'-g')
    semilogy(AlkaliAnorthiteElements./AllFinalNormaliseElements,'-m')
    semilogy(AlkaliNoriteElements./AllFinalNormaliseElements,'-r')

    xticks([1:(length(combinedfullelements(:,1)))])
    xticklabels(AllElementNames)

end 

function array = lowTiremover(array)

    array(:,58:62) = [];   % Luna and Apollo
    array(:,52) = []; %Remove sample 52
   
end

function plotter(sparseelementiterator,SparseElements,combinedfullelements,FinalNormaliseElements,IncludeLowTiBasalt,IsBasalt)

    figure()
    h1 = axes;

    semilogy(sparseelementiterator(:,1)./FinalNormaliseElements,'--^k',...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','k',...
        'MarkerSize',5,...
        'DisplayName','Predicted Concentration');
    hold on
    semilogy(SparseElements(:,1)./FinalNormaliseElements,'-ok',...
        'MarkerFaceColor','k',...
        'DisplayName','Measured Concentration via Neutron Activation');

    semilogy(combinedfullelements(:,1)./FinalNormaliseElements,'-+m',...
        'MarkerFaceColor','m',...
        'DisplayName','Full Suite of Elements Analysed');
    
    if IncludeLowTiBasalt
        if IsBasalt
        
            semilogy(sparseelementiterator(:,61)./FinalNormaliseElements,'-r',... 
                'MarkerFaceColor','r',...
                'MarkerSize',5,...
                'DisplayName','Low Ti Basalt');
        end
    end

    legend('Autoupdate','off')

    semilogy(sparseelementiterator./FinalNormaliseElements,'--^k',...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','k',...
        'MarkerSize',5);

    semilogy(SparseElements./FinalNormaliseElements,'-ok',...
        'MarkerFaceColor','k');

    semilogy(combinedfullelements./FinalNormaliseElements,'-+m',...
        'MarkerFaceColor','m',...
        'DisplayName','Modern Measurements (used to predict)');
    
end
