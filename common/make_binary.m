function [B,S]=make_binary(varargin)
%
%   [B,S]=make_binary(varargin)
%
%
%
%
%


S=[];

if length(varargin) < 2 || length(varargin) > 3,
    
    error( 'Number of arguments is not correct!, See help for this function.' );
    
elseif length(varargin) == 2,
    
    D=varargin{1};
    L=varargin{2};
    
else,
    
    D=varargin{1};
    L=varargin{2};
    S=varargin{3};
    
end;

hr_lbs=find(L==1);
lr_lbs=find(L==0);

B=[];
S=[];

m=zeros(1,size(D,1));

for i=1:size(D,2),

	d=D(:,i);
    
    if isempty(S),
	
        m_hr = median( d( hr_lbs ) );
        m_lr = median( d( lr_lbs ) );
	
        m(i) = ( m_hr+m_lr ) / 2;
        
        idxg=find(d>=m(i));
        idxl=find(d<m(i));
    
    else,
        
        idxg=find(d>=S.m(i));
        idxl=find(d<S.m(i));
        
    end;
	
	d( idxg ) = 1;
	d( idxl ) = 0;
	
	B=[B d]; 

end;  

if isempty(S), S.m=m; end;
