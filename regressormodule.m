%% Find regressions moving forwards and backwards

[rowsfullcombined,columnsfullcombined] = size(combinedfullelements);

%% Set 9999 to NaN here. Change back at end.

combinedfullelements(combinedfullelements==9999)=NaN;

%% Forward Regress. Finds a fit based on known the element before the missing element

forwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another

for i = 1:(rowsfullcombined-1)  %this iterates for every pair of elements in the full combined matrix

    x = reshape(combinedfullelements((i),:),[],1);
    Y = reshape(combinedfullelements((i+1),:),[],1);  
    [B,BINT,R,RINT,STATS] = regress(Y,[ones(size(x(:))),x(:)]);

    forwardregressor(i,1) = B(2);
    forwardregressor(i,2) = B(1);

    if DisplayForwardFits %Will display if DisplayForwardFits = 1. 
        
        if i == 1 || i==9
            figure()
        end
               
        forwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)     %This plots the log-log graphs & regression line
    end                                                   

end

%% Backward Regress. Finds a fit based on known the element after the missing element.

backwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another

for i = 1:(rowsfullcombined-1)  %this iterates for every pair of elements in the full combined matrix

    x = reshape(combinedfullelements((i+1),:),[],1);
    Y = reshape(combinedfullelements((i),:),[],1);
    [B,BINT,R,RINT,STATS] = regress(Y,[ones(size(x(:))),x(:)]); 

    backwardregressor(i,1) = B(2);
    backwardregressor(i,2) = B(1);

    if DisplayBackwardFits%Will display if DisplayBackwardFits = 1.
        
        if i == 1 || i==9
            figure()
        end
        
        backwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)   %This plots the log-log graphs and regression line
  
    end
        
end

combinedfullelements(isnan(combinedfullelements)) = 9999;

%% Functions

function forwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)        
        
        if i <= 8
            subplot(2,4,i)
        else
            subplot(2,4,(i-8))
        end
             
        loglog(combinedfullelements(i,:),combinedfullelements((i+1),:),'.','DisplayName','Measured Elements')
        hold on
        fittedregression = refline(B(2),B(1));
        hold off

        xlabel(ElementNames(i))
        ylabel(ElementNames(i+1))
        fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x +',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        legend('Location','NorthWest','color','none')
        set(gcf,'position',[300,300,1300,600])

end

function backwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)
       
        if i <= 8
            subplot(2,4,i)
        else
            subplot(2,4,(i-8))
        end
        
        loglog(combinedfullelements(i+1,:),combinedfullelements((i),:),'.','DisplayName','Measured Elements')
        hold on
        fittedregression = refline(B(2),B(1)); 
        hold off
              
        xlabel(ElementNames(i+1))
        ylabel(ElementNames(i))
        fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x +',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        legend('Location','NorthWest','color','none')
        set(gcf,'position',[300,300,1300,600])
             
end
