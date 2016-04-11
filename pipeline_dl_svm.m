function C=pipeline_dl_svm( opts, Train, Test )
%
%
%
%

fprintf('----------------------\n');
if opts.grps==0, 
    fprintf('HR/LR Prediction Pipeline\n');
else,
    fprintf('HR+/HR- Prediction Pipeline\n');
end;
fprintf('----------------------\n');

[train_data, train_labels]=create_model_data( Train, opts.grps );
[test_data, test_labels]=create_model_data( Test, opts.grps );

[train_data_binary, S]=make_binary( train_data, train_labels );
[test_data_binary, ~]=make_binary( test_data, test_labels, S );

architecture=[size(train_data_binary,2) opts.arch];

[train_ldcs,sae]=create_train_ldcs( train_data_binary, train_labels, architecture, Train.mini_batch );
test_ldcs=create_test_ldcs( test_data_binary, sae );

svmStruct=svmtrain( train_ldcs, train_labels'); %,'Kernel_Function', 'rbf', 'RBF_Sigma', 0.15); %,'showplot', true );

train_pred_labels=svmclassify( svmStruct, train_ldcs );

train_cmtx=confusion_matrix( train_pred_labels, train_labels );
train_perf=confusion_matrix_score( train_cmtx );
fprintf('[Train] Sens=%.2f, Spec=%.2f, PPV=%.2f, NPV=%.2f\n', train_perf.Sen, train_perf.Spc, train_perf.PPV, train_perf.NPV );

test_pred_labels=svmclassify( svmStruct, test_ldcs ); %,'showplot', true );

test_cmtx=confusion_matrix( test_pred_labels, test_labels );
test_perf=confusion_matrix_score( test_cmtx );
fprintf('[Test] Sens=%.2f, Spec=%.2f, PPV=%.2f, NPV=%.2f\n', test_perf.Sen, test_perf.Spc, test_perf.PPV, test_perf.NPV );

C.Test=Test;
C.Train=Train;

C.Train_Binary=train_data_binary;
C.Train_Labels=train_labels;

C.Test_Binary=test_data_binary;
C.Test_Labels=test_labels;

C.sae=sae;
C.svm=svmStruct;

C.Train_CMTX=train_cmtx;
C.Train_Perf=train_perf;

C.Test_CMTX=test_cmtx;
C.Test_Perf=test_perf;