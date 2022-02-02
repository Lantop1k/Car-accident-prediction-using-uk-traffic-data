clc

clear all

load('input.mat')
load('target.mat')

[~,n]=size(input);

processinput=[];
for i=[1,2,3,5,6,11,12,14,15,16,18]
    
    d=processd(input(:,i));
    processinput=horzcat(processinput,d');
end


processinput=horzcat(processinput,cell2mat(input(:,7)),cell2mat(input(:,8)),...
    cell2mat(input(:,9)),cell2mat(input(:,13)),cell2mat(input(:,17)));

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