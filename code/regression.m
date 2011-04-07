function [ y ] = regression( train, test )

   %Split the data in labels and samples
   t_train = train(1,:)';
   train = train(2:end,:)';

   test = test(2:end,:)';

   %Chosen phi to the identity 3.16 Bishop
   design = [ones(size(train,1),1), train];

   size(design)
   
   %Moore-Penrose pseudo inverse on speed
   t = geninv(design);

   %Clear some large variables, we need ram!
   clear design
   clear train
   
   %Estimated maximum likelihood 3.15 Bishop
   ml = t*t_train;
   
   %Apply the model to each test set 3.3 Bishop
   y = [ones(size(test,1),1),test]*ml;

end

