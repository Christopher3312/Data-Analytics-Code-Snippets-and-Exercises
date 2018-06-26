/* SAS Data Ninja Course Case Study */

/* Load data in and format Date of Birth */
data identifyconditions;
infile "/home/christopher33120/casestudy (2).csv" DSD MISSOVER FIRSTOBS=2;
input ID$ SEX$ DOB Pdx Dx_2 Dx_3 Dx_4; 
informat DOB date9.;
run;

/* Sort data by ID into a new data step */
proc sort data = identifyconditions out = identifyconditionstwo;
by ID;
run;

proc print data=identifyconditionstwo;
format DOB date9.;
run;

data MemberConditions; 
set identifyconditionstwo; 
by ID; 
length Diabetes Depression COPD Asthma  
CKD HIV Schizophrenia Hypertension Migraine $14 Conditions $50;
retain Diabetes Depression COPD Asthma CKD HIV Schizophrenia Hypertension Migraine 
Conditions;

/* Reset variables to missing */ 
if first.ID then 
do; 
Diabetes ="";
Depression ="";
COPD =""; 
Asthma =""; 
CKD="";
HIV="";
Schizophrenia="";
Hypertension="";
Migraine="";
end;

/* Set condition variable when match found */ 
array diag(4) Pdx Dx_2 Dx_3 Dx_4;
do i= 1 to 4;
if diag(i) in: ("25000")
then Diabetes="Diabetes";
if diag(i) in: ("29620")
then Depression="Depression";
if diag(i) in: ("4912")
then COPD="COPD";
if diag(i) in: ("493")
then Asthma="Asthma";
if diag(i) in: ("40300")
then CKD="CKD";
if diag(i) in: ("042")
then HIV="HIV";
if diag(i) in: ("3310")
then Schizophrenia="Schizophrenia";
if diag(i) in: ("5723")
then Hypertension="Hypertension";
if diag(i) in: ("34631")
then Migraine="Migraine";
end;

/* Add up total conditions each person has */ 
if last.ID then do; 
TotConditions = sum(( Diabetes ne ""),( Depression ne ""), (COPD ne ""),
( Asthma ne ""), (CKD ne ""),(HIV ne ""),(Schizophrenia ne ""),
(Hypertension ne ""), (Migraine ne "") ); 
 
/* List each condition should they have it */ 
Conditions = catx(", ", Diabetes, Depression, 
COPD, Asthma,CKD,HIV,Schizophrenia,Hypertension,Migraine); 
output; 
 end;

/* Final output variables */ 
keep ID Sex DOB ToTConditions Conditions; 
run;

/* Run the data step */
proc print data=MemberConditions;
format DOB date9.;
run;
