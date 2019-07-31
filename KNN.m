function [Result, TieAr] = KNN(TrainX, TrainLabel, PredictX, K, Distance, update)
% Author: Jaewon Lee, Younsu Kim
% Date: 12/08/2015
% K Nearest Neighbor
%
% Input:
%   TrainX : Train Set (number of samples by number of featuers)
%   TrainLabel : Train lable for supervised learning {1,-1}
%   PredictX : Test Set for predicting
%   K : Number of Neighbors
%   Distance : 'Hamming' or 'Euclidean'
%   update : if 1, add predicted sample to train set
% Output:
%   Result : Predicted label on test set
%   TieAr : To see if there is distance tied samples


%Number of Predictions
NofP  = size(PredictX, 1);
%Number of Trains
NofT  = size(TrainX, 1);
%Train lables
TLs   = unique(TrainLabel);

% Initializing
Result = zeros(NofP,1); 
TieAr  = zeros(NofP,1); 

if ((strcmp(Distance,'Hamming') == true))
    for i = 1:NofP
        distMatrix         = ones(NofT,1) * PredictX(i,:);
        Adist              = pdist2(TrainX, distMatrix, 'Hamming').^2;
        dist               = Adist(:,1);
        [~, indices]       = sort(dist);
        HistVote           = hist(TrainLabel(indices(1:K)), TLs);
        [~, MostVoteIndex] = max(HistVote);
        Result(i)          = TLs(MostVoteIndex);
        
        % For binary classification, if it ties, make 1 at TieAr vector
        if (MostVoteIndex == min(HistVote))
            TieAr(i) = 1;
        end

        % Updates train set while predicting
        if (update == 1)
         TrainX     = [TrainX ; PredictX(i,:)];
         TrainLabel = [TrainLabel ; Result(i)  ];
        end
 
    end
    
elseif (strcmp(Distance, 'Euclidean') == true)
    for i = 1:NofP

        distMatrix         = ones(NofT,1) * PredictX(i,:);
        Adist              = pdist2(TrainX, distMatrix).^2;          
        dist               = Adist(:,1);
        [~, indices]       = sort(dist);  
        HistVote           = hist(TrainLabel(indices(1:K)), TLs);
        [~, MostVoteIndex] = max(HistVote);
        Result(i)          = TLs(MostVoteIndex);
        
        %For binary classification, if it ties, make 1 at TieAr vector
        if (MostVoteIndex == min(HistVote))
         TieAr(i) = 1;
        end

        % Updates train set while predicting
        if (update == 1)
            TrainX     = [TrainX ; PredictX(i,:)];
            TrainLabel = [TrainLabel ; Result(i)];
        end
    end
else
end
end
