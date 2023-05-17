%% Example script for running Q model fitting and plotting

    if ~exist('SessionData','var')
       disp('load up a Bpod Session')
       uiopen 
    end
    
    %% Split Session Data into 80% for training and 20% for testing
    splitNum=round(0.8*(SessionData.nTrials));
    SessionData80=struct();
    SessionData80.Choice=SessionData.Choice(1:splitNum);
    SessionData80.TrialTypes=SessionData.TrialTypes(1:splitNum);
    SessionData80.nTrials=splitNum;
    SessionData80.RewardVolume=SessionData.RewardVolume(1:splitNum);
    SessionData80.TrialSettings=SessionData.TrialSettings(1:splitNum);
    
    SessionData20.Choice=SessionData.Choice(splitNum+1:SessionData.nTrials);
    SessionData20.TrialTypes=SessionData.TrialTypes(splitNum+1:SessionData.nTrials);
    SessionData20.nTrials=SessionData.nTrials-splitNum;
    SessionData20.RewardVolume=SessionData.RewardVolume(splitNum+1:SessionData.nTrials);
    SessionData20.TrialSettings=SessionData.TrialSettings(splitNum+1:SessionData.nTrials);
    %% Test Softmax
    softmaxResult=fitQModel_2CSR(SessionData80,'SoftMax');
    plot2CSR(softmaxResult);
    %% Test Softmax Accuracy
    accuracyList=zeros(1,3000);
    for i=1:3000
        accuracyList(i)=modelAccuracy_2CSR(SessionData20,softmaxResult.alpha,false,'SoftMax',softmaxResult.beta);
    end
    histogram(accuracyList);
    hold on;
    title('Measuring Accuracy of Softmax 3000 times')
    ylabel(' # of occurences')
    xlabel('Accuracy')
    hold off;
    modelAccuracy_2CSR(SessionData20,softmaxResult.alpha,true,'SoftMax',softmaxResult.beta);
    %% Test Softmax Decay
    softmaxDecayResult=fitQModel_2CSR(SessionData,'SoftDec');
    plot2CSR(softmaxDecayResult);
    %% Test Epsilon
    epsilonResult=fitQModel_2CSR(SessionData,'Epsilon');
    plot2CSR(epsilonResult);
    %% Test Epsilon Decay
    epsilonDecayResult=fitQModel_2CSR(SessionData,'EpsiDec');
    plot2CSR(epsilonDecayResult);
    %% Testing
    clear('SessionData'); %%SessionData is now saved in each variable