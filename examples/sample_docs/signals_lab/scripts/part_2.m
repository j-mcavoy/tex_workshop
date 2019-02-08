% part_1.m
features_3_9 = [];
features_3_35 = [];
features_3_100 = [];

features_4_9 = [];
features_4_35 = [];
features_4_100 = [];

for i = 1:9
 subject = ['../att_faces/s3/', num2str(i), '.pgm'];
 features_3_9(i,:) = findfeatures(subject, 9);
 features_3_35(i,:) = findfeatures(subject, 35);
 features_3_100(i,:) = findfeatures(subject, 100);
end

for i = 1:9
 subject = ['../att_faces/s4/', num2str(i), '.pgm'];
 features_4_9(i,:) = findfeatures(subject, 9);
 features_4_35(i,:) = findfeatures(subject, 35);
 features_4_100(i,:) = findfeatures(subject, 100);
end


figure
hold on
title('FindFeatures Subject 3: DCT Length = 9');
for i = 1:9
 plot([1:9],features_3_9(i,:));
end
print ('../report/img/part_2_s_3_dct_9.eps', ... 
'-depsc', '-r100');
hold off
close all

figure
hold on
title('FindFeatures Subject 4: DCT Length = 9');
for i = 1:9
 plot([1:9],features_4_9(i,:));
end
print ('../report/img/part_2_s_4_dct_9.eps', ...
'-depsc', '-r100');
hold off
close all

figure
hold on
title('FindFeatures Subject 3: DCT Length = 35');
for i = 1:9
 plot([1:35],features_3_35(i,:));
end
print ('../report/img/part_2_s_3_dct_35.eps', ...
'-depsc', '-r100');
hold off
close all

figure
hold on
title('FindFeatures Subject 4: DCT Length = 35');
for i = 1:9
 plot([1:35],features_4_35(i,:));
end
print ('../report/img/part_2_s_4_dct_35.eps', ...
'-depsc', '-r100');
hold off
close all

figure
hold on
title('FindFeatures Subject 3: DCT Length = 100');
for i = 1:9
 plot([1:100],features_3_100(i,:));
end
print ('../report/img/part_2_s_3_dct_100.eps', ...
'-depsc', '-r100');
hold off
close all

figure
hold on
title('FindFeatures Subject 4: DCT Length = 100');
for i = 1:9
 plot([1:100],features_4_100(i,:));
end
print ('../report/img/part_2_s_4_dct_100.eps', ...
'-depsc', '-r100');
hold off
close all
