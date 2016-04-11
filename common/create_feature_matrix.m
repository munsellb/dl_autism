function M=create_feature_matrix( C, L )

M=[];

for i=1:length(C),

    acq_age_12 = C{i}.V12AGE;
    acq_age_6 = C{i}.V6AGE;
        
    sx6 = acq_age_6/6;
    sx12 = acq_age_12/12;
        
    csa6 = ( C{i}.CSA_V6 ).*sx6;
    csa12 = ( C{i}.CSA_V12 ).*sx12;
        
    cth6 = ( C{i}.CTH_V6 ).*sx6;
    cth12 = ( C{i}.CTH_V12 ).*sx12;
        
    csa = [ csa6 csa12 ];
    cth = [ cth6 cth12 ];

    icv = [ C{i}.ICV6*sx6 C{i}.ICV12*sx12 ];

	dem = [];

	if strcmp( C{i}.GENDER, 'M' ),

		dem = [ dem 1 ];
        
	else,

		dem = [ dem 0 ];

	end;
                
    M=[M ; [abs(log(csa)) abs(log(cth)) abs(log(icv)) dem L] ];
    
end;

	
