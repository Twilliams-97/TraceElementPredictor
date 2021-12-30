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
            legend('Location','NorthWest')
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

        if DisplayAlkaliNoriteonLogLog

            loglog(AlkaliNoriteElements(i,:),AlkaliNoriteElements((i+1),:),'rp','DisplayName','Alkali Norite Elements','MarkerfaceColor','r', 'HandleVisibility','off')

        end
        
        if i == 1 || i==9
            legend('Location','NorthWest')
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
    
    h = zeros(3,1); %These are used for the legend entries
    h(1) = semilogy(NaN,'--^k','MarkerFaceColor','k');
    hold on
    h(2) = semilogy(NaN,'-ok','MarkerFaceColor','k');
    h(3) = semilogy(NaN,'-+m','MarkerFaceColor','m');
    legend(h, 'Predicted Concentration','Measured Concentration via Neutron Activation','Full Suite of Elements Analysed');
    
    semilogy(sparseelementiterator./FinalNormaliseElements,'--^k','MarkerFaceColor','k',...
        'MarkerSize',5, 'HandleVisibility','off');

    semilogy(SparseElements./FinalNormaliseElements,'-ok', 'MarkerFaceColor','k', 'HandleVisibility','off');

    semilogy(combinedfullelements./FinalNormaliseElements,'-+m', 'MarkerFaceColor','m', 'HandleVisibility','off');
    
end
