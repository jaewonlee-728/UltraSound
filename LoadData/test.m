% clear all
% folder = 'D:\PA_Data\TransrectalCalibration\2015_05_27_TransRectalCalibration';
folder = 'D:\Research\Thermal_monitoring\20150701_ThermalMonitoring6cmLinear\18_32_28_DAQ_post_1st';

index = [17:35 37 39:42 44:55 57:60];

figLin = 0;
figCurv = 0;
load = 1;
bf = 1;

sos = 1490;
no_ele = 64;
times = 3; % lateral sampling enhancement
expandApt = 3; % how much to expand FOV
samp = 40e6;

probeLin.numEle = 64;
probeLin.height = 5;
probeLin.pitch = 0.43;
probeLin.sp = sos;

probeCurv.numEle = 64*times;
probeCurv.height = 35;
probeCurv.radius = 10;
probeCurv.fov = 74.5;
probeCurv.aprSz = 8*times;
probeCurv.pitch = 0.21/times;
probeCurv.sp = sos;

if load == 1
    [ ~, imageData ] = getAllIGTLFolders( folder );
    [ eqIm ] = equalizeAllImages( imageData );
    n = length(eqIm);
    for i = 1:length(eqIm)
        %     for i = 1:20
        %         sumEqIm{i} = sum(eqIm{i},3);
        %         envSumIm{i} = abs(hilbert(sumEqIm{i}));
        %         sumCurvIm{i} = envSumIm{i}(:,1:64);
        %         sumLinIm{i} = envSumIm{i}(:,65:end);
        
        clear LCurv
        for j = 1:size(eqIm{i},3)
            tempIm = abs(hilbert(double(eqIm{i}(:,:,j))));
            tempIm = tempIm(:,1:64);
            [ ~, temp{j}, ~ ] = getAllWavefrontPeaks( tempIm );
            LCurv(j) = temp{j};
        end
        clear temp
        [c, d] = min(LCurv);
        rfIm{i} = eqIm{i}(:,:,d);
        %         envIm{i} = abs(hilbert(double(eqIm{i}(:,:,10))));
        %         envCurvIm{i} = envIm{i}(:,1:64);
        %         envLinIm{i} = envIm{i}(:,65:end);
        curvIm{i} = resample(double(rfIm{i}(:,1:64)'),times,1)';
        linIm{i} = rfIm{i}(:,65:end);
        
        %         [ cLinSum{i}, LLinSum{i}, wLinSum{i} ] = getAllWavefrontPeaks( sumLinIm{i} );
        %         [ cCurvSum{i}, LCurvSum{i}, wCurvSum{i} ] = getAllWavefrontPeaks( sumCurvIm{i} );
        %
        %         if figLin == 1
        %             figure;
        %             imagesc(sumLinIm{i});
        %             hold on;
        %             plot(wLinSum{i}{1},'.w');
        %             plot(cLinSum{i},LLinSum{i},'*k');
        %         end
        %         if figCurv == 1
        %             figure;
        %             imagesc(sumCurvIm{i});
        %             hold on;
        %             plot(wCurvSum{i}{1},'.w');
        %             plot(cCurvSum{i},lCurvSum{i},'*k');
        %         end
        
        %         for j = 1:size(eqIm{i},3)
        %             [ cLin{i}{j}, LLin{i}{j}, wLin{i}{j} ] = getAllWavefrontPeaks( linIm{i}(:,:,j) );
        %             [ cCurv{i}{j}, LCurv{i}{j}, wCurv{i}{j} ] = getAllWavefrontPeaks( curvIm{i}(:,:,j) );
        %         end
        
        %         [ cLin{i}, LLin{i}, wLin{i} ] = getAllWavefrontPeaks( linIm{i} );
        
        %         [ cCurv{i}, LCurv{i}, wCurv{i} ] = getAllWavefrontPeaks( envCurvIm{i} );
    end
end
clear imageData eqIm

if bf == 1
    for i = 1:n
%         out = DAS_single_x3apt(linIm{i}, no_ele, probeLin.pitch, probeLin.sp,times,expandApt);
%         [b,a]=butter(2,[.05 .95]);
%         filtered=filter(b,a,out);
%         bfLin{i}=abs(hilbert(filtered));

        cent = FastPeakFind(bfLin{i},max(max(bfLin{i}))*0.8,1,1,2);
        
        maxVals(i) = max(max(bfLin{i}));
        latLin(i) = cent(1);
        axLin(i) = cent(2);
        
        
%         outCurv = beamform_Convex(double(curvIm{i}), probeCurv);
%         [b,a]=butter(2,[.05 .95]);
%         filtered=filter(b,a,outCurv);
%         bfCurv{i}=abs(hilbert(filtered));
        
        cent = FastPeakFind(bfCurv{i},max(max(bfCurv{i}))*0.8,1,1,2);
        
        latCurv(i) = cent(1);
        axCurv(i) = cent(2);
%         [vals, ind] = max(bfCurv{i});
%         [maxVals(i), latCurv(i)] = max(vals);
%         axCurv(i) = ind(latCurv(i));
    end
end

% pCurv = T*pLin;
T = [0 0 -1 0;0 1 0 8;1 0 0 5;0 0 0 1];
clear distCurv ang pCurv
for i = 1:n
    %     distCurv(i) = 1000*LCurv{i}/samp*probeCurv.sp+probeCurv.radius;
    %   ang(i) = (cCurv{i}-(probeCurv.numEle/2+0.5))*probeCurv.fov/probeCurv.numEle;
    distCurv(i) = 1000*axCurv(i)/samp*probeCurv.sp+probeCurv.radius;
    ang(i) = (latCurv(i)-(probeCurv.numEle/2+0.5))*probeCurv.fov/probeCurv.numEle;
    
    pCurv(:,i) = [distCurv(i)*sind(ang(i));distCurv(i)*cosd(ang(i));probeLin.pitch*(latLin(i)/times-no_ele)+T(3,4)];
end

