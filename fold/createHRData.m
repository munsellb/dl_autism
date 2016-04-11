function [H,L]=createHRData(F)

idx_h=[];
idx_l=[];

for i=1:length(F),
    
    if strcmpi( F{i}.RISK, 'HR1') || strcmpi( F{i}.RISK, 'HR2'),
        
        idx_h=[idx_h i];
        
    elseif strcmpi( F{i}.RISK, 'LR1' ),
        
        idx_l=[idx_l i];
        
    end;
    
end;

H=cell(1,length(idx_h));
L=cell(1,length(idx_l));

for i=1:length(idx_h),
    H{i}=F{idx_h(i)};
end;

for i=1:length(idx_l),
    L{i}=F{idx_l(i)};
end;