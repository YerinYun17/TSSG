%% Cloud detection using QA band 
%% written by Y. Yun 
function Landsat_Initial_detect_Allband(imf,num_t)
% Initial cloud detection
% save images and QAresult images at each Landsat data folder
global oldFolder
cd (oldFolder);
QA_PV = readtable('QA_Attribute_PixelValue.xlsx','Format','auto'); % version 2020
for i=1:length(num_t)
    cd(imf(i).name);
    % Landsat data loading
    MTLfilename=strcat(imf(i).name, '_MTL.txt');
    LandSatData=loadLandSat8(MTLfilename);
    jiUL=[LandSatData.BQAInfo.CornerCoords.X(1,1),LandSatData.BQAInfo.CornerCoords.Y(1,1)];
    jiLR=[LandSatData.BQAInfo.CornerCoords.X(1,3),LandSatData.BQAInfo.CornerCoords.Y(1,3)];
    resolu=[LandSatData.BQAInfo.PixelScale(1,1),LandSatData.BQAInfo.PixelScale(2,1)];
    zc=LandSatData.BQAInfo.Zone;
    
    % DN value -> TOA value
    Image=ToR_LandSat8(LandSatData, 'TOARef');
    QA=rmmissing(LandSatData.BQA);
    
    % Define cloud and shadow pixel in accordance with QA band cloud
    % confidence
    cloud=[QA_PV.Cloud_H; QA_PV.Cirrus_H;]; 
    shadow=[QA_PV.Shadow];

    % TOA value bands stacking
    for r=1:length(LandSatData.Band)-3
        if r==8
            TOAstack(:,:,r)=Image.TOARef{r+1,1}.*10000;
        else
            TOAstack(:,:,r)=Image.TOARef{r,1}.*10000;
        end
    end


    % Cloud detection using QA band
    QAresult=QAdetection(TOAstack,QA,QA_PV,cloud,shadow);
%     buffersize=2;
%     QAresult=imdilate(QAresult,strel('square',2*buffersize+1));
    TOAstack(:,:,9)=QAresult;
    
    enviwrite([imf(i).name,'_TOAstack'],TOAstack,'uint16',resolu,jiUL,jiLR,'bsq',zc);
    QAresult=[];TOAstack=[];
    fprintf("Initial detecting %dth...\n",i);
    cd(oldFolder);
end