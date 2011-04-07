function [accuracy] = knnHelper( training_vec, class_vec, test_vec, ks )
%Calculates the knn for each element in test_vec with the training data
% in training_vec.

testSize = size(test_vec,2);

k = max(ks);
classes = zeros(k, testSize); 

for i=1: testSize
    classes(:,i) = knn(training_vec, class_vec, k, test_vec(2:end,i));
end

accuracy = [];
for i=ks
    estClasses = mode(classes(1:i,:),1);
    accuracy = [accuracy; sum(test_vec(1,:)'== estClasses')/testSize];
end

end



