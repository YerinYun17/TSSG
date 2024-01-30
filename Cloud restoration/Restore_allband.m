function[restored_image]=Restore_allband(croprow,cropcol,cropsize1,cropsize2,Ref1,Ref2,Ref3,Ref4,Ref5,Ref6,Ref7,Ref8,Target,K,L,cloudmap,cloudmapRef1,cloudmapRef2,cloudmapRef3,cloudmapRef4,cloudmapRef5,cloudmapRef6,cloudmapRef7,cloudmapRef8,cloudRef1,cloudRef2,cloudRef3,cloudRef4,cloudRef5,cloudRef6,cloudRef7,cloudRef8,opp_num_image);
global num_t

for j=1:length(num_t)-1
    for i=1:9
        eval(['Ref' num2str(j) num2str(i) '=imcrop(double(Ref' num2str(j) '(:,:,i)),[croprow,cropcol,cropsize1,cropsize2]);']);
    end
end
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
[a,b]=size(Ref11);


figure,imshow(Target2*5,[]);title('band2-original');
figure,imshow(Target3*5,[]);title('band3-original');
figure,imshow(Target4*5,[]);title('band4-original');
TargetRGB(:,:,1)=Target2;TargetRGB(:,:,2)=Target3;TargetRGB(:,:,3)=Target4;
figure,imshow(TargetRGB*4,[]);title('original image');
for i=1:a
    for j=1:b
        if cloudmap(i,j)==1
            Target1(i,j)=255;
            Target2(i,j)=255;
            Target3(i,j)=255;
            Target4(i,j)=255;
            Target5(i,j)=255;
            Target6(i,j)=255;
            Target7(i,j)=255;
        end
    end
end
figure,imshow(Target2*5,[]);title('band2-original');
figure,imshow(Target3*5,[]);title('band3-original');
figure,imshow(Target4*5,[]);title('band4-original');
TargetRGB(:,:,1)=Target2;TargetRGB(:,:,2)=Target3;TargetRGB(:,:,3)=Target4;
figure,imshow(TargetRGB,[]); title('cloud removal image');


tic
for i = 1:length(K) % TSSG extraction and restoration value substitution for each cloud pixel
    dif11=original_point11(i,1)-Ref11; % Ref1 generate difference image
    dif11=dif11.*cloudRef1; % For cloud pixels, multiply by 0 and substitute 0
    dif21=original_point21(i,1)-Ref21; % Ref2 generate difference image
    dif21=dif21.*cloudRef2;
    dif31=original_point31(i,1)-Ref31; % Ref3 generate difference image
    dif31=dif31.*cloudRef3;
    dif41=original_point41(i,1)-Ref41; % Ref4 generate difference image
    dif41=dif41.*cloudRef4;
    dif51=original_point51(i,1)-Ref51; % Ref5 generate difference image
    dif51=dif51.*cloudRef5; 
    dif61=original_point61(i,1)-Ref61; % Ref6 generate difference image
    dif61=dif61.*cloudRef6;
    dif71=original_point71(i,1)-Ref71; % Ref7 generate difference image
    dif71=dif71.*cloudRef7;
    dif81=original_point81(i,1)-Ref81; % Ref8 generate difference image
    dif81=dif81.*cloudRef8;
    
    dif12=original_point12(i,1)-Ref12;
    dif12=dif12.*cloudRef1;
    dif22=original_point22(i,1)-Ref22;
    dif22=dif22.*cloudRef2;
    dif32=original_point32(i,1)-Ref32;
    dif32=dif32.*cloudRef3;
    dif42=original_point42(i,1)-Ref42; 
    dif42=dif42.*cloudRef4;
    dif52=original_point52(i,1)-Ref52;
    dif52=dif52.*cloudRef5; 
    dif62=original_point62(i,1)-Ref62;
    dif62=dif62.*cloudRef6;
    dif72=original_point72(i,1)-Ref72; 
    dif72=dif72.*cloudRef7;
    dif82=original_point82(i,1)-Ref82;
    dif82=dif82.*cloudRef8;
    
    dif13=original_point13(i,1)-Ref13; 
    dif13=dif13.*cloudRef1;
    dif23=original_point23(i,1)-Ref23; 
    dif23=dif23.*cloudRef2;
    dif33=original_point33(i,1)-Ref33; 
    dif33=dif33.*cloudRef3;
    dif43=original_point43(i,1)-Ref43; 
    dif43=dif43.*cloudRef4;
    dif53=original_point53(i,1)-Ref53; 
    dif53=dif53.*cloudRef5; 
    dif63=original_point63(i,1)-Ref63;
    dif63=dif63.*cloudRef6;
    dif73=original_point73(i,1)-Ref73;
    dif73=dif73.*cloudRef7;
    dif83=original_point83(i,1)-Ref83; 
    dif83=dif83.*cloudRef8;
    
    dif14=original_point14(i,1)-Ref14; 
    dif14=dif14.*cloudRef1; 
    dif24=original_point24(i,1)-Ref24; 
    dif24=dif24.*cloudRef2;
    dif34=original_point34(i,1)-Ref34;
    dif34=dif34.*cloudRef3;
    dif44=original_point44(i,1)-Ref44; 
    dif44=dif44.*cloudRef4;
    dif54=original_point54(i,1)-Ref54; 
    dif54=dif54.*cloudRef5; 
    dif64=original_point64(i,1)-Ref64;
    dif64=dif64.*cloudRef6;
    dif74=original_point74(i,1)-Ref74; 
    dif74=dif74.*cloudRef7;
    dif84=original_point84(i,1)-Ref84; 
    dif84=dif84.*cloudRef8;
    
    dif15=original_point15(i,1)-Ref15; 
    dif15=dif15.*cloudRef1;
    dif25=original_point25(i,1)-Ref25;
    dif25=dif25.*cloudRef2;
    dif35=original_point35(i,1)-Ref35; 
    dif35=dif35.*cloudRef3;
    dif45=original_point45(i,1)-Ref45;
    dif45=dif45.*cloudRef4;
    dif55=original_point55(i,1)-Ref55;
    dif55=dif55.*cloudRef5; 
    dif65=original_point65(i,1)-Ref65;
    dif65=dif65.*cloudRef6;
    dif75=original_point75(i,1)-Ref75;
    dif75=dif75.*cloudRef7;
    dif85=original_point85(i,1)-Ref85; 
    dif85=dif85.*cloudRef8;
    
    dif16=original_point16(i,1)-Ref16;
    dif16=dif16.*cloudRef1; 
    dif26=original_point26(i,1)-Ref26; 
    dif26=dif26.*cloudRef2;
    dif36=original_point36(i,1)-Ref36; 
    dif36=dif36.*cloudRef3;
    dif46=original_point46(i,1)-Ref46;
    dif46=dif46.*cloudRef4;
    dif56=original_point56(i,1)-Ref56;
    dif56=dif56.*cloudRef5; 
    dif66=original_point66(i,1)-Ref66; 
    dif66=dif66.*cloudRef6;
    dif76=original_point76(i,1)-Ref76; 
    dif76=dif76.*cloudRef7;
    dif86=original_point86(i,1)-Ref86; 
    dif86=dif86.*cloudRef8;
    
    dif17=original_point17(i,1)-Ref17; 
    dif17=dif17.*cloudRef1;
    dif27=original_point27(i,1)-Ref27; 
    dif27=dif27.*cloudRef2;
    dif37=original_point37(i,1)-Ref37; 
    dif37=dif37.*cloudRef3;
    dif47=original_point47(i,1)-Ref47; 
    dif47=dif47.*cloudRef4;
    dif57=original_point57(i,1)-Ref57; 
    dif57=dif57.*cloudRef5; 
    dif67=original_point67(i,1)-Ref67; 
    dif67=dif67.*cloudRef6;
    dif77=original_point77(i,1)-Ref77;
    dif77=dif77.*cloudRef7;
    dif87=original_point87(i,1)-Ref87; 
    dif87=dif87.*cloudRef8;
    
    dif18=original_point18(i,1)-Ref18;
    dif18=dif18.*cloudRef1;
    dif28=original_point28(i,1)-Ref28; 
    dif28=dif28.*cloudRef2;
    dif38=original_point38(i,1)-Ref38; 
    dif38=dif38.*cloudRef3;
    dif48=original_point48(i,1)-Ref48; 
    dif48=dif48.*cloudRef4;
    dif58=original_point58(i,1)-Ref58; 
    dif58=dif58.*cloudRef5; 
    dif68=original_point68(i,1)-Ref68; 
    dif68=dif68.*cloudRef6;
    dif78=original_point78(i,1)-Ref78; 
    dif78=dif78.*cloudRef7;
    dif88=original_point88(i,1)-Ref88;
    dif88=dif88.*cloudRef8;
    
    
    p_dif1=(dif11.^2)+(dif21.^2)+(dif31.^2)+(dif41.^2)+(dif51.^2)+(dif61.^2)+(dif71.^2)+(dif81.^2);
    p_dif2=(dif12.^2)+(dif22.^2)+(dif32.^2)+(dif42.^2)+(dif52.^2)+(dif62.^2)+(dif72.^2)+(dif82.^2);
    p_dif3=(dif13.^2)+(dif23.^2)+(dif33.^2)+(dif43.^2)+(dif53.^2)+(dif63.^2)+(dif73.^2)+(dif83.^2);
    p_dif4=(dif14.^2)+(dif24.^2)+(dif34.^2)+(dif44.^2)+(dif54.^2)+(dif64.^2)+(dif74.^2)+(dif84.^2);
    p_dif5=(dif15.^2)+(dif25.^2)+(dif35.^2)+(dif45.^2)+(dif55.^2)+(dif65.^2)+(dif75.^2)+(dif85.^2);
    p_dif6=(dif16.^2)+(dif26.^2)+(dif36.^2)+(dif46.^2)+(dif56.^2)+(dif66.^2)+(dif76.^2)+(dif86.^2);
    p_dif7=(dif17.^2)+(dif27.^2)+(dif37.^2)+(dif47.^2)+(dif57.^2)+(dif67.^2)+(dif77.^2)+(dif87.^2);
    p_dif8=(dif18.^2)+(dif28.^2)+(dif38.^2)+(dif48.^2)+(dif58.^2)+(dif68.^2)+(dif78.^2)+(dif88.^2);


    %%%%%%%%%%%%%%%%%% band1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif1=p_dif1./opp_num_image;
    h=3000; % h:ssg ratio
    f_dif1_reshape=reshape(f_dif1,a*b,1);
    f_dif1_reshape=rmmissing(f_dif1_reshape);
    f_dif1_reshape=sort(f_dif1_reshape);
    max_TSSG_value1 = f_dif1_reshape(h,1);    
    [TSSG_row1,TSSG_col1]=find(f_dif1<max_TSSG_value1);
    TSSG1(:,1)=TSSG_row1;TSSG1(:,2)=TSSG_col1;
    TSSG_number1=length(TSSG1);

    n=1;
    for m=1:TSSG_number1
        if m<TSSG_number1-n 
            if cloudmap(TSSG1(m,1),TSSG1(m,2))==1
                TSSG1(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG1(m,1),TSSG1(m,2))==4
                TSSG1(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG1(m,1),TSSG1(m,2))==4
                TSSG1(m,:)=[];
                n=n+1;
            end
        end
    end
    
    % Final TSSG location pixel average value calculation in target image
    TSSG_number1=length(TSSG1);    
    for m=1:TSSG_number1
        TSSG1(m,3)=Target1(TSSG1(m,1),TSSG1(m,2));         
    end
    mean_value1=mean(TSSG1);
    mean_value1=mean_value1(:,3);
    % restore
    Target1(K(i,1),L(i,1))=mean_value1;
    Targetnew1=Target1;
%     
    %%%%%%%%%%%%%%%%%% band2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif2=p_dif2./opp_num_image; 
    f_dif2_reshape=reshape(f_dif2,a*b,1);
    f_dif2_reshape=rmmissing(f_dif2_reshape);
    f_dif2_reshape=sort(f_dif2_reshape);
    max_TSSG_value2 = f_dif2_reshape(h,1);    
    [TSSG_row2,TSSG_col2]=find(f_dif2<max_TSSG_value2);
    TSSG2(:,1)=TSSG_row2;TSSG2(:,2)=TSSG_col2;
    TSSG_number2=length(TSSG2);

    n=1;
    for m=1:TSSG_number2
        if m<TSSG_number2-n 
            if cloudmap(TSSG2(m,1),TSSG2(m,2))==1
                TSSG2(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG2(m,1),TSSG2(m,2))==4
                TSSG2(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG2(m,1),TSSG2(m,2))==4
                TSSG2(m,:)=[];
                n=n+1;
            end
        end
    end
 % Final TSSG location pixel average value calculation in target image
    TSSG_number2=length(TSSG2);    
    for m=1:TSSG_number2
        TSSG2(m,3)=Target2(TSSG2(m,1),TSSG2(m,2));         
    end
    mean_value2=mean(TSSG2);
    mean_value2=mean_value2(:,3);
    % restore
    Target2(K(i,1),L(i,1))=mean_value2;
    Targetnew2=Target2;
    
    %%%%%%%%%%%%%%%%%% band3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif3=p_dif3./opp_num_image;
    f_dif3_reshape=reshape(f_dif3,a*b,1);
    f_dif3_reshape=rmmissing(f_dif3_reshape);
    f_dif3_reshape=sort(f_dif3_reshape);
    max_TSSG_value3 = f_dif3_reshape(h,1);    
    [TSSG_row3,TSSG_col3]=find(f_dif3<max_TSSG_value3);
    TSSG3(:,1)=TSSG_row3;TSSG3(:,2)=TSSG_col3;
    TSSG_number3=length(TSSG3);

    n=1;
    for m=1:TSSG_number3
        if m<TSSG_number3-n 
            if cloudmap(TSSG3(m,1),TSSG3(m,2))==1
                TSSG3(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG3(m,1),TSSG3(m,2))==4
                TSSG3(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG3(m,1),TSSG3(m,2))==4
                TSSG3(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number3=length(TSSG3);    
    for m=1:TSSG_number3
        TSSG3(m,3)=Target3(TSSG3(m,1),TSSG3(m,2));         
    end
    mean_value3=mean(TSSG3);
    mean_value3=mean_value3(:,3);
    % restore
    Target3(K(i,1),L(i,1))=mean_value3;
    Targetnew3=Target3;
    
    %%%%%%%%%%%%%%%%%% band4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif4=p_dif4./opp_num_image;
    f_dif4_reshape=reshape(f_dif4,a*b,1);
    f_dif4_reshape=rmmissing(f_dif4_reshape);
    f_dif4_reshape=sort(f_dif4_reshape);
    max_TSSG_value4 = f_dif4_reshape(h,1);    
    [TSSG_row4,TSSG_col4]=find(f_dif4<max_TSSG_value4);
    TSSG4(:,1)=TSSG_row4;TSSG4(:,2)=TSSG_col4;
    TSSG_number4=length(TSSG4);

    n=1;
    for m=1:TSSG_number4
        if m<TSSG_number4-n 
            if cloudmap(TSSG4(m,1),TSSG4(m,2))==1
                TSSG4(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG4(m,1),TSSG4(m,2))==4
                TSSG4(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG4(m,1),TSSG4(m,2))==4
                TSSG4(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number4=length(TSSG4);    
    for m=1:TSSG_number4
        TSSG4(m,3)=Target4(TSSG4(m,1),TSSG4(m,2));         
    end
    mean_value4=mean(TSSG4);
    mean_value4=mean_value4(:,3);
    % restore
    Target4(K(i,1),L(i,1))=mean_value4;
    Targetnew4=Target4; 
    
    %%%%%%%%%%%%%%%%%% band5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif5=p_dif5./opp_num_image;
    f_dif5_reshape=reshape(f_dif5,a*b,1);
    f_dif5_reshape=rmmissing(f_dif5_reshape);
    f_dif5_reshape=sort(f_dif5_reshape);
    max_TSSG_value5 = f_dif5_reshape(h,1);    
    [TSSG_row5,TSSG_col5]=find(f_dif5<max_TSSG_value5);
    TSSG5(:,1)=TSSG_row5;TSSG5(:,2)=TSSG_col5;
    TSSG_number5=length(TSSG5);

    n=1;
    for m=1:TSSG_number5
        if m<TSSG_number5-n 
            if cloudmap(TSSG5(m,1),TSSG5(m,2))==1
                TSSG5(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG5(m,1),TSSG5(m,2))==4
                TSSG5(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG5(m,1),TSSG5(m,2))==4
                TSSG5(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number5=length(TSSG5);    
    for m=1:TSSG_number5
        TSSG5(m,3)=Target5(TSSG5(m,1),TSSG5(m,2));         
    end
    mean_value5=mean(TSSG5);
    mean_value5=mean_value5(:,3);
    % restore
    Target5(K(i,1),L(i,1))=mean_value5;
    Targetnew5=Target5; 
    
    %%%%%%%%%%%%%%%%%% band6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif6=p_dif6./opp_num_image;
    f_dif6_reshape=reshape(f_dif6,a*b,1);
    f_dif6_reshape=rmmissing(f_dif6_reshape);
    f_dif6_reshape=sort(f_dif6_reshape);
    max_TSSG_value6 = f_dif6_reshape(h,1);    
    [TSSG_row6,TSSG_col6]=find(f_dif6<max_TSSG_value6);
    TSSG6(:,1)=TSSG_row6;TSSG6(:,2)=TSSG_col6;
    TSSG_number6=length(TSSG6);

    n=1;
    for m=1:TSSG_number6
        if m<TSSG_number6-n 
            if cloudmap(TSSG6(m,1),TSSG6(m,2))==1
                TSSG6(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG6(m,1),TSSG6(m,2))==4
                TSSG6(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG6(m,1),TSSG6(m,2))==4
                TSSG6(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number6=length(TSSG6);    
    for m=1:TSSG_number6
        TSSG6(m,3)=Target6(TSSG6(m,1),TSSG6(m,2));         
    end
    mean_value6=mean(TSSG6);
    mean_value6=mean_value6(:,3);
    % restore
    Target6(K(i,1),L(i,1))=mean_value6;
    Targetnew6=Target6; 
    
    %%%%%%%%%%%%%%%%%% band7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif7=p_dif7./opp_num_image;
    f_dif7_reshape=reshape(f_dif7,a*b,1);
    f_dif7_reshape=rmmissing(f_dif7_reshape);
    f_dif7_reshape=sort(f_dif7_reshape);
    max_TSSG_value7 = f_dif7_reshape(h,1);    
    [TSSG_row7,TSSG_col7]=find(f_dif7<max_TSSG_value7);
    TSSG7(:,1)=TSSG_row7;TSSG7(:,2)=TSSG_col7;
    TSSG_number7=length(TSSG7);

    n=1;
    for m=1:TSSG_number7
        if m<TSSG_number7-n 
            if cloudmap(TSSG7(m,1),TSSG7(m,2))==1
                TSSG7(m,:)=[];
                n=n+1;
            elseif cloudmapRef1(TSSG7(m,1),TSSG7(m,2))==4
                TSSG7(m,:)=[];
                n=n+1;
            elseif cloudmapRef2(TSSG7(m,1),TSSG7(m,2))==4
                TSSG7(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number7=length(TSSG7);    
    for m=1:TSSG_number7
        TSSG7(m,3)=Target7(TSSG7(m,1),TSSG7(m,2));         
    end
    mean_value7=mean(TSSG7);
    mean_value7=mean_value7(:,3);
    % restore
    Target7(K(i,1),L(i,1))=mean_value7;
    Targetnew7=Target7; 
    
    %%%%%%%%%%%%%%%%%% band8%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_dif8=p_dif8./opp_num_image;
    f_dif8_reshape=reshape(f_dif8,a*b,1);
    f_dif8_reshape=rmmissing(f_dif8_reshape);
    f_dif8_reshape=sort(f_dif8_reshape);
    max_TSSG_value8 = f_dif8_reshape(h,1);    
    [TSSG_row8,TSSG_col8]=find(f_dif8<max_TSSG_value8);
    TSSG8(:,1)=TSSG_row8;TSSG8(:,2)=TSSG_col8;
    TSSG_number8=length(TSSG8);

    n=1;
    for m=1:TSSG_number8
        if m<TSSG_number8-n
            if cloudmap(TSSG8(m,1),TSSG8(m,2))==1
                TSSG8(m,:)=[];
                n=n+1;
            end
        end
    end
% Final TSSG location pixel average value calculation in target image
    TSSG_number8=length(TSSG8);    
    for m=1:TSSG_number8
        TSSG8(m,3)=Target8(TSSG8(m,1),TSSG8(m,2));         
    end
    mean_value8=mean(TSSG8);
    mean_value8=mean_value8(:,3);
    % restore
    Target8(K(i,1),L(i,1))=mean_value8;
    Targetnew8=Target8; 
    
    TSSG1=[];TSSG2=[];TSSG3=[];TSSG4=[];TSSG5=[];TSSG6=[];TSSG7=[];TSSG8=[];
    f_dif1=[];f_dif2=[];f_dif3=[];f_dif4=[];f_dif5=[];f_dif6=[];f_dif7=[];f_dif8=[];
    fprintf('%dth\n',i);
end
toc

restored_image(:,:,1) = Targetnew1;
restored_image(:,:,2) = Targetnew2;
restored_image(:,:,3) = Targetnew3;
restored_image(:,:,4) = Targetnew4;
restored_image(:,:,5) = Targetnew5; 
restored_image(:,:,6) = Targetnew6; 
restored_image(:,:,7) = Targetnew7;
restored_image(:,:,8) = Targetnew8;
restored_image=uint16(restored_image);

figure,imshow(restored_image(:,:,[2,3,4])*4);

end