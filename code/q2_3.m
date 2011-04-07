
%Q2 PCA on dataset
clear all;
close all;

dataMatrix = load('../../Data/trainingData.mat');
dataMatrix = dataMatrix.dataMatrix;
classVector = load('../../Data/trainingDataClasses.mat');
classVector = classVector.classVector;

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

%Plot Eigenvalues
figure;
plot(eigenValues,'b');
title('Eigenvalues');
xlabel('Components');
ylabel('Eigenvalue');
%Save plot
print('-dpng','../Report/Figures/q2-5.png');


%Plot eigenspectrum
figure;
plot(cumulativeVariance,'b');
hold on;
plot(1:size(cumulativeVariance,1),repmat(0.9,1,size(cumulativeVariance,1)),'--g');
hold on;
plot(necessaryComponents,cumulativeVariance(necessaryComponents),'ro');
title('Percentage of total variance');
xlabel('Components');
ylabel('%');
%Save plot
print('-dpng','../Report/Figures/q2-1.png');

%Project the data on to the first two principal components
Y = eigenVectors(:,1:2)'*B;

%Attach the class vectors
Y = [classVector'; Y(1,:); Y(2,:)];

%find shape indicies
round = find(( -1 < Y(1,:) & Y(1,:) < 11) | (14 < Y(1,:) & Y(1,:) <18) | (31 < Y(1,:) & Y(1,:) < 43) );
upwardsTriangle = find((Y(1,:)==11) | ( 17 < Y(1,:) & Y(1,:) < 32) );
diamond = find(Y(1,:)==12);
downwardsTriangle = find(Y(1,:)==13);
octagon = find(Y(1,:)==14);


figure();
hold on;
scatter(Y(2,round),Y(3,round),'ro')
scatter(Y(2,upwardsTriangle),Y(3,upwardsTriangle),'g^')
scatter(Y(2,diamond),Y(3,diamond),'bd')
scatter(Y(2,downwardsTriangle),Y(3,downwardsTriangle),'yv')
scatter(Y(2,octagon),Y(3,octagon),'ch')
title('Scatter plot of the first two PCA components');
xlabel('Principal component 1');
ylabel('Principal component 2');
legend('Round','Upwards pointing triangle', 'Diamond', 'Downwards pointing triangle', 'Octagon','Location','SouthWest');
%Save plot
print('-dpng','../Report/Figures/q2-2.png');


%% Q3 K-means
%K-means with quality quess
[centroids1 data1] = kmeans(B,4,0.1);

[centroids2 data2] = kmeans(B,4,0.1);


figure();
hold on;
scatter(Y(2,round),Y(3,round),'ro')
scatter(Y(2,upwardsTriangle),Y(3,upwardsTriangle),'g^')
scatter(Y(2,diamond),Y(3,diamond),'bd')
scatter(Y(2,downwardsTriangle),Y(3,downwardsTriangle),'yv')
scatter(Y(2,octagon),Y(3,octagon),'ch')

Y1 = eigenVectors(:,1:2)'*centroids1;
scatter(Y1(1,:),Y1(2,:), 75, 'k', 'filled');
title({'Scatter plot of the first two PCA components', 'including the kmeans centers (Random initialization of centroids)'});
xlabel('Principal component 1');
ylabel('Principal component 2');
legend('Round','Upwards pointing triangle', 'Diamond', 'Downwards pointing triangle', 'Octagon','Location','SouthWest', 'Centers');
%Save plot
print('-dpng','../Report/Figures/q2-3.png');



figure();
hold on;
scatter(Y(2,round),Y(3,round),'ro')
scatter(Y(2,upwardsTriangle),Y(3,upwardsTriangle),'g^')
scatter(Y(2,diamond),Y(3,diamond),'bd')
scatter(Y(2,downwardsTriangle),Y(3,downwardsTriangle),'yv')
scatter(Y(2,octagon),Y(3,octagon),'ch')

Y2 = eigenVectors(:,1:2)'*centroids2;
scatter(Y2(1,:),Y2(2,:), 75, 'k', 'filled');
title({'Scatter plot of the first two PCA components', 'including the kmeans centers (Random initialization of centroids)'});
xlabel('Principal component 1');
ylabel('Principal component 2');
legend('Round','Upwards pointing triangle', 'Diamond', 'Downwards pointing triangle', 'Octagon','Location','SouthWest', 'Centers');
%Save plot
print('-dpng','../Report/Figures/q2-4.png');

