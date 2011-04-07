
close all;
clear all;


%Setup
%Number of samples for each unique trafic sign
sampleSize = 30;

k = 5
%From 1 to maximum K in knn
maxK = 50;

dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

indicies = find(classVector==1 | classVector==5);

%First row in data is now the class label
%each column underneath is the data sample
data = [classVector(indicies)'; dataMatrix(:,indicies)];

%Number of unique signs (Each sign has 30 samples)
N = size(data,2)/sampleSize;

%Generate cross validation dataset
crossValClasses = crossvalind('Kfold',N,k);
crossValClasses = repmat(crossValClasses',sampleSize,1);
crossValClasses = crossValClasses(:);

%Fetch training set from cross validation classes
trainingSetData = data(:,find(crossValClasses~=1));
%Fetch test set from cross validation classes
testSetData = data(:,find(crossValClasses==1));

[gamma_jaakkola C svmModel gamma] = calcSVMModel(trainingSetData)
[~, accuracy, ~] = svmpredict(trainingSetData(1,:),trainingSetData(2:end,:)',svmModel)