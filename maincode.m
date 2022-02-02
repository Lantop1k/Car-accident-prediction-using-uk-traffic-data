clc

clear all 
close all

rng(1)

%process data into input, X and target, y
load('processinput')
load('target')
X=processinput;
y=double(target);

%remove features with less feature weights
X(:,[8,12,13,15])=[];

%split data into training and testing
idx=crossvalind('kfold',y,5);

%train input
trainX=X(idx~=5,:);
testX=X(idx==5,:);

%test input
trainY=y(idx~=5);
testY=y(idx==5);


%train classifier with ID3 algorithm
data=[trainX trainY];
id3tree=ID3.buildTree(data);
predictions_id3=ID3.predict(id3tree,testX);
C=confusionmat(testY,predictions_id3);
accuracy=sum(diag(C))/sum(C(:));
fprintf('Accuracy of ID3 model= %2.5f\n',accuracy)

%train classifier with Ca4.5 algorithm
data=[trainX trainY];
ca4_5tree=ca4_5.buildTree(data);
predictions_ca45=ca4_5.predict(ca4_5tree,testX);
C=confusionmat(testY,predictions_ca45);
accuracy=sum(diag(C))/sum(C(:));
fprintf('Accuracy of ca4.5 model= %2.5f\n',accuracy)


%train cart model
model=fitctree(trainX,trainY);

%predict the testX
predictions_cart=predict(model,testX);

%plot the confusion tree 
C=confusionmat(testY,predictions_cart);
accuracy=sum(diag(C))/sum(C(:));

%compute the accuracy
fprintf('Accuracy of cart model= %2.5f\n',accuracy)

%compute the performance metrics for each algorithm
truepositives=[];
truenegatives=[];
falsepositives=[];
falsenegatives=[];

precisions=[];
recalls=[];
fscores=[];
accuracys=[];

for i=1:3
   
    actual=zeros(1,length(testY));
    actual(testY==i)=1;
    
    predict=zeros(1,length(predictions_id3));
    predict(predictions_id3==i)=1;
    
    [truepositive,truenegative,falsepositive,falsenegative,precision,...
        recall,fscore,accuracy]=CalcMetrics(predict,actual);
    
    truepositives(i)=truepositive;
    truenegatives(i)=truenegative;
    falsepositives(i)=falsepositive;
    falsenegatives(i)=falsenegative;
    
    precisions(i)=precision;
    recalls(i)=recall;
    fscores(i)=fscore;
    accuracys(i)=accuracy;
    
end

 truepositive=truepositives';
 truenegative=truenegatives';
 falsepositive=falsepositives';
 falsenegative=falsenegatives';
    
 precision=precisions';
 recall=recalls';
 fscore=fscores';
 accuracy=accuracys';
 
 R={'Serious','Slight','Fatal'};
 
T_id3=table(truepositive,truenegative,falsepositive,falsenegative,precision,recall,fscore,accuracy,'RowNames',R)


truepositives=[];
truenegatives=[];
falsepositives=[];
falsenegatives=[];

precisions=[];
recalls=[];
fscores=[];
accuracys=[];

for i=1:3
   
    actual=zeros(1,length(testY));
    actual(testY==i)=1;
    
    predict=zeros(1,length(predictions_ca45));
    predict(predictions_ca45==i)=1;
    
    [truepositive,truenegative,falsepositive,falsenegative,precision,...
        recall,fscore,accuracy]=CalcMetrics(predict,actual);
    
    truepositives(i)=truepositive;
    truenegatives(i)=truenegative;
    falsepositives(i)=falsepositive;
    falsenegatives(i)=falsenegative;
    
    precisions(i)=precision;
    recalls(i)=recall;
    fscores(i)=fscore;
    accuracys(i)=accuracy;
    
end

 truepositive=truepositives';
 truenegative=truenegatives';
 falsepositive=falsepositives';
 falsenegative=falsenegatives';
    
 precision=precisions';
 recall=recalls';
 fscore=fscores';
 accuracy=accuracys';
 
 R={'Serious','Slight','Fatal'};
 
T_ca45=table(truepositive,truenegative,falsepositive,falsenegative,precision,recall,fscore,accuracy,'RowNames',R)



truepositives=[];
truenegatives=[];
falsepositives=[];
falsenegatives=[];

precisions=[];
recalls=[];
fscores=[];
accuracys=[];

for i=1:3
   
    actual=zeros(1,length(testY));
    actual(testY==i)=1;
    
    predict=zeros(1,length(predictions_cart));
    predict(predictions_cart==i)=1;
    
    [truepositive,truenegative,falsepositive,falsenegative,precision,...
        recall,fscore,accuracy]=CalcMetrics(predict,actual);
    
    truepositives(i)=truepositive;
    truenegatives(i)=truenegative;
    falsepositives(i)=falsepositive;
    falsenegatives(i)=falsenegative;
    
    precisions(i)=precision;
    recalls(i)=recall;
    fscores(i)=fscore;
    accuracys(i)=accuracy;
    
end

 truepositive=truepositives';
 truenegative=truenegatives';
 falsepositive=falsepositives';
 falsenegative=falsenegatives';
    
 precision=precisions';
 recall=recalls';
 fscore=fscores';
 accuracy=accuracys';
 
 R={'Serious','Slight','Fatal'};
 
T_cart=table(truepositive,truenegative,falsepositive,falsenegative,precision,recall,fscore,accuracy,'RowNames',R)