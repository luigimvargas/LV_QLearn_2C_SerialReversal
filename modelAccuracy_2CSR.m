%% Compare Model Fit
function [acc]=modelAccuracy_2CSR(SessionData,alpha,doWePlot,whichModel,beta)
    if ~exist('SessionData','var')
       uiopen 
    end
    [choices,rewards]=extractChoices_2CSR(SessionData);
    weightedChoices = zeros(1,SessionData.nTrials);

    %% Check Model Accuracy

        [choiceProbabilities, weights,~]=LV_QLearn_Softmax_2CSR(SessionData,alpha,beta);
        
        %Generate choices using probabilities from softmax equation
        accurateGuess=zeros(1,SessionData.nTrials);
        for i=1:SessionData.nTrials
            c=rand(1);
            if c<choiceProbabilities(1,i)
                weightedChoices(i)=1;
            else
                weightedChoices(i)=2;
            end
            
            if weightedChoices(i)==choices(i)
                accurateGuess(i)=1;
            end
                
        end
        wcL=find(weightedChoices==1);
        wcR=find(weightedChoices==2);
        
        acc=sum(accurateGuess(5:end))/(SessionData.nTrials-4);
    
    
    
    %%
    
    
    if doWePlot==true
        figure()
        hold on;
        orange = [1 0.5 0.5];
        scatterSize=6;
%         plot(1:SessionData.nTrials,(rewards(1,1:SessionData.nTrials)),'Color','b','LineWidth',3);
%             plot(1:SessionData.nTrials,(rewards(2,1:SessionData.nTrials)),'Color',orange,'LineWidth',3);
        xlabel('Trial Number')
        ylabel('Q Value')
        ylim([0 9.5])
        yticks([0 2 4 6 8 8.4 8.8])
        yticklabels({'0','2','4','6','8','Animal Choices','Model Choices'})
%         legend({'Left Port','Center Port','Right Port','Unrewarded Trial','Exploit'},'AutoUpdate','off','Location','southwest')
%         legend('boxoff')

        history1=find(choices==1);
        history2=find(choices==2);
        scatter(history1,ones(1,length(history1))*8.4,scatterSize,'b','filled')
        scatter(history2,ones(1,length(history2))*8.4,scatterSize,orange,'filled')
% 

            plot(1:SessionData.nTrials,weights(1,:),'--','Color','b','LineWidth',2.5);
            plot(1:SessionData.nTrials,weights(2,:),'--','Color',orange,'LineWidth',2.5);
        scatter(wcL,ones(1,length(wcL))*8.8,scatterSize,'b')
        scatter(wcR,ones(1,length(wcR))*8.8,scatterSize,orange)
        
        str=['Accuracy: ',num2str(acc), '       Alpha: ',num2str(alpha)];
        if whichModel=='SoftMax'
            str=['Accuracy: ',num2str(acc), '       Alpha: ',num2str(alpha), '       Beta: ' num2str(beta)];
        end
        text(SessionData.nTrials/3,9,str)
    end
    
end