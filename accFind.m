function[acc]=accFind(choices,choiceProbabilities)

% acc = -(transpose(choices(:))*log(choiceProbabilities(2,:))' + transpose((1-choices(:)))*log(choiceProbabilities(1,:))') ;
%note that this is matrix multiplication so we get 1 values which will be a sum. See mtimes in matlab help

%This is a method that is more computationally intensive but easier to
%interpret

    acc=0;
    for i = 1:length(choices)
        switch choices(i)
            case 1
                acc=acc+log(choiceProbabilities(1,i));
            case 2
                acc=acc+log(choiceProbabilities(2,i));
            case 3
                acc=acc+log(choiceProbabilities(3,i));
        end

    end
    acc=-acc;

end