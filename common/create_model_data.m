function [D,L]=create_model_data( T, type )

% TYPE: 0 (HR/LR), 1 (HR+/HR-)

HRP_HRN = 1;
HR_LR = 0;

HR = T.HR;

try,  
    LR = T.LR;
catch,
    fprintf('No LR Group\n');
end;

HR_NEG='HR1';

cnt=[1 1];

for i=1:length(HR),
    
    if strcmp( HR_NEG, HR{i}.RISK ),
        
        HRN{cnt(1)}=HR{i};
        cnt(1)=cnt(1)+1;

    else,
        
        HRP{cnt(2)}=HR{i};
        cnt(2)=cnt(2)+1;

        
    end;
    
end;

if type==HR_LR,

	D_HR=create_feature_matrix(HR, 0);
	D_LR=create_feature_matrix(LR, 1);

	D=[ D_HR ; D_LR ];

else,

	D_HRP=create_feature_matrix(HRP, 0);
	D_HRN=create_feature_matrix(HRN, 1);

	D=[ D_HRN ; D_HRP ];

end;

perm=randperm(size(D,1));

D=D(perm,:);
L=D(:,end);
D=D(:,1:end-1);
