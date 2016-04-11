function P=confusion_matrix_score(S)

Sensitivity=S(1,1)/sum(S(:,1));
Specificity=S(2,2)/sum(S(:,2));
PPV=S(1,1)/sum(S(1,:));
NPV=S(2,2)/sum(S(2,:));
ACC=(S(1,1)+S(2,2))/(sum(S(1,:))+sum(S(2,:)));

P.Sen=Sensitivity;
P.Spc=Specificity;
P.PPV=PPV;
P.NPV=NPV;
P.ACC=ACC;
