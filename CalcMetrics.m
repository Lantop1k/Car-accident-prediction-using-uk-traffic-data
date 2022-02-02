function [truepositive,truenegative,falsepositive,falsenegative,precision,recall,fscore,accuracy]=CalcMetrics(predict,actual)
truepositive=0;
truenegative=0;

if numel(predict)~=numel(actual)
   disp('predict and actual must have equal items')
else
    


falsenegative=0;
falsepositive=0;
for i =1:numel(predict)
     if predict(i)==1 && actual(i)==1
        truepositive=truepositive+1;
     elseif predict(i)==0 && actual(i)==0
         truenegative=truenegative+1;
     elseif   predict(i)==1 && actual(i)==0  
         falsepositive=falsepositive+1;
     elseif   predict(i)==0 && actual(i)==1  
         falsenegative=falsenegative+1;
     end    
end


precision=100*truepositive/(truepositive+falsepositive);
recall=100*truepositive/(truepositive+falsenegative);
fscore=2/((1/precision) +(1/recall));
C=confusionmat(predict,actual);
accuracy=100*sum(diag(C))/sum(C(:));
sensitivity=100*(truepositive)/(truepositive+falsenegative);
specificity=100*(truenegative)/(truenegative + falsepositive);

%{
fprintf('truepositive= %d\n',truepositive)
fprintf('truenegative= %d\n',truenegative)
fprintf('falsepositive= %d\n',falsepositive)
fprintf('falsenegative= %d\n',falsenegative)
fprintf('accuracy= %3.2f\n',accuracy)
fprintf('precision= %3.2f\n',precision)
fprintf('recall= %3.2f\n',recall)
fprintf('fscore= %3.2f\n',fscore)
fprintf('sensitivity= %3.2f\n',sensitivity)
fprintf('specificity= %3.2f\n',specificity)
%}

end
end