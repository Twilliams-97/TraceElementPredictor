%% Plot our Final Results
if Normalise
    
    FinalNormaliseElements = NormaliseElements;
    AllFinalNormaliseElements = AllNormaliseElements;
    
else
    
    FinalNormaliseElements = ones(length(NormaliseElements),1);
    AllFinalNormaliseElements = ones(length(AllNormaliseElements),1);
    
end


if DisplayFinalResults

    plotter(sparseelementiterator,SparseElements,combinedfullelements,FinalNormaliseElements)

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
            set(gcf,'position',[300,300,1300,600])
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

        hold off
        
        xlabel(ElementNames(i))
        ylabel(ElementNames(i+1))
  
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
    hold off
    xticks([1:(length(combinedfullelements(:,1)))])
    xticklabels(AllElementNames)

end 

function plotter(sparseelementiterator,SparseElements,combinedfullelements,FinalNormaliseElements)

    figure()
    
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
