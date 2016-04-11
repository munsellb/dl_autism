function C=create_test_ldcs( T, nn )
%
%
%
%
%

C=[];

for i=1:size(T,1),
    
    v=T(i,:)';

    for j=1:length(nn.W)-1,

        b=nn.W{j}(:,1);
        W=nn.W{j}(:,2:end);
        v = sigm( W*v+b );
    
    end;
    
    C=[C ; v'];

end;


