
%PCA on dataset binary classidication dataset
clear all;
close all;

dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

dataMatrix = dataMatrix(:,find(classVector==1 | classVector==5));
classVector = classVector(find(classVector==1 | classVector==5));

%Calculate the empirical mean
empiricalMean = mean(dataMatrix,2);

%Calculate the deviations from the mean
B = dataMatrix-empiricalMean*ones(1,size(dataMatrix,2));

%Calculate covariance matrix
C = cov(B');

%Find the eigenvectors and eigenvalues of the covariance matrix
[eigenVectors D] = eig(C);
eigenValues = diag(D);

%Rearrange the eigenvectors and eigenvalues
[eigenValues i] = sort(eigenValues,1,'descend');
eigenVectors = eigenVectors(:,i);

%Compute the cumulative percentage variance for each eigenvector
totalVariance = sum(eigenValues);
cumulativeVariance = cumsum(eigenValues)/totalVariance;

%Number of components necessary
necessaryComponents = find(cumulativeVariance>=0.9,1)

%Plot eigenspectrum
figure;
plot(cumulativeVariance,'b');
hold on;
plot(1:size(cumulativeVariance,1),0.9,'-g');
hold on;
plot(necessaryComponents,cumulativeVariance(necessaryComponents),'ro');
title('Percentage of total variance');
xlabel('Components');
ylabel('%');


%Project the data on to the first two principal components
Y = eigenVectors(:,1:3)'*B;

%Attach the class vectors
Y = [classVector'; Y(1,:); Y(2,:); Y(3,:)];

%find shape indicies
upwardsTriangle = find((Y(1,:)==1));
octagon = find(Y(1,:)==5);


figure();
hold on;
scatter3(Y(2,upwardsTriangle),Y(3,upwardsTriangle),Y(4,upwardsTriangle),'g^')
scatter3(Y(2,octagon),Y(3,octagon),Y(4,octagon),'rh')
title('Scatter plot of the first three PCA components');
xlabel('Principal component 1');
ylabel('Principal component 2');
legend('Class 1', 'Class 5');



