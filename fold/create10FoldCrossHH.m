function [Train,Test]=create10FoldCrossHH( Folds, test_idx )
%
%
%   [Train,Test]=create10FoldCrossHH( Folds, test_idx )
%
%
%
%
%

train_idx=1:10;

train_idx(test_idx)=[];

testGroup = Folds( test_idx );
trainGroup = Folds( train_idx );

cnt_g=1;
cnt_b=1;

for i=1:length(trainGroup),

	fold=trainGroup{i};
    
    for j=1:length(fold),

        if strcmpi( fold{j}.HL, 'HR' ),

            Train.HR{cnt_g}=fold{j};
            cnt_g=cnt_g+1;

        else,

            Train.LR{cnt_b}=fold{j};
            cnt_b=cnt_b+1;

        end;
    
    end;

end;

cnt_g=1;
cnt_b=1;

for i=1:length(testGroup),

	fold=testGroup{i};
    
    for j=1:length(fold),

        if strcmpi(fold{j}.HL,'HR'),

            Test.HR{cnt_g}=fold{j};
            cnt_g=cnt_g+1;

        else,

            Test.LR{cnt_b}=fold{j};
            cnt_b=cnt_b+1;

        end;
    
    end;

end;

dd=divisor(length(Train.HR));

Train.mini_batch=dd(2);