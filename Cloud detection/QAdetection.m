function [cloudmap] = QAdetection(Tar, QA, QA_PV, cloud, shadow)

cloud = unique(cloud); 
for i = 1:size(cloud)
    for j = 1:size(QA_PV.Clear)
      if cloud(i,1)==QA_PV.Clear(j,1)
          cloud(i,1)=0;
      end
    end
end % remove Clear pixel

cloud = rmmissing(cloud);
shadow = rmmissing(shadow); % remove NaN

[row,col] = size(QA);
cloudmap=zeros(row,col);
for i = 1:row
    for j = 1:col
        if QA(i,j) == 1
            cloudmap(i,j) = 255; % fill
        end
    end
end % filled pixel

for i = 1:row
    for j = 1:col
        for a = 1:size(cloud)
            if QA(i,j) == cloud(a,1)
                cloudmap(i,j)=4; % cloud
            end
        end
        for a = 1:size(shadow)
            if QA(i,j) == shadow(a,1)
                cloudmap(i,j)=2; % shadow
            end
        end
    end
end
% figure, imshow(cloudmap);