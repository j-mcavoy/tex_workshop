%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function
% [trdata_raw,trclass]=face_recog_knn_train
%                   (subject_range,dct_coef)
% Name: face_recog_knn_train
% Function: Create a matrix of training vectors from
%       training photos to be used for KNN recognition
%
% Input: subject_range - range of faces to be used,
%                       maximum is 40.
%                       Usually input as a vector.
%                       For example [1 29] means
%                       subjects 1 to 29 inclusive.
%                       The first entry must be a 1.
%
%       dct_coef - length of the feature DCT vector
%                       used for comparison
% Output:
%       trdata_raw - trainng data of DCT vectors
%       trclass - class labels for each training data
%       vector Run: Loop through the user defined
%       number of subjects wanted (defined in the
%       subject range) and create a matrix of length #
%       of subjects x length of DCT (defined by the
%       dct_coef).
% Output file: Mat file that includes the training
% vectors with corresponding labels. This file will be
% used in performance evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [trdata_raw,trclass]=...
face_recog_knn_train(subject_range,dct_coef)

% Assign the vector f_range to the range of subject
% specified by subject_range
f_range=subject_range(1):subject_range(2);

% Check if subject_range(1) = f_range(1) = 1
if (f_range(1) ~= 1)
  error('The first subject must have a label of 1');
end

% Assign the number of subjects to the length of
% f_range
nsubjects = length(f_range);

% Initialize trdata_raw and tr_class trdata is the
% training data matrix trclass is the vector of class
% labels associated with the training data
trdata_raw=[];
trclass=[];

% Loop through the number of subjects
for i=1:nsubjects

% Loop through the first five faces in the subject
% folders. In this experiment, the first five faces are
% used for training.
    for j=1:5

% Assign the filename for processing
        name = ['../att_faces/s'...
            num2str(f_range(i)) '/' num2str(j) '.pgm'];

% Run "findfeatures" which returns a DCT vector
% (face_feat) with the length defined in dct_coef.
        face_feat(j,:)=findfeatures(name,dct_coef);
    end

% Add the five face_feat vectors to the end of trdata_raw.
trdata_raw=[trdata_raw face_feat(1:5,:)'];

% Add the corresponding label for the five face_feat vectors.
trclass=[trclass i*ones(1,5)];

% End of for i=1:nsubjects loop
end

% Switch the columns and rows of trdata_raw and trclass
trdata_raw=trdata_raw';
trclass=trclass';

% Save the variables (dct_coef, f_range, nsubjects,
% trclass, trdata_raw
save ...
('raw_data.mat','dct_coef','f_range','nsubjects','trclass','trdata_raw');
