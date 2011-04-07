
% Q8 - linear regression in the binary case
close all;
clear all;

%Setup
%Number of samples for each unique trafic sign
sampleSize = 30;

k = 5;

%Load data
dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

%Rename classes, so we can use sign later on
classVector(classVector==1) = -1; 
classVector(classVector==5) = 1; 

%Fetch the two classes 
indicies = find(classVector==-1 | classVector==1);

%First row in data is now the class label
%each column underneath is the data sample
data = [classVector(indicies)'; dataMatrix(:,indicies)];

%Number of unique signs (Each sign has 30 samples)
N = size(data,2)/sampleSize;

%Generate cross validation dataset
crossValClasses = crossvalind('Kfold',N,k);
crossValClasses = repmat(crossValClasses',sampleSize,1);
crossValClasses = crossValClasses(:);

%Initialize accuracy matrix;
accuracy = [];

for i=1:k
    trainingSetData = data(:,find(crossValClasses~=i));
    %Fetch test set from cross validation classes
    testSetData = data(:,find(crossValClasses==i));
    %Apply linear discriminant anlysis
    y = regression(trainingSetData,testSetData);
    accuracy = [accuracy; i, sum(sign(y)==testSetData(1,:)')/length(testSetData(1,:))]
end

globalAccuracy = mean(accuracy(:,2))