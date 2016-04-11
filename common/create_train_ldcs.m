function [C,nn]=create_train_ldcs( T, L, A, B )
%
%  
%
%   
%   

C=[];

RandStream.setDefaultStream( RandStream('mt19937ar','Seed', sum(100*clock) ) );

sae=saesetup( A );

for i=1:length( A )-1,

    sae.ae{i}.activation_function       = 'sigm';
    sae.ae{i}.learningRate              = 0.7;
    sae.ae{i}.inputZeroMaskedFraction   = 0.0;

end;

opts.numepochs = 100;
opts.batchsize = B;
opts.momentum = 1.25;
sae = saetrain( sae, T, opts );

nn = nnsetup([A 2]);
nn.activation_function = 'sigm';
nn.learningRate = 0.7;

for i=1:length(A)-1,
    
    nn.W{i} = sae.ae{i}.W{1};

end;

train_l=[];

for i=1:length(L),
    
    if L(i)==0,
        
        train_l=[train_l; [0 1]];
        
    else,
        
        train_l=[train_l; [1 0]];
        
    end;
    
end;

% Train the FFNN
opts.numepochs = 500;
opts.batchsize = B;
opts.momentum = 1.25;

nn = nntrain(nn, T, train_l, opts);

for i=1:size(T,1),
    
    v=T(i,:)';

    for j=1:length(nn.W)-1,

        b=nn.W{j}(:,1);
        W=nn.W{j}(:,2:end);
        v = sigm( W*v+b );
    
    end;
    
    C=[C ; v'];

end;

