function run_pipeline( opts )
%
%   
%   run_pipeline( opts )
%   
%   This script trains and tests the two-stage prediction
%   pipeline. Note: this script does not include the median 
%   network. For more details about the median network, see 
%   median_network matlab script.
%   
%
%   opts.meth    (DL <Deep Learning>)
%   opts.grps    (0=HR/LR, 1=HR+/HR-)
%   opts.arch    (DL only, defines architecture)
%   opts.inst    (pipeline instance # used by median network)
%
%

numFolds=10;

if opts.grps == 0,
    
    dfold = ['./data/SVM/HL/' num2str(opts.inst) '/' opts.meth];
    
    % load 10-fold data in TenFold folder
    load TenFold/FoldsHL.mat;
    
else,
    
    dfold = ['./data/SVM/HH/' num2str(opts.inst) '/' opts.meth];
    
    % load 10-fold data in TenFold folder
    load TenFold/FoldsHH.mat;
    
end;

if ~exist( dfold,'dir' ),
    mkdir( dfold );
end;

ConfusionMatrix=zeros(2,2);

for i=1:numFolds,
    
    if opts.grps == 0,
        
        [Train,Test]=create10FoldCrossHL(Fold, i);
        
    else,

        [Train,Test]=create10FoldCrossHH(Fold, i);
    
    end;
    
    if strcmpi( opts.meth,'DL' )
        
        % create two-stage pipeline (DL+SVM)

        C=pipeline_dl_svm(opts,Train,Test);

        ConfusionMatrix=ConfusionMatrix+C.Test_CMTX;

        fname=[ dfold '/P_' num2str(i) '.mat'];

        save( fname, 'C' ); 
        
    else,
        
        fprintf('unrecognized method = %s\n', opts.meth );
        
    end;
    
	
end;

P=confusion_matrix_score( ConfusionMatrix );

fprintf('2x2 Measures Sens=%f, Spec=%.4f, PPV=%.4f, NPV=%.4f, ACC=%.4f\n', P.Sen, P.Spc, P.PPV, P.NPV, P.ACC);


