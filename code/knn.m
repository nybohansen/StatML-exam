function classes = knn( training_set, class_vector, maxK, unknown )
  
  % Size of training and class vector
  N = size(training_set,2);
  
  dist = zeros(N,2);
  for i=1: N
      %Calculate distance from unknown to all training points
      %dist(i,:) = [sum((training_set(:,i)-unknown).^2), class_vector(i)];
      dist(i,:) = [norm(training_set(:,i)-unknown), class_vector(i)];
  end
  
 
  % Sort the dist vector asc (Shortest first)
  dist = sortrows(dist,1);
  
  %Remove everything except the k first dists, Return the class
  classes = dist(1:maxK,2);
   
end

