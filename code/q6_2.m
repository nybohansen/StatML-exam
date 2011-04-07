

%Q6 Using KNN

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

%Number of unique signs (Each sign has 30 samples)
N = size(data,2)/sampleSize;

%Generate cross validation dataset
crossValClasses = crossvalind('Kfold',N,k);
crossValClasses = repmat(crossValClasses',sampleSize,1);
crossValClasses = crossValClasses(:);

ks = [1 2 5 10 15 20 30 40 50 100 250]';
accuracy = [ks];
for i=1:k
    trainingSetData = data(:,find(crossValClasses~=i));
    %Fetch test set from cross validation classes
    testSetData = data(:,find(crossValClasses==i));
    %Apply linear discriminant anlysis
    %ldaClass = classify(testSetData(2:end,:)',trainingSetData(2:end,:)',trainingSetData(1,:));
    disp(['Size of training set is ', num2str(size(trainingSetData,2)), ', size of test set is ', num2str(size(testSetData,2))]);
    accuracy = [accuracy knnHelper(trainingSetData(2:end,:),trainingSetData(1,:),testSetData,ks)]
end

disp(['Mean accuracy on all the cross validation runs'])
totalMean = [accuracy(:,1) mean(accuracy(:,2:end),2)]

