%% Find regressions moving forwards and backwards
[rowsfullcombined,columnsfullcombined] = size(combinedfullelements);

%% Forward Regress. Finds a fit based on known the element before the missing element

forwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another

for i = 1:(rowsfullcombined-1)  %this iterates for every pair of elements in the full combined matrix

    x = reshape(combinedfullelements((i),:),[],1);
    Y = reshape(combinedfullelements((i+1),:),[],1);  
    [B,~,~,~,STATS] = regress(Y,[ones(size(x(:))),x(:)]);

    forwardregressor(i,:) = B;

    if DisplayForwardFits %Will display if DisplayForwardFits = 1. 
           
        loglogplotter(i,combinedfullelements,B,STATS,ElementNames,1)    %Plots the log-log graphs & regression line
    
    end                                                   

end

%% Backward Regress. Finds a fit based on known the element after the missing element.

backwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another

for i = 1:(rowsfullcombined-1)  %this iterates for every pair of elements in the full combined matrix

    x = reshape(combinedfullelements((i+1),:),[],1);
    Y = reshape(combinedfullelements((i),:),[],1);
    [B,~,~,~,STATS] = regress(Y,[ones(size(x(:))),x(:)]); 

    backwardregressor(i,:) = B;

    if DisplayBackwardFits%Will display if DisplayBackwardFits = 1.

        loglogplotter(i,combinedfullelements,B,STATS,ElementNames,0)   %Plots the log-log graphs and regression line
  
    end
        
end

%% Functions

function loglogplotter(i,combinedfullelements,B,STATS,ElementNames,ydir) %1 for forwards, 0 for backwards

        if i == 1 || i==9
            figure()
            set(gcf,'position',[300,300,1300,600])
        end

        if i <= 8
            subplot(2,4,i)
        else
            subplot(2,4,(i-8))
        end
        
        xdir = not(ydir);    %These are used to get the appropriate plots and labels
                                  %The +1 and +0 need to be opposite for forward and backward
        
        loglog(combinedfullelements(i+xdir,:),combinedfullelements((i+ydir),:),'.','DisplayName','Measured Elements')

        hold on
        fittedregression = refline(B(1),B(2)); 
        hold off
              
        xlabel(ElementNames(i+xdir))
        ylabel(ElementNames(i+ydir))
        fittedregression.DisplayName = strcat('y =',num2str(B(1)),'x +',num2str(B(2)), '. R^2 = ', num2str(STATS(1)));
        legend('Location','NorthWest','color','none')
                  
end
