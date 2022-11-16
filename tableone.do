
collect label levels gender 1 "girl" 2 "boy"	   

table (gender) (teacher), ///
       statistic(frequency) ///
       statistic(percent) ///
       statistic(mean maths) ///
       statistic(sd maths) ///
       nototals ///
       nformat(%9.0fc frequency) ///
       sformat("%s%%" percent) ///
       nformat(%6.2f  mean sd) ///
       sformat("(%s)" sd) ///
	   style(table-1)
	   
use https://www.ucl.ac.uk/~ccaajim/results, clear
collect clear
collect label levels gender 1 "girl" 2 "boy"	
sort gender teacher
quietly collect: by gender teacher: summarize maths
collect style cell result[mean], nformat(%5.2f)
collect layout (gender) (teacher) (result[mean])
collect dims	   