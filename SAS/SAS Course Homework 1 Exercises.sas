/* SAS Data Ninja Homework 1 Excerises */

data mpi;
/* Change the order of the ISO and Country variables.Meaning, make country the first column and ISO the second column */
/* Allocate the correct number of bytes forall variables. */
length Country$40 ISO$3 MPIUrban 8 HeadcountRatioUrban 8 IntensityofDeprivationUrban 8 MPIRural 8 HeadcountRatioRural 8 IntensityofDeprivationRural 8;
delimiter= ',';
/* Import mpi_national.csv */
infile "/home/christopher33120/MPI_national (1).csv" DSD Missover Firstobs=2;
input ISO$ Country$ MPIUrban HeadcountRatioUrban IntensityofDeprivationUrban MPIRural HeadcountRatioRural IntensityofDeprivationRural;
/* Create a new variable that finds the difference between MPI Urban and MPI Rural. */
mpidifference = MPIUrban - MPIRural;
/* Replace the ‘NIG’ ISOvariable valuefor Nigeria and change it to: ‘NGA’ */
if ISO='NIG' then
substr(ISO,1,3) = 'NGA';
/* I want the ISO/Countryvalues to be brought togetherand be separatedby a comma.(ie Serbia, SRB).You can call the variablethat stores this‘combinedcountry’ */
combinedcountry = catx(delimiter, Country, ISO);
drop delimiter;
run;
      
/* Print/displaya subset of the datawhen Intensity of Deprivation Ruralis equal toor greater than 40.0. */
data filter;
set mpi;
If IntensityofDeprivationRural=>40;
RUN;

/* Correctly denote if a variable is character or numeric */
proc contents data=mpi;
run;
