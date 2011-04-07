

%Q7 using linear LDA

close all;
clear all;

%Setup
%Number of samples for each unique trafic sign
sampleSize = 30;

k = 5;
%From 1 to maximum K in knn
maxK = 50;

%Load training data
trainingDataMatrix = load('../../Data/trainingData.mat');
trainingDataMatrix = trainingDataMatrix.dataMatrix;
TrainingclassVector = load('../../Data/trainingDataClasses.mat');
TrainingclassVector = TrainingclassVector.classVector;
indicies = find(TrainingclassVector==1 | TrainingclassVector==5);
%First row in data is now the class label
%each column underneath is the data sample
trainingData = [TrainingclassVector(indicies)'; trainingDataMatrix(:,indicies)];

%Load test data
testDataMatrix = load('../../Data/testData.mat');
testDataMatrix = testDataMatrix.dataMatrix;
testDataclassVector = load('../../Data/testDataClasses.mat');
testDataclassVector = testDataclassVector.classVector;

indicies = find(testDataclassVector==1 | testDataclassVector==5);

%First row in data is now the class label
%each column underneath is the data sample
testData = [testDataclassVector(indicies)'; testDataMatrix(:,indicies)];

%Binary classification using LDA
y = classify(testData(2:end,:)',trainingData(2:end,:)',trainingData(1,:));

%Calculate accuracy
accuracy = sum(y == testData(1,:)')/size(testData,2)

