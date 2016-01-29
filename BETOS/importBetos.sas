/* 
SAS script to import BETOS codes
 */
filename f url "https://raw.githubusercontent.com/chse-ohsu/PublicUseData/master/BETOS/betpuf14/betpuf14.txt";
data Work.lookupBetos;
    length
        hcpcs            $ 5
        codeBetos        $ 3
        termdate           8 ;
    drop
        filler ;
    label
        hcpcs            = "CPT-4/HCPCS"
        codeBetos        = "BETOS code"
        termdate         = "Termination Date" ;
    format
        hcpcs            $char5.
        codeBetos        $char3.
        termdate         yymmdd10. ;
    informat
        hcpcs            $char5.
        codeBetos        $char3.
        termdate         yymmdd10. ;
    infile f
        lrecl=17
        encoding="wlatin1"
        truncover ;
    input
        @1     hcpcs            $char5.
        @6     filler           : $1.
        @7     codeBetos        $char3.
        @10    termdate         ?? yymmdd8. ;
run;
data Work.lookupBetos;
  set Work.lookupBetos;
  facBetos = substr(codeBetos, 1, 1);
  length facBetosLabel $16;
  label facBetos = "BETOS category code" facBetosLabel = "BETOS category";
  if      facBetos = "M" then facBetosLabel = "E & M";
  else if facBetos = "P" then facBetosLabel = "Procedures";
  else if facBetos = "I" then facBetosLabel = "Imaging";
  else if facBetos = "T" then facBetosLabel = "Tests";
  else if facBetos = "D" then facBetosLabel = "DME";
  else if facBetos = "O" then facBetosLabel = "Other";
  else if facBetos = "Y" then facBetosLabel = "Except./unclass.";
  else if facBetos = "Z" then facBetosLabel = "Except./unclass.";
run;
