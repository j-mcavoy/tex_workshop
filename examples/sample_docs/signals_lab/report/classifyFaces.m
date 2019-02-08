% classifyFaces.m

function [kNN_identity, success_rate]...
= classifyFaces(dct_coef, k)

subject_range=[1 40];
f_range=subject_range(1):subject_range(2);
%dct_coef = k;
[trdata_raw,trclass]=face_recog_knn_train(subject_range,dct_coef);

correct = 0; % counts number of correct classifications
count = 0;

nsubjects = 40;

for i=1:nsubjects

 for j=6:10

  % Assign the filename for processing
  name = ['../att_faces/s'...
  num2str(f_range(i)) '/' num2str(j) '.pgm'];

  true_label = i;

  % Run "findfeatures" which returns a DCT vector (face_feat) with the
  % length defined in dct_coef.
  face_feat(j,:)=findfeatures(name,dct_coef);

  rawCopy = trdata_raw;
  nearest_classes = zeros(k,1);
  for x = 1:k
   IDx = knnsearch(rawCopy,face_feat(j,:));
   rawCopy(IDx, :) = []; % remove matched row
   nearest_classes(x) = trclass(IDx);
  end

  nearest_classes
  kNN_identity(count + 1) = mode(nearest_classes);

  if(kNN_identity(count+1) == true_label)
   correct = correct + 1;
  end

  count = count+1;
end
end
success_rate = correct / count;
