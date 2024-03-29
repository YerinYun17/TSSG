 function enviwrite(filename,envi_data,datatype,resolu,UL,LR,interleave,zone)
%  write envi format file of unit8 and int16 
%  for example: enviwrite('testzz',data,'int16',[30,30],jiUL,'bsq',ZC,'this is for test only');
%  i,j => x, y => rows and cols
%  Input  1)  'filename' is the name of the file
%  Input  2)  'envi_data' is the data matrix
%  Input  3)  'dataype' is the datatype to write 'unit8' or 'int16'
%  Input  4)  'resolu' is the resolution of the pixel
%  Input  5)  'UL' is the UpperLeftPoint X Y of the UL pixel (not center of UL pixel)
%  LR 임의 추가 (LowRightPoint X Y)
%  Input  6)  'interleave' is the bsq bip bil format
%  Input  7)  'zone' is the UTM zone


if strcmp(datatype,'uint8')
    envi_data=uint8(envi_data);
    dt=1;
elseif strcmp(datatype,'int16')
    envi_data=int16(envi_data);
    dt=2;
elseif strcmp(datatype,'uint16')
    envi_data=uint16(envi_data);
    dt=12;
elseif strcmp(datatype,'single')
    envi_data=single(envi_data);
    dt=4;
elseif strcmp(datatype,'double')
    envi_data=double(envi_data);
    dt=8;
else
    fprintf('Invalid write data type!\n');
    return;
end

n_dims=size(envi_data);

nrows=n_dims(1); 
ncols=n_dims(2); 
bands=1;

if length(n_dims)>=3
    bands=n_dims(3);
end

multibandwrite(envi_data,filename,interleave);

filename_hdr=[filename,'.hdr'];
                                
fid_out=fopen(filename_hdr,'wt');

fprintf(fid_out,'ENVI\n');
fprintf(fid_out,'descirption = {Tmask Version 1.0}\n');
fprintf(fid_out,'samples = %d\n',ncols); % samples is for j
fprintf(fid_out,'lines   = %d\n',nrows); % lines is for i
fprintf(fid_out,'bands   = %d\n',bands);
fprintf(fid_out,'header offset = 0\n');
fprintf(fid_out,'file type = ENVI Standard\n');
fprintf(fid_out,'data type = %d\n',dt);
fprintf(fid_out,'interleave = %s\n',interleave);
fprintf(fid_out,'sensor type = Landsat\n');
fprintf(fid_out,'byte order = 0\n');
if (zone > 0)
    fprintf(fid_out, 'map info = {UTM, 1.000, 1.000, %d, %d, %d, %d, %d, %d, %d, North, WGS-84, units=Meters}',UL(1),UL(2),LR(1),LR(2),resolu(1),resolu(2),zone);
else
    fprintf(fid_out, 'map info = {UTM, 1.000, 1.000, %d, %d, %d, %d, %d, %d, %d, South, WGS-84, units=Meters}',UL(1),UL(2),LR(1),LR(2),resolu(1),resolu(2),-zone);
end


fclose(fid_out);
end



