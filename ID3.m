
classdef ID3

    
    properties        
     tree=containers.Map;
    end
    
   methods(Static) 
       
    function I=IG(ed,et)

    I =ed-et;

    end

function tree = buildTree(data)

    X=data(:,1:end-1);
    y=data(:,end);
    node=ID3.find_winner(X,y);
    
    attvalue=unique(X(:,node));
    
    tree=id3node;
    
    if tree.node==0            
        tree.node=node;
        tree.value={};
    end
    
    for value =1:length(attvalue)

        subtable=ID3.get_subtable(data,node,attvalue(value));

        cvalues=unique(subtable(:,end));
        
        for j=1:length(cvalues)
          counts(j)= length(find(subtable(:,end)==cvalues(j))); 
        end
       
        [~,idx]= max(counts);    
         
        if length(counts)==1  || length(attvalue)==1 
            tree.node=node;
            tree.value{value}=cvalues(idx);
        else
            %x(1,value)=buildTree(subtable,tree);
            %tree(num2str(node))=x; 
            
            tree.node=node;
            tree.value{value}=ID3.buildTree(subtable);
       
        end
      
    end
    
    

end

function d= get_subtable(data,node,value)
   

   d=data(data(:,node)==value,:);
   
end

function entropy=find_entropy(y)

    n=length(unique(y));
    entropy=0;   
    for i=1:n

        fraction=length(find(y==i))/size(y,1);
        entropy=entropy-fraction*log2(fraction);
    end

end

function predictions=predict(tree,x)
    
    for i=1:length(x)
       p=ID3.predict_(tree,x(i,:)); 
       try
       predictions(i)=p{:};
       catch
           predictions(i)= p{1}.value{:};
       end
    end
end

function pred=predict_(tree,x)
    
    
    while length(tree.value)~=1
        
        n=x(tree.node);
      try  
        tree=tree.value{n+1};
        pred=tree.value;
      catch 
        break
         
      end
    end
    
    
end
function winner= find_winner(X,y)

   IG= [];
   
   for idx=1:size(X,2)
       
      IG(idx)=ID3.find_entropy(y)-ID3.ent(X,y,idx);
       
   end
    [~,winner]=max(IG); 
end


function entropy_attribute = ent(X,y,id)

    
    entropy_attribute=0;
    variables=unique(X(:,id));
    n=length(unique(y));
    
for idx=1:length(variables) 
     entropy_each_feature=0;
         
    for target_variable =1:n
         dat=X(:,id);
         m=y(dat==idx);
         num=length(find(m==target_variable));
         den=length(X(dat==idx));
         
           fraction=(num/den);
           entropy_each_feature=  entropy_each_feature-fraction*log2(fraction);  
    end
     fraction2 = den/length(X);
    entropy_attribute=entropy_attribute-fraction2; 
end
    entropy_attribute=abs(entropy_attribute);
end

     end
     
end