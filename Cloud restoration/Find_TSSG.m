%% Spectral Similarity Group  512 - extended (2020.10.08)
%% Input data
% Target: cloud image to be restored
% Ref1 : 전시기 reference image 
% Ref2 : 후시기 reference image
% All images are seven bands and cloudmap)
%% Output
% restored_image: cloud-restored target image
%% 
function [restored_image]=Find_TSSG(Target, Ref1, Ref2, Ref3, Ref4, Ref5, Ref6, Ref7, Ref8)
% Extract bands
% Target9, Ref19, Ref29 ...9th band image : cloudmap(QAdetection result)

global oldFolder
global num_t

% define variable each images every band (*10000)
croprow=6000; cropcol=3000; cropsize1=1000; cropsize2=1000;
for j=1:length(num_t)-1
    for i=1:9
        eval(['Ref' num2str(j) num2str(i) '=imcrop(double(Ref' num2str(j) '(:,:,i)),[croprow,cropcol,cropsize1,cropsize2]);']);
    end
end

for i=1:9
    eval(['Target' num2str(i) '=imcrop(double(Target(:,:,i)),[croprow,cropcol,cropsize1,cropsize2]);']);
end
cloudmap=Target9;

for i=1:length(num_t)-1
    eval(['cloudmapRef' num2str(i) '=imcrop(double(Ref' num2str(i) '(:,:,9)),[croprow,cropcol,cropsize1,cropsize2]);']);
end

% remove small features
[r,c]=size(cloudmap);
for i=1:r
    for j=1:c
        if cloudmap(i,j)==2
            cloudmap(i,j)=0;
        end
    end
end
cloudmap = double(bwareaopen(cloudmap,10));
figure,imshow(uint16(cloudmap),[]);

% % dilate cloud
buffersize=1;
cloudmap=imdilate(cloudmap,strel('square',2*buffersize+1));
figure,imshow(cloudmap,[]);
[K,L]=find(cloudmap==1); % location of cloud pixels
cloudposi=[K,L];

%% 
% Save cloud pixel value variable of experiment image
for j=1:length(num_t)-1
    for i=1:length(K)
        eval(sprintf('cloud_point%d(%d,1)=Target%d(K(i,1),L(i,1));', j,i,j));
    end
end

% Store pixel value variables in the same location as the cloud pixels of the experimental image in the Ref image
for i=1:length(num_t)-1 % number of ref image
    for j=1:8 % band
        for k=length(K)
            eval(sprintf('original_point%d%d(%d,1)=Ref%d%d(K(%d,1),L(%d,1));',i,j,k,i,j,k,k));
        end
    end
end

for i=1:9
    eval(['Target' num2str(i) '=imcrop(uint16(65535*(double(double(Target(:,:,i))/max(max(double(Target(:,:,i))))))),[croprow,cropcol,cropsize1,cropsize2]);']);
end


for i=1:9
    eval(['Targetnew' num2str(i) '=imcrop(uint16(65535*(double(double(Target(:,:,i))/max(max(double(Target(:,:,i))))))),[croprow,cropcol,cropsize1,cropsize2]);']);
end

% TargetRGB(:,:,1)=Target2;TargetRGB(:,:,2)=Target3;TargetRGB(:,:,3)=Target4;
% TargetRGB=uint16(TargetRGB);
% figure,imshow(TargetRGB,[]);
% TargetRGB=[];

% Number of reference images that are not cloud pixels among 8 reference images Image generation (used to create the final difference image)
[a,b]=size(cloudmapRef1);
for i=1:length(num_t)-1 % number of reference images
    eval(['num' num2str(i) '=zeros(a,b);']);
end


for i=1:a
    for j=1:b
        if cloudmapRef1(i,j)==4 % if it is cloud pixel
            num1(i,j)=1; 
        elseif cloudmapRef1(i,j)==255 % if it is filled pixel
            num1(i,j)=NaN;
        end
        if cloudmapRef2(i,j)==4
            num2(i,j)=1;
        elseif cloudmapRef2(i,j)==255
            num2(i,j)=NaN;
        end
        if cloudmapRef3(i,j)==4
            num3(i,j)=1;
        elseif cloudmapRef3(i,j)==255
            num3(i,j)=NaN;
        end
        if cloudmapRef4(i,j)==4
            num4(i,j)=1;
        elseif cloudmapRef4(i,j)==255
            num4(i,j)=NaN;
        end
        if cloudmapRef5(i,j)==4
            num5(i,j)=1;
        elseif cloudmapRef5(i,j)==255
            num5(i,j)=NaN;
        end
        if cloudmapRef6(i,j)==4
            num6(i,j)=1;
        elseif cloudmapRef6(i,j)==255
            num6(i,j)=NaN;
        end
        if cloudmapRef7(i,j)==4
            num7(i,j)=1;
        elseif cloudmapRef7(i,j)==255
            num7(i,j)=NaN;
        end
        if cloudmapRef8(i,j)==4
            num8(i,j)=1;
        elseif cloudmapRef8(i,j)==255
            num8(i,j)=NaN;
        end
    end
end

for i=1:length(num_t)-1
    eval(['cloudRef' num2str(i) '=zeros(a,b);']);
end

for i=1:a
    for j=1:b
        if cloudmapRef1(i,j)==4
            cloudRef1(i,j)=0;
        elseif cloudmapRef1(i,j)==255
            cloudRef1(i,j)=NaN;
        else
            cloudRef1(i,j)=1;
        end
        if cloudmapRef2(i,j)==4
            cloudRef2(i,j)=0;
        elseif cloudmapRef2(i,j)==255
            cloudRef2(i,j)=NaN;
        else
            cloudRef2(i,j)=1;
        end
        if cloudmapRef3(i,j)==4
            cloudRef3(i,j)=0;
        elseif cloudmapRef3(i,j)==255
            cloudRef3(i,j)=NaN;
        else
            cloudRef3(i,j)=1;
        end
        if cloudmapRef4(i,j)==4
            cloudRef4(i,j)=0;
        elseif cloudmapRef4(i,j)==255
            cloudRef4(i,j)=NaN;
        else
            cloudRef4(i,j)=1;
        end
        if cloudmapRef5(i,j)==4
            cloudRef5(i,j)=0;
        elseif cloudmapRef5(i,j)==255
            cloudRef5(i,j)=NaN;
        else
            cloudRef5(i,j)=1;
        end
        if cloudmapRef6(i,j)==4
            cloudRef6(i,j)=0;
        elseif cloudmapRef6(i,j)==255
            cloudRef6(i,j)=NaN;
        else
            cloudRef6(i,j)=1;
        end
        if cloudmapRef7(i,j)==4
            cloudRef7(i,j)=0;
        elseif cloudmapRef7(i,j)==255
            cloudRef7(i,j)=NaN;
        else
            cloudRef7(i,j)=1;
        end
        if cloudmapRef8(i,j)==4
            cloudRef8(i,j)=0;
        elseif cloudmapRef8(i,j)==255
            cloudRef8(i,j)=NaN;
        else
            cloudRef8(i,j)=1;
        end
    end
end

% Adjustment according to the number of reference images

% 8
num_image=num1+num2+num3+num4+num5+num6+num7+num8;
opp_num_image=8.-num_image;

tic
[restored_image]=Restore_allband(croprow,cropcol,cropsize1,cropsize2,Ref1,Ref2,Ref3,Ref4,Ref5,Ref6,Ref7,Ref8,Target,K,L,cloudmap,cloudmapRef1,cloudmapRef2,cloudmapRef3,cloudmapRef4,cloudmapRef5,cloudmapRef6,cloudmapRef7,cloudmapRef8,cloudRef1,cloudRef2,cloudRef3,cloudRef4,cloudRef5,cloudRef6,cloudRef7,cloudRef8,opp_num_image);
toc
%%
end



