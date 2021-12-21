%% Find regressions moving forwards and backwards

%This CAN handle missing values in our input 'full' array!

[rowsfullcombined,columnsfullcombined] = size(combinedfullelements);

%% Set 9999 to NaN here. Change back at end.

combinedfullelements(combinedfullelements==9999)=NaN;

%% Forward Regress. Finds a fit based on known the element before the missing element

forwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another
forwardB = zeros((rowsfullcombined-1) ,2);

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
        
        
        forwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)     %This plots the
    end                                                   %log-log graphs and regression line

end

%% Backward Regress. Finds a fit based on known the element after the missing element.

backwardregressor = zeros((rowsfullcombined-1) ,2);  %Creates an array to store the fit lines for every pair of elements next to one another
%backwardB = zeros((rowsfullcombined-1) ,2);

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
        
%{
        if i <= 8
            subplot(2,4,i)
        end
        if i >= 9
            subplot(2,4,(i-8))
        end
%}
        figure()
        
        loglog(combinedfullelements(i,:),combinedfullelements((i+1),:),'.','DisplayName','Measured Elements')
        hold on

        xlabel(ElementNames(i))
        ylabel(ElementNames(i+1))

        %B(B<=0.001)=0; %Sets values to zero if they are negligible,
        
        fittedregression = refline(B(2),B(1));
        %lower = refline(BINT(2,1),BINT(1,1));
        %lower.LineStyle = '--';
        %upper = refline(BINT(2,2),BINT(1,2));
        %upper.LineStyle = ':';
          
        if -0.001 <= B(1) && B(1) <= 0.001  %Ignores the intercept if it is negligible, otherwise it will display it
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x . R^2 = ', num2str(STATS(1)));  
        elseif B(1) >=0.001     %This is for positive intercepts           
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x +',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        else                    %This is for negative intercepts
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        end
        
        legend('Location','NorthWest')
      
        hold off


end


function backwardloglogplotter(i,combinedfullelements,B,STATS,ElementNames)
       
        if i <= 8
            subplot(2,4,i)
        end
        if i >= 9
            subplot(2,4,(i-8))
        end
        
        loglog(combinedfullelements(i+1,:),combinedfullelements((i),:),'.','DisplayName','Measured Elements')
        hold on
        xlabel(ElementNames(i+1))
        ylabel(ElementNames(i))

        fittedregression = refline(B(2),B(1));
        %forwardfittedregression = refline(1/forwardB(2),forwardB(1));
        
        %forwardy = linspace(0,50);
        %forwardvalues = (forwardy-forwardB(1))/forwardB(2);
        %plot(forwardvalues,'r-')
       
        if -0.001 <= B(1) && B(1) <= 0.001  %Ignores the intercept if it is negligible, otherwise it will display it
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x . R^2 = ', num2str(STATS(1)));  
        elseif B(1) >=0.001     %This is for positive intercepts           
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x +',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        else                    %This is for negative intercepts
            fittedregression.DisplayName = strcat('y =',num2str(B(2)),'x',num2str(B(1)), '. R^2 = ', num2str(STATS(1)));
        end
               
        legend('Location','NorthWest')
        hold off
        
end