title1 'Potthoff'; run;
Proc Format; Value gr 1='Experimental' 0='Control'; run;
data Potthoff; infile 'D:\_Stats\SimData\MultRegr\Potthoff-nn.dat'; input Group Time Exam Interaction;  Format Group gr. ;  run;
Proc Standard Mean = 0 STD = 1 Out = Zs; Var Time Exam; run;
proc sgplot; reg x = Time y = Exam / group = Group; run;
proc reg data=Zs PLOTS=none; model Exam = Group Time Interaction; TEST Group=0, Interaction=0;
Title1 "Test of Coincidence"; run; QUIT;
Proc GLM data=Zs PLOTS=NONE; Class Group; Model Exam = Time Group / ss3; LSMeans Group; Title1 "ANCOV";  run; QUIT;
Title1 "Process";
%process (data=Zs,y=Exam,x=Time,w=Group,model=1,jn=1,plot=1);
Proc Ttest plots=none; Class Group; Var Exam; Title1 "T-Test";  run;
proc corr nosimple; var Time; with Exam; Title1 "Correlation"; run;
