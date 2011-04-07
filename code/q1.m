


%%Q1 make histogram
clear all;
close all;

%Load data
dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

%Plot the normalized histogram
figure();
bar(hist(classVector,43)/size(classVector,1));
set(gca,'xlim',[1 43])
title('Normalized histogram of class frequencies');
xlabel('Class');
ylabel('Relative frequency');
%Save plot
print('-dpng','../Report/Figures/q1.png');

