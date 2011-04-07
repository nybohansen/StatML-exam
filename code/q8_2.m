
% Q8 - linear regression in the multi-class case
close all;
clear all;

%Setup
%Number of samples for each unique trafic sign
sampleSize = 30;

k = 5;

dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

%First row in data is now the class label
%each column underneath is the data sample
data = [classVector'; dataMatrix];

clear dataMatrix classVector

%Number of unique signs (Each sign has 30 samples)
N = size(data,2)/sampleSize;

%Generate cross validation dataset
crossValClasses = crossvalind('Kfold',N,k);
crossValClasses = repmat(crossValClasses',sampleSize,1);
crossValClasses = crossValClasses(:);

accuracy = [];

for i=1:k
    trainingSetData = data(:,find(crossValClasses~=i));
    %Fetch test set from cross validation classes
    testSetData = data(:,find(crossValClasses==i));
    %clear data
    %Apply linear discriminant anlysis
    y = regression(trainingSetData,testSetData);
    
    %Crude but neccesary!
    y(y<min(testSetData(1,:))) = min(testSetData(1,:));
    y(y>max(testSetData(1,:))) = max(testSetData(1,:));
    y = round(y);
    accuracy = [accuracy; i, sum(y==testSetData(1,:)')/length(testSetData(1,:))]
end

globalAccuracy = mean(accuracy(:,2))