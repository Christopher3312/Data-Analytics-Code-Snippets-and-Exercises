/* SAS Data Ninja Homework 2 Excerises */

data employees;
length name$30 jobtitles$50 dep$25 fullorpart$20 salorhour$1 typicalh 8 annuals$20 hourlyr$15;
/* Import Current_Employee_Names__Salaries__and_Position_Titles (2).csv */
infile "/home/christopher33120/Current_Employee_Names__Salaries__and_Position_Titles (2).csv" DSD Missover Firstobs=2;
input name$ jobtitles$ dep$ fullorpart$ salorhour$ typicalh annuals$ hourlyr$;
/* Convert annuals and hourlyr variables from characters to numeric values */
numannuals = input(annuals,comma11.);
numhourlyr = input(hourlyr,comma9.);
/* Return either the employees salary or hourly rate, which ever comes first */
salorhourly = coalesce(numannuals, numhourlyr);
run;

/* Correctly denote if a variable is character or numeric */
proc contents data=employees;
run;

/* Return only employees that earn over $50 an hour */
PROC PRINT DATA = employees(where=(numhourlyr>=50));
var name numhourlyr;
format numhourlyr dollar11.2;
RUN;
