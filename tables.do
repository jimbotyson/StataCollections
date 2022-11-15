 use https://www.ucl.ac.uk/~ccaajim/results, clear

 collect clear

 sort gender teacher

 quietly collect: by gender teacher: summarize maths

 collect layout (gender) (teacher) (result[mean])
 
 putdocx begin
 putdocx collect
 putdocx save mytable, replace

 collect clear

 sort gender teacher

 quietly collect: by gender teacher: summarize maths

 collect style cell result[mean], nformat(%5.2f)

 collect layout (gender) (teacher) (result[mean])
 
 