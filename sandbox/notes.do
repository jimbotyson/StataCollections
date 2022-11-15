sysuse auto

graph box mpg, ///
	title("A Simple Box Plot") ///
  subtitle("There is only one group in this graph.") ///
  note("In later graphs we will subset the data.") ///
  over(foreign) ///
  asyvars