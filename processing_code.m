clc
clear all

%load input and target
load('input.mat')
load('target.mat')

%size of input
[~,n]=size(input);

%convert the categorical attributes to numberical
processinput=[];
for i=[1,2,3,5,6,11,12,14,15,16,18]
    
    d=processd(input(:,i));
    processinput=horzcat(processinput,d');
end

%combined the inputs
processinput=horzcat(processinput,cell2mat(input(:,7)),cell2mat(input(:,8)),...
    cell2mat(input(:,9)),cell2mat(input(:,13)),cell2mat(input(:,17)));

%save input
save('processinput','processinput')

function d=processd(data)

    x=unique(data);
    d=[];
    for i=1:length(data)

         for j =1:length(x)

             if strcmp(data(i),x(j))
                 d(i)=j;
             end

         end

    end

end