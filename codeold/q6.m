%Q6 Knn on dataset

%clear all;
%close all;

%Setup
%Number of samples for each unique trafic sign
sampleSize = 30;
%number of subsets
k = 2;

%Load data and classes
%dataMatrix = load('../../Data/trainingData.mat');
%dataMatrix = dataMatrix.dataMatrix;
%classVector = load('../../Data/trainingDataClasses.mat');
%classVector = classVector.classVector;


%dataMatrix = dataMatrix(:,1:900);
%classVector = classVector(1:900,:);

%First row in data is now the class label
%each column underneath is the data sample
data = [classVector'; dataMatrix];

%Number of unique signs (Each sign has 30 samples)
N = size(data,2)/sampleSize;

%Generate cross validation dataset
%crossValClasses = crossvalind('Kfold',N,k);
%crossValClasses = repmat(crossValClasses',sampleSize,1);
%crossValClasses = crossValClasses(:);

K = 5;
error = [];
for i=1:k    
    %Fetch training set from cross validation classes
    trainingSetData = data(:,find(crossValClasses~=i));
    %Fetch test set from cross validation classes
    testSetData = data(:,find(crossValClasses==i));
    %Calculate the knn from all the elements in the test set giving
    %training set.
    e = knnHelper(trainingSetData(2:end,:),trainingSetData(1,:),testSetData, K);
    %Update error matrix, so we know how well we are doing
    error = [error; K, size(trainingSetData,2), size(testSetData,2), e, e/size(testSetData,2)]
end
error = error