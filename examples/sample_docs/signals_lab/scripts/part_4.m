% part_4.m

data_points = []
count = 0;
for k_val = 1:1:7
 for dim_val = 25:5:100
  [kNN_identity, success_rate] = ...
  classifyFaces(dim_val, k_val)
  data_points(count + 1,:) = ...
  [dim_val, k_val, success_rate]
  count = count + 1;
 end
end

hold on
title("Feature Vector Dimentions vs K vs Success Rate");
xlabel("Feature Vector Dimentions");
ylabel("K");
zlabel("Success Rate");
scatter3(data_points(:,1), data_points(:,2), data_points(:,3))
print ('../report/img/part_4_3d_plot.eps', ...
'-depsc', '-r100');
hold off
close all
