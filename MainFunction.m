% Main function script for machine learning project

converge_test=0;
%%
%Loading data
% folder = 'G:\Research\data\1';
  folder = 'D:\Research\Thermal_monitoring\20150902_chicken_theraml\1';

  calculate = 1;
  
 if (calculate== 1 )
Load_data = 1 ;
data_seg_flag=1;
data_seg_max_flag=1;
 FFT_Extraction =1;
 SignalExtraction =1;
 Atte_compute =1;
 
 else
     %To save time...
 Load_data = 0 ;
data_seg_flag=0;
data_seg_max_flag=0;    
FFT_Extraction = 0;
SignalExtraction = 0 ;
Atte_compute = 0;

load('tofsArrayDff.mat');
load('tofsMaxArrayDff.mat');
load('FFTLiRegFeature.mat');
load('LiRegFeature.mat');
load('AttenuationFeature.mat');
 end
 
show_wave=0;

if (Load_data==1)

   [ ~, imageDataL, imageDataR, ~  ] = getAllIGTLFolders_Sync( folder );
    [ igtlSet, imageDataDAQ  ] = getAllIGTLFolders( folder );
 
 %%%%%%%%%%%%5% LR = 2(image index - 1) - 5
 %imageL=imageDataL{1};
 %imageR=imageDataR{1};
 imageDAQ=imageDataDAQ{1};
 igtlDataSet=igtlSet{1};
 

 %%
 %Evelope process
 for n=1:size(imageDAQ,3)
 image_envelope(:,:,n)=abs(hilbert(double(imageDAQ(:,:,n))));
 end
 
end

 %%
 %Reference frame before ablation
 Init_signal=sum(image_envelope(:,:,1:5),3)/size(image_envelope(:,:,1:5),3);

wavefront=Init_signal;
%wavefront= image_envelope(:,:,300);

if (show_wave==1)
  figure;
  mesh(wavefront);
end
  
pks=zeros(6000,128);
locs=zeros(6000,128);

cut_sample=590;

%remove collection noise

for n=1:128
 [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+6*std(wavefront(20:cut_sample,n))) ;
% [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(1.1*wavefront(:,n))) ;
  pks(1:size(pk,1),n) =pk;
  locs(1:size(loc,1),n) = loc;
  
  for j=1:size(loc,1)
      %1st data
      if loc(j,1)>cut_sample
          locs(1,n)=loc(j,1);
          break;
      end
  end
  
  if n>85
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+7*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample +200
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
  if n>97
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+4*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample+325
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
  if n>110
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+3.3*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample+410
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
end

for n=1:128
  if locs(1,n) < cut_sample
      locs(1,n) = cut_sample;
%     if n==1
%         locs(1,n) = locs(1,n+1);
%     elseif n==128
%          locs(1,n) = locs(1,n-1);  
%     else
%         locs(1,n) = round((locs(1,n+1)+locs(1,n-1))/2);
%     end
  end
end

 tofs= (locs(1,:)+20)*25e-9;

 %offset compensation caused by DAQ collection
 tofsinit=tofs+6e-6 ;

 if (show_wave==1)
figure;
plot(tofsinit);
 end
 

%%
%data segmenation

if data_seg_flag ==1

 for k=1:size(imageDAQ,3)

  wavefront = image_envelope(:,:,k);
     
  
for n=1:128
 [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+6*std(wavefront(20:cut_sample,n))) ;
% [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(1.1*wavefront(:,n))) ;
  pks(1:size(pk,1),n) =pk;
  locs(1:size(loc,1),n) = loc;
  
  for j=1:size(loc,1)
      %1st data
      if loc(j,1)>cut_sample
          locs(1,n)=loc(j,1);
          break;
      end
  end
  
  if n>85
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+7*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample +200
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
  if n>97
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+4*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample+325
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
  if n>110
  [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(wavefront(:,n))+3.3*std(wavefront(20:cut_sample,n))) ;     
  for j=1:size(loc,1)
      if loc(j,1)>cut_sample+410
          locs(1,n)=loc(j,1);
          break;
      end
  end   
  end
  
end

for n=1:128
  if locs(1,n) < cut_sample
      locs(1,n) = cut_sample;
%     if n==1
%         locs(1,n) = locs(1,n+1);
%     elseif n==128
%          locs(1,n) = locs(1,n-1);  
%     else
%         locs(1,n) = round((locs(1,n+1)+locs(1,n-1))/2);
%     end
  end
end   
     
 tofs= (locs(1,:)+20)*25e-9;

 %offset compensation caused by DAQ collection
 tofarray(k,:)=tofs+6e-6 ;

 disp(k);
 
 end
 
end

 
 
 
if data_seg_max_flag==1

    wavefront=Init_signal;
    
for n=1:128
 %[M, I] = max(wavefront(:,n)) ;
% [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(1.1*wavefront(:,n))) ;

  if n<64
[M, I] = max(wavefront(591:730, n)) ;
  I= I+590;
  
  end
  

  if (n>63 &&  n<80)
[M, I] = max(wavefront(681:830, n)) ;
  I= I+680;
  
  end
  
  
  if (n>79 &&  n<100)
[M, I] = max(wavefront(771:980, n)) ;
  I= I+770;
  
  end
  
   if (n>99 &&  n<110)
[M, I] = max(wavefront(911:1050, n)) ;
  I= I+910;
  
  end
  
  if n>109
[M, I] = max(wavefront(1001:1210, n)) ;
  I= I+1000;
  
  end
  
   tofs= I*25e-9;
   
    %offset compensation caused by DAQ collection
   tofsinitmax(n)=tofs+6e-6 ;
end

 if (show_wave==1)
figure;
plot(tofsinitmax);
 end
 

for k=1:451
    wavefront=image_envelope(:,:,k);
 
for n=1:128
 %[M, I] = max(wavefront(:,n)) ;
% [pk,loc] = findpeaks(wavefront(:,n),'MinPeakHeight',mean(1.1*wavefront(:,n))) ;

  if n<64
[M, I] = max(wavefront(591:730, n)) ;
  I= I+590;
  
  end
  

  if (n>63 &&  n<80)
[M, I] = max(wavefront(681:830, n)) ;
  I= I+680;
  
  end
  
  
  if (n>79 &&  n<100)
[M, I] = max(wavefront(771:980, n)) ;
  I= I+770;
  
  end
  
   if (n>99 &&  n<110)
[M, I] = max(wavefront(911:1050, n)) ;
  I= I+910;
  
  end
  
  if n>109
[M, I] = max(wavefront(1001:1210, n)) ;
  I= I+1000;
  
  end
  
   tofs= I*25e-9;
   
    %offset compensation caused by DAQ collection
   tofsMaxArray(k,n)=tofs+6e-6 ;
 end

end


end
 
 %% 
 if (show_wave==1)
  figure;
for k=1:380

 plot(tofsMaxArray(k,:));
 hold on;
 
end
 
 figure;
 
for k=1:380

  plot(tofarray(k,:));
  hold on;
 
end
 end
 

%%
%find difference
for k=1:380

tofsMaxArrayDff(k,:) = tofsMaxArray(k,:) -  tofsinitmax;
tofsArrayDff(k,:) = tofarray(k,:) -  tofsinit;

%  hold on;
 
end


if (FFT_Extraction == 1)
    FFTLiRegFeature = zeros(380,7);
%%
%Fourier Transform
Fs = 40e6; % Sampling frequency
T = 1/Fs; % Sampling period
L = 2080; % Length of signal
%t = (0:L-1)*T; % Time vector


for i=1:380
    for j=1:128
fftTOF = fft(image_envelope(:,j,i));

P2 = abs(fftTOF/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

offset_j = 7*(j-1);
mdl = LinearModel.fit(f,P1);
FFTLiRegFeature(i,offset_j+1:offset_j+2) = mdl.CoefficientCovariance(1,:); 
FFTLiRegFeature(i,offset_j+3:offset_j+4) = mdl.CoefficientCovariance(2,:);
FFTLiRegFeature(i,offset_j+5) = mdl.LogLikelihood;
FFTLiRegFeature(i,offset_j+6) = mdl.RMSE;
FFTLiRegFeature(i,offset_j+7) = mdl.SST;


if (i==264)&&(j==80)
    bbb=1; % for plot
end


    end
    
end
end


%%
%Signal linear regression
if (SignalExtraction == 1)
   LiRegFeature = zeros(380,7); 
    XAxis=1:2080;
for i=1:380
    for j=1:128
DataStream = image_envelope(:,j,i);

P2 = abs(DataStream/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

offset_j = 7*(j-1);
mdl = LinearModel.fit(XAxis,image_envelope(:,j,i));

LiRegFeature(i,offset_j+1:offset_j+2) = mdl.CoefficientCovariance(1,:); 
LiRegFeature(i,offset_j+3:offset_j+4) = mdl.CoefficientCovariance(2,:);
LiRegFeature(i,offset_j+5) = mdl.LogLikelihood;
LiRegFeature(i,offset_j+6) = mdl.RMSE;
LiRegFeature(i,offset_j+7) = mdl.SST;
    end
    
end
end

%%

%Attenuation
if (Atte_compute ==1)
AttenuationFeature = zeros(380,128);
for i=1:380
    for j=1:128

        DataStream = image_envelope(:,j,i);
        [maxAte, ~] = max(DataStream);
        AttenuationFeature(i,j) = maxAte;

    end
end
end


%%
%Feature Vector Combining

Featureset1 = [tofsArrayDff, FFTLiRegFeature, LiRegFeature, AttenuationFeature ];
Featureset2 = [tofsMaxArrayDff, FFTLiRegFeature, LiRegFeature, AttenuationFeature ];


%%
%SVM matlab libaray
crossVal=0;
temperature = 35;


%35 Celcius as threshold = 61

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

 % With First peak Segmantation
svmStruct = svmtrain(TrainSet,TrainLabel);
ClassResult = svmclassify(svmStruct,TestSet);

[ ErrorFirstPeak, ErrorFirstPeakRate ] = Error_Counting( thresholdTem, ClassResult );


% With Max Segmantation
svmStruct2 = svmtrain(TrainSet2,TrainLabel);
ClassResult2 = svmclassify(svmStruct2,TestSet2);

[ ErrorMax, ErrorFirstMaxRate ] = Error_Counting( thresholdTem, ClassResult2 );

%%
%K-NN matlab library

%KNNTrain = fitcknn (tofsArrayDff(1:2:379,:),TrainLabel,'Distance', 'hamming');
KNNTrain = fitcknn (TrainSet,TrainLabel);
KNNResult = predict(KNNTrain,TestSet);

[ ErrorKNN, ErrorRateKNN ] = Error_Counting( thresholdTem, KNNResult );


%%
%SVM our implementation

[ SVMResult, w ] = SVM( tofsArrayDff(1:2:379,:), TrainLabel, tofsArrayDff(2:2:380,:), 'Hinge', 'sgd', 50);
[ ErrorSVM, ErrorRateSVM ] = Error_Counting( thresholdTem, SVMResult );

[ SVMResult2, w2 ] = SVM( tofsArrayDff(1:2:379,:), TrainLabel, tofsArrayDff(2:2:380,:), 'Hinge', 'pegasos', 50);
[ ErrorSVM2, ErrorRateSVM2 ] = Error_Counting( thresholdTem, SVMResult2 );

[ SVMResult3, w3 ] = SVM( tofsArrayDff(1:2:379,:), TrainLabel, tofsArrayDff(2:2:380,:), 'Hinge', 'rmsprop', 50);
[ ErrorSVM3, ErrorRateSVM3 ] = Error_Counting( thresholdTem, SVMResult3 );

[ SVMResult4, w4 ] = SVM( tofsArrayDff(1:2:379,:), TrainLabel, tofsArrayDff(2:2:380,:), 'Hinge', 'adagrad', 50);
[ ErrorSVM4, ErrorRateSVM4 ] = Error_Counting( thresholdTem, SVMResult4);


%%
%K-NN our implementation
[KNNResult2, TieVector] = KNN(TrainSet, TrainLabel, TestSet, 1,'Hamming', 1);
[ ErrorKNN2, ErrorRateKNN2 ] = Error_Counting( thresholdTem, KNNResult2 );

[KNNResult3, TieVector] = KNN(TrainSet, TrainLabel, TestSet, 1,'Euclidean', 1);
[ ErrorKNN3, ErrorRateKNN3 ] = Error_Counting( thresholdTem, KNNResult3 );

%%
%adaboost
[Prediction,Hypo ] = adaboost(TrainSet, TrainLabel, TestSet, 5);
[ ErrorAda, ErrorRateAda ] = Error_Counting( thresholdTem, Prediction );


