% part_1.m
[img,map] = imread('../att_faces/s1/1.pgm');
img2dct=dct2(img);
imgrecover=idct2(img2dct);
% Compute and plot log magnitude of 2-D DCT
t1=0.01.*abs(img2dct);
t2=0.01*max(max(abs(img2dct)));
c_hat=255*(log10(1+t1)/log10(1+t2));

figure
hold on
imshow(img,map);
title('Face 1');
print ('../report/img/part_1_face.eps', '-deps',...
'-r100');
hold off
close all

figure
hold on
imshow(img2dct,map);
title('2D DCT Plot of Face 1');

print ('../report/img/part_1_dct.eps', '-deps',...
'-r100');
hold off
close all

figure
hold on
imshow(imgrecover,map);
title('Face 1 Recovered');
print ('../report/img/part_1_recovery.eps', '-deps',...
'-r100');
hold off
close all

figure
hold on
% Compute and plot log magnitude of 2-D DCT
t1=0.01.*abs(img2dct);
t2=0.01*max(max(abs(img2dct)));
c_hat=255*(log10(1+t1)/log10(1+t2));
imshow(c_hat,map);
title('Log Magnitude of 2-D DCT');
print ('../report/img/part_1_log_dct.eps', '-deps',...
'-r100');
hold off
close all
