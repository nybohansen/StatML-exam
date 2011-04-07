%Q5 using SVM

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

accuracy = [];

C = [0.1 1 10 100, 1000, 10000];
I = [-3 -1 0 1 3];

accuracy = [];

for c = C
    for i = I
        crossAccuracy = [];
        for j=1:k
            trainingSetData = data(:,find(crossValClasses~=j));
            %Fetch test set from cross validation classes
            testSetData = data(:,find(crossValClasses==j));
            %Apply SVM
            [gamma_jaakkola svmModel gamma] = calcSVMModel(trainingSetData, c, i);
            [~, acc, ~] = svmpredict(testSetData(1,:)',testSetData(2:end,:)',svmModel);
            crossAccuracy = [crossAccuracy; acc(1)]
        end
        accuracy = [accuracy; mean(crossAccuracy), c, i]
    end
end
