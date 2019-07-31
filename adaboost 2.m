function [Prediction,Hypo ] = adaboost(TrainX, TrainLabel, PredictX, NumHypo)
% Author: Jaewon Lee, Younsu Kim
% Date: 12/08/2015
% Adaboost
%
% Input:
%   TrainX : Train Set (number of samples by number of featuers)
%   TrainLabel : Train lable for supervised learning {1,-1}
%   PredictX : Test Set for predicting
%   NumHypo : Number of Hypothesis
% Output:
%   Prediction : Predicted label on test set
%   Hypo : Selected Hypothesis classes


% Initializing
NumSamples  = size(TrainX, 1);
NumFeatures = size(TrainX, 2);
w = ones(NumSamples, 1)./ NumSamples;
Hypo  = zeros(NumHypo, 3);
Alpha = zeros(NumHypo, 1);

% Reselect option
FeatureReselect = 1;


for t = 1 : NumHypo
    
MinError = size( TrainLabel, 1 );

    for i = 1 : NumFeatures
        % To avoid select same feature
        if (isempty(find(Hypo(:,1) == i)) == true)
            [threshholdSub, TotalErrorSub, bias] = Weaklearner(TrainX(:,i), TrainLabel, w);
            if (TotalErrorSub <= MinError)
                MinError   = TotalErrorSub;
                threshhold = threshholdSub;
                Hypo(t,:)  = [i,threshhold, bias];
            end
        end
    end
    % TODO
    % Weak classfier
    htemp = Hypo(t,3).*TrainX(:,Hypo(t,1)) < Hypo(t,3) * Hypo(t,2);
    h(find(~htemp),1) = -1;
    h(find(htemp),1)  = 1;
    E = sum(w(find(h ~= TrainLabel)));
    Alpha(t,1) = 0.5 * log((1-E)/E);
    
    % Update weight
    w(find(h ~= TrainLabel)) = w(find(h ~= TrainLabel)) * exp(Alpha(t,1));  % Incorrectly classified
    w(find(h == TrainLabel)) = w(find(h == TrainLabel)) * exp(-Alpha(t,1)); % Correctly classified
    % Normalizing
    w = w / sum(w);
end
Prediction = Predict( PredictX, Alpha, Hypo );

end

function [threshhold, TotalError, bias] = Weaklearner( Feature, Label, w )
posmean = mean(Feature(find(Label == 1)));
negmean = mean(Feature(find(Label == -1)));

SearchStep = 10;
Step       = abs(posmean-negmean) / SearchStep;

% Initial value
TotalError = size(Label,1);
threshhold = min(posmean,negmean);
for i = 0 : SearchStep - 1
    % Search for best threshhold
    threshholdHypo = min(posmean, negmean) + (Step * i);
    htemp = Feature < threshholdHypo;
    h(find(~htemp), 1) = -1;
    h(find(htemp), 1)  = 1;
    
    Error = sum(w(find(h ~= Label)));
    
    h2temp = Feature > threshholdHypo;
    h2(find(~h2temp),1) = -1;
    h2(find(h2temp),1)  = 1;
    Error2 = sum(w(find(h2 ~= Label)));  
    
    if Error <= Error2
        bias = 1;
    else
        bias  = -1;
        Error = Error2;
    end
    
    if Error <= TotalError
        TotalError = Error;
        threshhold = threshholdHypo;
    end
end
end

function Result = Predict( PredictX, Alpha, Hypo )

Result = zeros(size(PredictX,1),1);

for t = 1 : size(Hypo,1)
      htemp = Hypo(t,3).*PredictX(:,Hypo(t,1)) < Hypo(t,3) * Hypo(t,2);
      h(find(~htemp),1) = -1 * Alpha(t,1);
      h(find(htemp),1)  = 1 * Alpha(t,1);
      Result = Result + h;
end
Result = sign(Result);

end