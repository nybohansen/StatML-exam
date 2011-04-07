

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

%First row in data is now the class label
%each column underneath is the data sample
trainingData = [TrainingclassVector'; trainingDataMatrix];

%Load test data
testDataMatrix = load('../../Data/testData.mat');
testDataMatrix = testDataMatrix.dataMatrix;
testDataclassVector = load('../../Data/testDataClasses.mat');
testDataclassVector = testDataclassVector.classVector;

%First row in data is now the class label
%each column underneath is the data sample
testData = [testDataclassVector'; testDataMatrix];

ks = [20];
accuracy = knnHelper(trainingData(2:end,:),trainingData(1,:),testData,ks)


