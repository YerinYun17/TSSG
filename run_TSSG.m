%% run_TSSG 
%% written by Y. Yun 
addpath(genpath('E:\Data\Cloud\Landsat08\DATA\UsedCode\MATLAB\TSSG'));
global oldFolder
oldFolder = 'E:\Data\Cloud\Landsat08\DATA\UsedCode\MATLAB\TSSG\Sample file\Test data';
cd(oldFolder);
clc;close all;clear;

global num_t
start_n='LC';
imf=dir([start_n, '*']);
last_folder=size(imf,1);
n_start=1;
n_end=last_folder;
num_t=n_start:n_end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial Detection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use downloaded Landsat image file (sample_file)
% Read Landsat dataset and transfer DN value to TOA value
% Initial cloud detection using QA band detection function
% and save restored image in each image folder named '*_TOAstack'

Landsat_Initial_detect_Allband(imf,num_t)

% apply simulate cloud in one image (Target image)
% Landsat_Initial_detect_Allband_simulatecloud(imf,num_t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Registration for using multitemporal images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read TOA stacking band images
% Alignment pixels
% save new images in each image folder named '*_TOAstack_Regis'

[resolu,jiUL,jiLR,zc] = Alignment_pixel_timeseries_imagery(imf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TSSG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time-series image restoration
% After designating several images in the folder as the target image starting with the first one 
% and designating the rest as the reference image, restoring the image cloud area is performed.

% restoring cloud region in each image 
% and save restored image in each image folder named '*_restored_image'

for i=1:length(num_t)
    file_name = '_TOAstack_Regis';
    eval(['Target' '=enviread([imf(i).name,file_name]);']);
    if i==1
        for k=i+1:length(num_t)
%             eval(['Ref' num2str(k-1) '=enviread([imf(k).name,file_name]);']);
            eval(sprintf('Ref%d = enviread([imf(%d).name,file_name]);', k-1, k));
        end
    else
        for k=1:i-1
%             eval(['Ref' num2str(k) '=enviread([imf(k).name,file_name]);']);
            eval(sprintf('Ref%d = enviread([imf(%d).name,file_name]);', k, k));
        end
        for k=i+1:length(num_t)
%             eval(['Ref' num2str(k-1) '=enviread([imf(k).name,file_name]);']);
            eval(sprintf('Ref%d = enviread([imf(%d).name,file_name]);', k-1, k));
        end
    end
    [restored_image]=Find_TSSG(Target, Ref1, Ref2, Ref3, Ref4, Ref5, Ref6, Ref7, Ref8);
    cd(oldFolder);
    cd (imf(i).name);
    enviwrite([imf(t).name,'_restored_image'],restored_image,'uint16',resolu,jiUL,jiLR,'bsq',zc);
end
