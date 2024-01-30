%% simulate cloud using (roi.tif) and generate cloudmap
%% written by Y. Yun 
global oldFolder
cd (oldFolder);
QA_PV = readtable('QA_Attribute_PixelValue.xlsx','Format','auto'); % version 2020
for i=1:length(num_t)
    cd(oldFolder);
    cd(imf(i).name);
    MTLfilename=strcat(imf(i).name, '_MTL.txt');
    LandSatData=loadLandSat8(MTLfilename);
    jiUL=[LandSatData.BQAInfo.CornerCoords.X(1,1),LandSatData.BQAInfo.CornerCoords.Y(1,1)];
    jiLR=[LandSatData.BQAInfo.CornerCoords.X(1,3),LandSatData.BQAInfo.CornerCoords.Y(1,3)];
    resolu=[LandSatData.BQAInfo.PixelScale(1,1),LandSatData.BQAInfo.PixelScale(2,1)];
    zc=LandSatData.BQAInfo.Zone;
    
    % DN value -> TOA value
    Image=ToR_LandSat8(LandSatData, 'TOARef');
    QA=rmmissing(LandSatData.BQA);
    
    % Define cloud and shadow pixel
    cloud=[QA_PV.Cloud_H; QA_PV.Cloud_M; QA_PV.Cloud_L; QA_PV.Cirrus_H; QA_PV.Cirrus_L];
    shadow=[QA_PV.Shadow];
    
    % TOA value bands stacking
    for r=1:length(LandSatData.Band)-3
        if r==8
            TOAstack(:,:,r)=Image.TOARef{r+1,1}.*10000;
        else
            TOAstack(:,:,r)=Image.TOARef{r,1}.*10000;
        end
    end

    % Cloud detection using QA band + simulation cloud
    QAresult=QAdetection(TOAstack,QA,QA_PV,cloud,shadow);
    simulate=imread('simulate_cloud_new_classificationimage.tif');
    simulate=simulate(:,:,3);
    [r,c]=size(QAresult);

    for a=1:r
        for b=1:c
            if simulate(a,b)==255
                simulate(a,b)=4; % cloud
            elseif QAresult(a,b)==4
                simulate(a,b)=4; % cloud
            end
            if QAresult(a,b)==255
                simulate(a,b)=255; % fill
            end
        end
    end
    TOAstack(:,:,9)=simulate;
    
    enviwrite([imf(i).name,'_TOAstack'],TOAstack,'uint16',resolu,jiUL,jiLR,'bsq',zc);
    QAresult=[];TOAstack=[];
    fprintf("Initial detecting %dth...\n",i);
    cd(oldFolder);
end