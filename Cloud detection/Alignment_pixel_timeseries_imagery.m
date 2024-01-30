%% Registration for using multitemporal images
%% written by Y. Yun 
function [resolu,jiUL,jiLR,zc] = Alignment_pixel_timeseries_imagery(imf)
global oldFolder
global num_t
cd (oldFolder);
% Searching each image range
ULx=zeros(length(num_t),1); ULy=zeros(length(num_t),1);
LRx=zeros(length(num_t),1); LRy=zeros(length(num_t),1);
for i=1:length(num_t)
    cd (imf(i).name);
    [im,jiDim,jiUL,jiLR,resolu,ZC]=enviread([imf(i).name,'_TOAstack']);
    ULx(i,1)=jiUL(1);ULy(i,1)=jiUL(2);
    LRx(i,1)=jiLR(1);LRy(i,1)=jiLR(2);
    UL=[min(ULx), max(ULy)];LR=[max(LRx), min(LRy)];
    cd(oldFolder);
end

% Calculate image range difference
calULx=zeros(length(num_t),1); calULy=zeros(length(num_t),1);
calLRx=zeros(length(num_t),1); calLRy=zeros(length(num_t),1);
for i=1:length(num_t)
    cd (imf(i).name);
    calULx(i,1)=ULx(i,1)-UL(1,1);
    calULy(i,1)=ULy(i,1)-UL(1,2);
    calLRx(i,1)=LRx(i,1)-LR(1,1);
    calLRy(i,1)=LRy(i,1)-LR(1,2);
    cd(oldFolder);
end

% % Info coordinates per pixel
% px=(LRx(1,1)-ULx(1,1))/jiDim(1,2);
% py=(ULy(1,1)-LRy(1,1))/jiDim(1,1);

% Set the image range to be regenerated
x=LR(1,1)-UL(1,1);
y=UL(1,2)-LR(1,2);
rm=max(abs(calULx(1,1)))+max(abs(calLRx(1,1))); cm=max(abs(calULy(1,1)))+max(abs(calLRy(1,1)));
sizex=x/30+rm/30+1; sizey=y/30+cm/30+1; % spatial resolution 30m

% Create a new image by finding the coordinates corresponding to the original image (1,1) position
for i=1:length(num_t) 
    cd(imf(i).name);
    [TOAstack,jiDim,jiUL,jiLR,resolu,zc]=enviread([imf(i).name,'_TOAstack']);
    [row,column,band]=size(TOAstack);
    for j=1:band
        ex_TOA = ['TOA',num2str(j),'=TOAstack(:,:,j);'];
        eval(ex_TOA)
        if j==9
            band9 = ones(ceil(sizey),ceil(sizex))*255;
        else
            ex_band= ['band',num2str(j),'=NaN(ceil(sizey),ceil(sizex));'];
            eval(ex_band)
        end
    end

    for p=1:row
        for q=1:column
            band1(p+abs(cm)/30,q+abs(rm)/30)=TOA1(p,q);
            band2(p+abs(cm)/30,q+abs(rm)/30)=TOA2(p,q);
            band3(p+abs(cm)/30,q+abs(rm)/30)=TOA3(p,q);
            band4(p+abs(cm)/30,q+abs(rm)/30)=TOA4(p,q);
            band5(p+abs(cm)/30,q+abs(rm)/30)=TOA5(p,q);
            band6(p+abs(cm)/30,q+abs(rm)/30)=TOA6(p,q);
            band7(p+abs(cm)/30,q+abs(rm)/30)=TOA7(p,q);
            band8(p+abs(cm)/30,q+abs(rm)/30)=TOA8(p,q);
            band9(p+abs(cm)/30,q+abs(rm)/30)=TOA9(p,q);
        end
    end

    for j=1:band
        eval(['NewTOAstack(:,:,j)' '=band' num2str(j) ';']);
        for a = 1:row
            for b = 1: column
                if NewTOAstack(a,b,j)==0
                    NewTOAstack(a,b,j)=NaN;
                end
            end
        end
    end

    enviwrite([imf(i).name,'_TOAstack_Regis'],NewTOAstack,'uint16',resolu,jiUL,jiLR,'bip',zc);
    fprintf("Generate New image %dth...\n", i);
    cd(oldFolder);
end
end