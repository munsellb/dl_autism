function Fold=create10FoldHL( A )
%
%  Fold=create10FoldHL( A )
%
%
%   Create cross-validatiton train and test data 
%   for High/Low outcome groups
%
%
%
%
%
%
%
%

warning off;

if ~exist('TenFold','dir'),
    mkdir('TenFold');
end;

delete('TenFold/FoldsHL.mat');

N=length(A);

perm=randperm(N);

PATWOUT=A(perm);

indices = crossvalind('Kfold', N, 10 );

for i=1:length(indices),

    for i=1:10,

        idx=find(indices==i);

        Fold{i} = PATWOUT(idx);

    end;
    
   
end;

save('./TenFold/FoldsHL.mat','Fold');








