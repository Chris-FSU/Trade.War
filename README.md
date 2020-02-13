# Questions
1) Do countries which export similar goods fight more?

2) Do countries which import similar goods fight more?

3) Do losers stop dealing in the same goods as victors once the war is over?

4) Do markets in certain goods cause more fights than others?

5) Do countries which export similar goods fight over the same customers?

Chatagnier and Kavakli 2017 show that countries which export similar goods fight more. They do not examine the same effects of imports, competition over specific customers, or whether it worked.

As used below, "similarity" is the Pearson's correlation between dollar values of all goods exported from a dyad-year. Two countries who export none of the same goods within the same year will have an export similarity of zero. Two countries who export all of the same goods in the same proportions  within the same year (regardless of economy size) will have an export similarity score of 1. The highest scores tend to be between oil exporting countries. 

The terms "similarity" and "competition" are used interchangeably below. This is because I assume that firms which sell similar goods are in market competition for resource inputs and customers.

# Results so far . . .

In pursuit of questions 1 and 2:

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/ExpImpSim.png)

As can be seen in the charts, countries generally have more similar imports than exports. The difference of exports is larger than the import difference between MID and peace dyads. There is a substantive difference in both cases. Countries who engage in MIDs have more market competition.

In pursuit of question 3:

To examine whether these types of MIDs accomplish their goals, the most relevant cases are those which began with the most export competition and had higher intensity conflicts. If war works as a method of removing market competitors, we should see a reduction in export similarity especially in those cases.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/ExpChangeHost1.png)

In the above chart, X is pre-MID export competition, and Y is post-MID export competition. A black line has been drawn at 45 degrees for reference. Dyads whose export similarity has not changed over the duration of the MID would be on the 45 degree line. Data below the 45 degree line indicate a reduction of export similarity from the beginning to the end of the MID. If states with more similar exports are fighting to remove each other from the market (as Chatagnier and Kavakli claim) and it works (as I claim), then we should expect regression lines below 45 degrees. We do, in fact, see that, but only as hostility increases. It seems that high-hostility MIDs correlate with reduced export competition.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/LosersWeep.png)

Losers' export profiles change more during the course of a war than winners' export profiles do. This is exactly what we should expect if winners force losers out of the markets in which they were previously competing. In this chart, MIDs in which neither side was coded as having "yielded" or achieving "victory" were coded as "Neither", for reference.

This effect is exacerbated by the level of hostility in a conflict. In more hostile conflicts, losers' export profiles change more drastically than in less hostile conflicts. Hostility level does not change the winners' exports.

Run script Q3b.R for more information.

# Current State

# Next

Make a dataset with all of the controls used by C&K17 for replication of their work (pursuant to Q1) and for my extension (pursuant to Q2).

I can also use the WITS data to try to extend this model beyond 2000.

Pursuant to Q4, establish averages for profiles of MID and non-MID country-years. Subtract one from the other. Examine whether the largest absolute values have some feature in common (for example, high rent-seeking potential).

Q5 will be a doozy. I need a triadic dataset of trade portfolios and MIDs. Check all MID dyads for high levels of exports to the same country cs. Assuming Q4 yields positive results, these country cs will likely be purchasing large volumes of those goods. 

# End Game
Regress export similarity and import similarity against MIDs from the correlates of war project with appropriate controls. (Pursuant to Q1 & Q2)

Determine whether some common feature exists between exports over which dyads tend to fight. (Q4)

Determine whether fighting dyads tend to export large volumes of goods to the same customers (Q5)

# Data Sources
[Chatagnier and Kavakli's article can be found here](https://journals.sagepub.com/doi/abs/10.1177/0022002715613565?journalCode=jcrb).

[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).

[Wits data came from here](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData).

[COW data came from the Dyadic Inter-state War Dataset here](https://correlatesofwar.org/data-sets/COW-war).