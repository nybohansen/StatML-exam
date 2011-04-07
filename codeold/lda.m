function lda( train, test )

%With inspiration from
%http://people.revoledu.com/kardi/tutorial/LDA/Numerical%20Example.html

%Separate into two classes
class_1 = train(:,find(train(1,:)==1));
class_2 = train(:,find(train(1,:)==5));

%Total number of training points.
N = size(train,2);
%Number of points in class_1
n(1) = size(class_1,2);
%Number of points in class_2
n(2) = size(class_2,2);

%Calculate mu for the classes
mu_1 = mean(class_1(2:end,:),2);
mu_2 = mean(class_2(2:end,:),2);

%calulate global mu
mu = mean(train(2:end,:));

%Mean corrected data
corrected_class_1 = class_1(2:end,:) - repmat(mu_1,1,n(1));
corrected_class_2 = class_2(2:end,:) - repmat(mu_2,1,n(2));

%Covariance matrix for corrected class
cow_class_1 = (corrected_class_1'*corrected_class_1)/n(1);
cow_class_2 = (corrected_class_2'*corrected_class_2)/n(2);

%The covariance matrices has the same size.
C = zeros(size(cow_class_1));

C(1,1) = (1/n(1)) * cow_class_1(1,1) + (1/n(2)) * cow_class_2(1,1);
C(1,2) = (1/n(1)) * cow_class_1(1,2) + (1/n(2)) * cow_class_2(1,2);
C(2,1) = (1/n(1)) * cow_class_1(2,1) + (1/n(2)) * cow_class_2(2,1);
C(2,2) = (1/n(1)) * cow_class_1(2,2) + (1/n(2)) * cow_class_2(2,2);

C_inv = inv(C);

p_1 = n(1)/N;
p_2 = n(2)/N;

errors = 0;
for i = 1: size(test,1)
    hold on
    x_k = test(i,1:2);
    if mu_1*C_inv*x_k'-0.5*mu_1*C_inv*mu_1'+log(p_1) > mu_2*C_inv*x_k'-0.5*mu_2*C_inv*mu_2'+log(p_2)
        plot(test(i,1),test(i,2),'rx');
        if test(i,3) ~= -1
            errors = errors+1;
        end
    else
        plot(test(i,1),test(i,2),'bx');
        if test(i,3) ~= 1
            errors = errors+1;
        end
    end 
end

Total_error = errors/size(test,1)



end

