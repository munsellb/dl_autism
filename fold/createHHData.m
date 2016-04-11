function HH=createHHData(H)

cnt=1;

for i=1:length(H),
    
    if strcmpi( H{i}.RISK, 'HR1') || strcmpi( H{i}.RISK, 'HR2'),
        
        HH{cnt}=H{i};
        cnt=cnt+1;
        
    end;
    
end;