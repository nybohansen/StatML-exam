

[dataMatrix, classVector] = loadDataSet('../../Data/GTSRB_Features_HOG/training/HOG_01',1568,43);
save('../../Data/trainingData.mat', 'dataMatrix');
save('../../Data/trainingDataClasses.mat', 'classVector');


[dataMatrix, classVector] = loadDataSet('../../Data/GTSRB/Online-Test-sort/HOG/HOG_01',1568,43);
save('../../Data/testData.mat', 'dataMatrix');
save('../../Data/testDataClasses.mat', 'classVector');


%[dataMatrix, classVector] = loadDataSet('../../Data/GTSRB_Features_HOG/training/HOG_01',1568,43);
