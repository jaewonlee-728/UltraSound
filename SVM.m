function [ PredictY ,w ] = SVM( TrainX, TrainLabel, PredictX, LossFunction, gradient_method, NumIter)
% Author: Jaewon Lee, Younsu Kim
% Date: 12/08/2015
% SVM
%
% Input:
%   TrainX : Train Set (number of samples by number of featuers)
%   TrainLabel : Train lable for supervised learning {1,-1}
%   PredictX : Test Set for predicting
%   LossFunction : Only support Hinge by now
%   gradient_method : 'sgd', 'rmsprop' or 'adagrad'
%   NumIter : total number of iteration
% Output:
%   PredictY : Predicted label on test set
%   w : To see calculated weight vector

% Initializing
NumSamples  = size(TrainX, 1);
NumFeatures = size(TrainX, 2);
w = zeros(NumFeatures,1);
lambda = 1e-4;
learning_rate = 1;
GradSum = 0;

for t = 1 : NumIter
    r = randi([1 NumSamples], 1, NumSamples);
    % Randomly pick a feature
    for i = 1 : NumSamples
        k = r(1,i);
        BatchSample = TrainX(k,:);
        BatchLable  = TrainLabel(k,:);
        if (strcmp(LossFunction, 'Hinge') == true)
            % Hinge loss
            w_update = lambda * w - (indicator(BatchLable, w, BatchSample) * (BatchLable * BatchSample))';
        else
        end
        % Update step
        if (strcmp(gradient_method, 'sgd') == true)
            % Hinge loss
            eta = learning_rate*(1- (t-1) / NumIter);
            % Update
            w = w - eta * w_update;
%         elseif (strcmp(gradient_method, 'pegasos') == true)
%             % Similar to HW3
%             %lambda = 1e-4;
%             eta = learning_rate*(1/(lambda*t));
%             % Update
%             w = w - (eta * w_update);
        elseif (strcmp(gradient_method, 'rmsprop') == true)
            decay_rate = 0.99;
            if (t == 1)
                GradSum = w_update'* w_update;
            else
                GradSum = GradSum * decay_rate;
                GradSum = GradSum + (1-decay_rate) * w_update' * w_update;
            end
            w_update = learning_rate * (w_update/sqrt(GradSum + 1e-16));
            % Update
            w = w - w_update;
        elseif (strcmp(gradient_method, 'adagrad') == true)
            GradSum = GradSum + w_update' * w_update;
            w_update = learning_rate * (w_update/sqrt(GradSum + 1e-16));
            % Update
            w = w - w_update;
%         elseif (strcmp(gradient_method, 'smorms3')==true)
%         GradSum = w_update'*w_update;
%         w_update = learning_rate*(w_update/sqrt(GradSum + 1e-16)) ; 
%         %update
%         w= w - w_update;       
        else
        end
        
    end
end
PredictY = predict(PredictX, w);
end

function PredictY = predict( PredictX, w )

PredictY = PredictX * w;
PredictY = sign(PredictY);

end

function [ result ] = indicator( BatchLable, w, BatchSample )

value = BatchLable * BatchSample * w;
if (value < 1)
    result = 1;
else
    result = 0;
end

end

