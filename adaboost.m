function adaBoost()
    T = 10;
    % feature is 8460* 38*800, 8460 is feature dimension.
    feature = prepareForFeatures();
    Y = prepareForY();
    startBoost(feature, Y, T);
end
function finalR=prepareForFeatures()
    load('finalR.mat');
end
function Y = prepareForY()
    load('Y.mat');
end
function startBoost(feature, Y, T)
    adaBoostLearner(feature, Y, T);
end

function adaBoostLearner(X, Y, T)
    [cntSamples,cntFeatures]=size(X);   %[?Üâ? ÷åïÖ?]
    positiveCols=find(Y==1);
    negativeCols=find(Y==0);
    weight=ones(cntSamples,1);  %?Üâ?ñì
    weight(positiveCols)=1/(2*length(positiveCols));
    weight(negativeCols)=1/(2*length(negativeCols));
    Hypothesis=zeros(T,3);  % [?? ø¶ì¹ ÷åïÖ]ÝÂ?Ðï
    AlphaT=zeros(1,T);  %ÝÂ?Ðï?ñì
    t=1;
    while(true)
        minError=cntSamples;
        weight=weight/(sum(weight));
        for j=1:cntFeatures
            [tempError,tempThresh,tempBias]=searchBestWeakLearner(X(:,j),Y.',weight);
            if(tempError<minError)
                minError=tempError;
                Hypothesis(t,:)=[tempThresh,tempBias,j];
            end
        end
        h=AdaBoostWeakLearnerClassfy(X,Hypothesis(t,:));
        errorRate=sum(weight(find(h~=Y)));
        AlphaT(t)=log10((1-errorRate)/(errorRate+eps));
        if(errorRate>eps)
            weight(find(h==Y))=weight(find(h==Y))*(errorRate/(1-errorRate));                                     
        end
        if(t>=T)                  
            break;
        end
        t=t+1;
    end
end
function searchBestWeakLearner(FeatureVector,Y,weight)
    cntSamples=length(FeatureVector);
    u1=mean(FeatureVector(find(Y==1)));
    u2=mean(FeatureVector(find(Y==0)));
    iteration=4;
    sectNum=8;
    maxFea=max(u1,u2);
    minFea=min(u1,u2);
    step=(maxFea-minFea)/(sectNum-1);
    bestError=cntSamples;
    for iter=1:iteration
        tempError=cntSamples;
        for i=1:sectNum
            thresh=minFea+(i-1)*step;
            h=FeatureVector<thresh;
            errorrate=sum(weight(find(h~=Y)));
            p=1;
            if(errorrate>0.5)
                errorrate=1-errorrate;
                p=-1;
            end
            if( errorrate<bestError )
                bestError=errorrate;
                bestThresh=thresh;
                bestBias=p;
            end
        end
        span=(maxFea-minFea)/8;
        maxFea=bestThresh+span;
        minFea=bestThresh-span;
        step=(maxFea-minFea)/(sectNum-1);
    end
end

function [predictOutput]=AdaBoostWeakLearnerClassfy(Samples,weakLearner)
thresh=weakLearner(1);          % å°ÝÂ?ÐïîÜ ?? 
p=weakLearner(2);               % å°ÝÂ?ÐïîÜ ø¶öÇ
j=weakLearner(3);               % å°ÝÂ?ÐïîÜ ÷åïÖÖª??
 
predictOutput=(p.*Samples(:,j)<p*thresh); % Øß??Üâ?å°Ê£?îÜ?õó
predictOutput=predictOutput.';
end

