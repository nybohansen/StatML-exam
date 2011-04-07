function [ y ] = regression( train, test )


   t_train = train(1,:)';
   train = train(2:end,:)';

   test = test(2:end,:)';

   %Chosen phi to the identity 3.16 Bishop
   design = [ones(size(train,1),1), train];

   size(design)
   
   %Estimated maximum likelihood 3.15 Bishop
   %ml = pinv(design)*t_train;
   %t = pinv(design);
   t = geninv(design);
   %t = design'*design;   
   %t = inv(t);
   %t = t*design';
   clear design
   clear train
   ml = t*t_train;
   %Apply the model to each test set 3.3 Bishop
   y = [ones(size(test,1),1),test]*ml;

end

