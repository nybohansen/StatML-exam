function [gamma_jaakkola, svmModel, gamma] = calcSVMModel( data, C, I )

data = data';

%Split the data into the two classes
positive_class = data(find(data(:,:)==1),:);
negative_class = data(find(data(:,1)==5),:);

%Size of classes
np = size(positive_class,1);
nn = size(negative_class,1);

%allocate the first matrix
a = zeros(np*nn,2);
for i=0: np-1
    a(i*nn+1:i*nn+nn,1:2) = repmat(positive_class(i+1,1:2),nn,1);
end

b = repmat(negative_class(:,1:2),np,1);

G = sqrt(sum((a-b).^2,2));

sigma_jaakkola = median(G);
gamma_jaakkola = 1/(2*sigma_jaakkola^2);

gamma = gamma_jaakkola*2^I;

cmd = ['-s 0 -t 2 -c ', num2str(C), ' -g ', num2str(gamma)];
svmModel = svmtrain(data(:,1), data(:,2:end), cmd);



end

