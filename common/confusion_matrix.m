function S=confusion_matrix(K,L)

H=[L K];

S=zeros(1,4);

[m,n]=size(H);
	
for i=1:m,

	if H(i,1)==0 && H(i,2)==0,

		S(1)=S(1)+1;

	elseif H(i,1)==0 && H(i,2)==1,

		S(2)=S(2)+1;

	elseif H(i,1)==1 && H(i,2)==1,

		S(4)=S(4)+1;

	else,

		S(3)=S(3)+1;

	end;

end;

S=reshape(S,2,2);
