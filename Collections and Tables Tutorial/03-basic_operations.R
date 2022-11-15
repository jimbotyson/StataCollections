 use https://www.ucl.ac.uk/~ccaajim/results

 collect clear

 sort gender teacher

 quietly collect: by gender teacher: summarize maths

 collect layout (gender) (teacher) (result[mean])



 use https://www.ucl.ac.uk/~ccaajim/results

 collect clear

 sort gender teacher

 collect: by gender teacher: summarize maths

 collect style cell result[mean], nformat(%5.2f)

 collect layout (gender) (teacher) (result[mean])

