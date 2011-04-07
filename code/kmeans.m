function [ centroids data ] = kmeans( data, k, epsilon, newCentroids )
%data = Each column is a smaple vector
%k = number of clusters

%Number of samples
N = size(data,2);

if nargin < 4 
    %Calculate initial centroids
    newCentroids = data(:,ceil(rand(k,1)*size(data,2)));
    %make sure the centroids are unique, otherwise we
    %could get into troubles!
    while size(unique(newCentroids','rows'),1)~=k
        newCentroids = data(:,ceil(rand(k,1)*size(data,2)));
    end
    
end

centroids = newCentroids+1;

data = [zeros(1,N); data];

while norm(newCentroids - centroids)>epsilon
    centroids = newCentroids;
    for i=1 : N
        sample = repmat(data(2:end,i),1,k);
        distances = sqrt(sum( (centroids - sample).^ 2 ));
        [C I] = min(distances);
        data(1,i) = I;
    end

    %update centroids
    for i=1:k
        newCentroids(:,i) = mean(data(2:end,find(data(1,:)==i)),2);
    end
    
    norm(newCentroids - centroids)

end

end

