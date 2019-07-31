%%script to plot result and figures
%For each plot, we do comment or uncomment

for k=1:4
temperature = (k+5)*5;
%temperature = 40;

if (temperature ==30)
thresholdTem = 29;
 label(1:58,1)=-1;
 label(59:380,1)=1;
elseif (temperature ==35)
thresholdTem = 61;
 label(1:122,1)=-1;
 label(123:380,1)=1;
 elseif (temperature ==40)
thresholdTem = 95;
 label(1:190,1)=-1;
 label(191:380,1)=1;
  elseif (temperature ==45)
thresholdTem = 132;
 label(1:264,1)=-1;
 label(265:380,1)=1;
 
end
crossVal=1;

if (crossVal==0)
    %odd set for train, even set for validation
    TrainSet = Featureset1(1:2:379,:);
    TrainSet2 = Featureset2(1:2:379,:);
    TestSet = Featureset1(2:2:380,:);
    TestSet2 = Featureset2(2:2:380,:);
    TrainLabel = label(1:2:379,:);
    TestLabel = label(2:2:380,:);

else
    %odd set for train, even set for validation
    TrainSet = Featureset1(2:2:380,:);
    TrainSet2 = Featureset2(2:2:380,:);
    TestSet = Featureset1(1:2:379,:);
    TestSet2 = Featureset2(1:2:379,:);
    TrainLabel = label(2:2:380,:);
    TestLabel = label(1:2:379,:);
end



%%
%K-NN matlab library

KNNTrain = fitcknn (tofsArrayDff(1:2:379,:),TrainLabel,'Distance', 'hamming');
KNNTrain = fitcknn (TrainSet,TrainLabel);
KNNResult = predict(KNNTrain,TestSet);

[ ErrorKNN, ErrorRateKNN ] = Acc_Counting( thresholdTem, KNNResult );




for i=1:5
    K=2*i-1;
%%
%K-NN our implementation
[KNNResult2, TieVector] = KNN(TrainSet, TrainLabel, TestSet, K,'Hamming', 1);
[ ErrorKNN2, AccrRateKNN2 ] = Acc_Counting( thresholdTem, KNNResult2 );

[KNNResult3, TieVector2] = KNN(TrainSet, TrainLabel, TestSet, K,'Euclidean', 1);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

KNN_K_Anal_Hamming(1,i) = AccrRateKNN2;
KNN_K_Anal_Euclidean(1,i) = ACCRateKNN3;

[KNNResult2, TieVector] = KNN(TestSet, TestLabel, TrainSet, K,'Hamming', 1);
[ ErrorKNN2, AccrRateKNN2 ] = Acc_Counting( thresholdTem, KNNResult2 );

[KNNResult3, TieVector2] = KNN(TestSet, TestLabel, TrainSet, K,'Euclidean', 1);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

KNN_K_Anal_HammingC(1,i) = AccrRateKNN2;
KNN_K_Anal_EuclideanC(1,i) = ACCRateKNN3;

[KNNResult2, TieVector] = KNN(TrainSet, TrainLabel, TestSet, K,'Hamming', 0);
[ ErrorKNN2, AccrRateKNN2 ] = Acc_Counting( thresholdTem, KNNResult2 );

[KNNResult3, TieVector2] = KNN(TrainSet, TrainLabel, TestSet, K,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

KNN_K_Anal_HammingU(1,i) = AccrRateKNN2;
KNN_K_Anal_EuclideanU(1,i) = ACCRateKNN3;

[KNNResult2, TieVector] = KNN(TestSet, TestLabel, TrainSet, K,'Hamming', 0);
[ ErrorKNN2, AccrRateKNN2 ] = Acc_Counting( thresholdTem, KNNResult2 );

[KNNResult3, TieVector2] = KNN(TestSet, TestLabel, TrainSet, K,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

KNN_K_Anal_HammingCU(1,i) = AccrRateKNN2;
KNN_K_Anal_EuclideanCU(1,i) = ACCRateKNN3;

end

figure;
plot([1:2:9],KNN_K_Anal_Hamming, [1:2:9],KNN_K_Anal_Euclidean,[1:2:9],KNN_K_Anal_HammingU, [1:2:9],KNN_K_Anal_EuclideanU);
xlabel('K');
ylabel('Accuracy');
legend('Hamming, w update','Euclidean, w update','Hamming, w/o update','Euclidean, w/o update')


%%
%adaboost
for i=1:6
    T=5*i;
    
[Prediction,Hypo ] = adaboost(TrainSet, TrainLabel, TestSet, T);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );
AdaResult(1,i) = ACCRateAda;

end

figure;
plot([5:5:30],AdaResult);
xlabel('Number of Hypothesis');
ylabel('Accuracy');
legend('Hamming, w/o update','Hamming, w/o update','Hamming, w update','Hamming, w update')


%%
%SVM our implementation
SVMResultAll= [0,0,0];
for i=1:10
[ SVMResult, w ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'sgd', 50);
[ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

% [ SVMResult2, w2 ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'pegasos', 50);
% [ ErrorSVM2, ACCRateSVM2 ] = Acc_Counting( thresholdTem, SVMResult2 );

[ SVMResult3, w3 ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'rmsprop', 50);
[ ErrorSVM3, ACCRateSVM3 ] = Acc_Counting( thresholdTem, SVMResult3 );

[ SVMResult4, w4 ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'adagrad', 50);
[ ErrorSVM4, ACCRateSVM4 ] = Acc_Counting( thresholdTem, SVMResult4);

SVMResultAll = SVMResultAll + [ACCRateSVM, ACCRateSVM3, ACCRateSVM4];
end

SVMResultAll = SVMResultAll/10;

figure;
bar(SVMResultAll);
Labels = {'sgd','pegasos','rmsprop','adagrad'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
xlabel('Update method');
ylabel('Accuracy');

figure;
bar(SVMResultAll);
Labels = {'sgd','rmsprop','adagrad'};
set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
xlabel('Update method');
ylabel('Accuracy');
axis([1 3 0.8 1.0]);

figure;
bar([KNN_K_Anal_EuclideanU(1), SVMResultAll(1),AdaResult(4) ] );
Labels = {'1-NN, Euclidean w/o update','SVM, sdg, iter=50','adaboost,NumHypo = 20'};
set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
xlabel('Classfication method');
ylabel('Accuracy');
axis([1 3 0.9 1.0]);


%legend('Hamming, w/o update','Hamming, w/o update','Hamming, w update','Hamming, w update')

%%
% Cross validation

 [ SVMResult, w ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet, TrainLabel, TestSet, 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TestSet, TestLabel, TrainSet, 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,k) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';

%%
%Feature validation

 [ SVMResult, w1 ] = SVM( TrainSet(:,1:128), TrainLabel, TestSet(:,1:128), 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet(:,1:128), TrainLabel, TestSet(:,1:128), 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TestSet(:,1:128), TestLabel, TrainSet(:,1:128), 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,1) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';

 [ SVMResult, w2 ] = SVM( TrainSet2(:,1:128), TrainLabel, TestSet2(:,1:128), 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet2(:,1:128), TrainLabel, TestSet2(:,1:128), 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TestSet2(:,1:128), TestLabel, TrainSet2(:,1:128), 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,2) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';


 [ SVMResult, w3 ] = SVM( TrainSet(:,1921:2048), TrainLabel, TestSet(:,1921:2048), 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet(:,1921:2048), TrainLabel, TestSet(:,1921:2048), 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TrainSet(:,1921:2048), TrainLabel, TestSet(:,1921:2048), 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,3) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';

%  [ SVMResult, w ] = SVM( [TrainSet(:,1:128),TrainSet(:,1921:2048)], TrainLabel, [TestSet(:,1:128),TestSet(:,1921:2048)], 'Hinge', 'sgd', 50);
%  [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );
% 
%  
%  [Prediction,Hypo ] = adaboost([TrainSet(:,1:128),TrainSet(:,1921:2048)], TrainLabel, [TestSet(:,1:128),TestSet(:,1921:2048)], 20);
% [ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );
% 
% [KNNResult3, TieVector2] = KNN([TrainSet(:,1:128),TrainSet(:,1921:2048)], TrainLabel, [TestSet(:,1:128),TestSet(:,1921:2048)], 7,'Euclidean', 0);
% [ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );
% 
% ResultSet(:,4) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';

 [ SVMResult, w4 ] = SVM( TrainSet(:,129:1024), TrainLabel, TestSet(:,129:1024), 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet(:,129:1024), TrainLabel, TestSet(:,129:1024), 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TrainSet(:,129:1024), TrainLabel, TestSet(:,129:1024), 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,4) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';

 [ SVMResult, w5 ] = SVM( TrainSet(:,1025:1920), TrainLabel, TestSet(:,1025:1920), 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet(:,1025:1920), TrainLabel, TestSet(:,1025:1920), 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TrainSet(:,1025:1920), TrainLabel, TestSet(:,1025:1920), 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,5) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';


 [ SVMResult, w6 ] = SVM( TrainSet, TrainLabel, TestSet, 'Hinge', 'sgd', 50);
 [ ErrorSVM, ACCRateSVM ] = Acc_Counting( thresholdTem, SVMResult );

 
 [Prediction,Hypo ] = adaboost(TrainSet, TrainLabel, TestSet, 20);
[ ErrorAda, ACCRateAda ] = Acc_Counting( thresholdTem, Prediction );

[KNNResult3, TieVector2] = KNN(TestSet, TestLabel, TrainSet, 7,'Euclidean', 0);
[ ErrorKNN3, ACCRateKNN3 ] = Acc_Counting( thresholdTem, KNNResult3 );

ResultSet(:,6) = [ACCRateSVM, ACCRateAda,ACCRateKNN3 ]';


 figure;
plot([1:6],ResultSet(1,:), [1:6],ResultSet(2,:),[1:6],ResultSet(3,:));
Labels = {'TOF(First Peak)','TOF(Max Peak)','Attenuation','FFT regiression', 'Signal regression', 'all'};
set(gca, 'XTick', 1:6, 'XTickLabel', Labels);
xlabel('Features');
ylabel('Accuracy');
legend('SVM, SDG, iter=50','adaboost,NumHypo = 20', '7-NN, Euclidean w/o update')

end

%%
% Cross validation
 figure;
plot([30:5:45],ResultSet(1,:), [30:5:45],ResultSet(2,:),[30:5:45],ResultSet(3,:));
% Labels = {'TOF(First Peak)','TOF(Max Peak)','Attenuation','FFT regiression', 'Signal regression', 'all'};
% set(gca, 'XTick', 1:6, 'XTickLabel', Labels);
xlabel('Temparature threshold');
ylabel('Accuracy');
legend('SVM, SDG, iter=50','adaboost,NumHypo = 20', '7-NN, Euclidean w/o update')
 


 % With First peak Segmantation
svmStruct = svmtrain(TrainSet,TrainLabel);
ClassResult = svmclassify(svmStruct,TestSet);
[ ErrorFirstPeak, ErrorFirstPeakRate ] = Acc_Counting( thresholdTem, ClassResult );


% With Max Segmantation
svmStruct2 = svmtrain(TrainSet2,TrainLabel);
ClassResult2 = svmclassify(svmStruct2,TestSet2);

[ ErrorMax, ErrorFirstMaxRate ] = Acc_Counting( thresholdTem, ClassResult2 );





