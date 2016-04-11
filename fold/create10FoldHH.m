function Fold=create10FoldHH( A )
%
%  Fold=create10FoldHH( A )
%
%
%   Create cross-validatiton train and test data 
%   for High+/High- outcome groups
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

delete('TenFold/FoldsHH.mat');

[H,~]=createHRData(A);
H=createHHData(H);

N=length(H);

perm=randperm(N);

PATWOUT=H(perm);

indices = crossvalind('Kfold', N, 10 );

for i=1:length(indices),

    for i=1:10,

        idx=find(indices==i);

        Fold{i} = PATWOUT(idx);

    end;
    
   
end;

save('./TenFold/FoldsHH.mat','Fold');








