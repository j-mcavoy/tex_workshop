% part_3.m

subject_range=[1 40];
dct_coef = 70;
[trdata_raw,trclass]=face_recog_knn_train(subject_range,dct_coef)

trdata_raw
