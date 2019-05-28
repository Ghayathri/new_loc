# <% binding.pry %>


Batsman
(allrounder == 3 && totalplayers < 11 && bowlers == 4) && batsman > 3
(allrounder == 3 && totalplayers < 11 && bowlers == 3) && batsman > 4
(allrounder == 2 && totalplayers < 11 && bowlers == 5) && batsman > 3
(allrounder == 2 && totalplayers < 11 && bowlers == 3) && batsman > 5
(allrounder == 1 && totalplayers < 11 && bowlers == 5) && batsman > 4
(allrounder == 1 && totalplayers < 11 && bowlers == 4) && batsman > 5



Bowlers
(allrounder == 3 && totalplayers < 11 && batsman == 4) && bowlers > 3
(allrounder == 3 && totalplayers < 11 && batsman == 3) && bowlers > 4
(allrounder == 2 && totalplayers < 11 && batsman == 5) && bowlers > 3
(allrounder == 2 && totalplayers < 11 && batsman == 3) && bowlers > 5
(allrounder == 1 && totalplayers < 11 && batsman == 5) && bowlers > 4
(allrounder == 1 && totalplayers < 11 && batsman == 4) && bowlers > 5


Allrounder
(totalplayers < 11 && bowlers == 5  && batsman == 4) && allrounder > 1
(totalplayers < 11 && bowlers == 4  && batsman == 5) && allrounder > 1
(totalplayers < 11 && bowlers == 4  && batsman ==3) && allrounder > 3
(totalplayers < 11 && bowlers == 3 && batsman == 4) && allrounder >3
(totalplayers < 11 && bowlers == 3  && batsman == 5) && allrounder > 2
(totalplayers < 11 && bowlers == 5  && batsman == 3) && allrounder > 2