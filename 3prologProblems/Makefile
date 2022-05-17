newBusCompany: newBusCompany.pl
	swipl -q -O -g main --stand_alone=true -o newBusCompany -c newBusCompany.pl

events: events.pl
	swipl -q -O -g main --stand_alone=true -o events -c events.pl

teams: teams.pl
	swipl -q -O -g main --stand_alone=true -o teams -c teams.pl

miSudoku: miSudoku.pl
	swipl -q -O -g main --stand_alone=true -o miSudoku -c miSudoku.pl


clean:
	rm clauses header model infile.cnf
	rm events teams newBusCompany
