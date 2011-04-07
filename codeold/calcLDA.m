function [ W m_i] = clacLDA( input, labels )
% Each column un input is a sample vector
% labels is a vector of length equal to the number of columns in input
% Entry i in labels is the label for the sample vector in column i in input

%fetch unique class labels
uniqueLabels = unique(labels)

%Count classes
c = length(uniqueLabels)

[N M] = size(input);

%Make class mean vector m_i
m_i = zeros(N,c);
for i=1 : c
    m_i(:,i) = mean(input(:,find(labels==uniqueLabels(i))),2);
end

%Calc total mean m
m = mean(input,2);

% Calculate the between class scatter matrix
S_B = zeros(N,N);
for i=1 : c
    S_B = S_B + length(find(labels==uniqueLabels(i)))*(m_i(:,i)-m)*(m_i(:,i)-m)';
end

%Calculate the within class scatter matrix
S_W = zeros(N,N);
for i=1 : c
   for k=1 : M
       S_W = S_W + (input(:,k)-m_i(:,i))*(input(:,k)-m_i(:,i))';
   end
end


[W ~] = eig(S_W\S_B);

end

