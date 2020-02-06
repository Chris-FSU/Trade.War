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

Among dyads engaged in a MID (red line), export similarity (left) and import similarity (right) are both higher than the averages among non-MID dyads (black line). The chart to the left reaffirms the findings of Chatagnier and Kavakli and answers question 1. 

The chart to the right answers question 2. In the time period covered, import similarity is much higher for dyads engaged in MIDs than for peaceful dyads.

In pursuit of question 3:

To examine whether these types of MIDs accomplish their goals, the most relevant cases are those which began with the most export competition and had higher intensity conflicts. If war works as a method of removing market competitors, we should see a reduction in export similarity especially in those cases.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/ExpChangeHost1.png)

The Y axis is pre-MID export competition minus post-MID export competition. Lower Y values indicate that export similarity reduced over the duration of the MID. The X axis is pre-MID export competition. Higher X values indicate more similar exports. If states with more similar exports are fighting to remove each other from the market (as Chatagnier and Kavakli claim) and it works (as I claim), then we should expect downward sloping regression lines. We do, in fact, see that, but only as hostility increases.

In a regression of the change of export competition on both hostility and pre-MID export competition, the interaction was statistically significant and negative. The coefficient was -.064. Holding hosility equal, higher levels of pre-MID export competition yield higher levels of export similarity. This is unexpected but lends credibility to the interaction effect, which occurs in the opposite direction. Holding export competition equal, hostility level does not have a significant estimated effect on export competition reduction. As the two increase together, they interact to reduce post-MID export similarity. In higher hostility MIDs, dyads with more similar pre-MID exports havea greater reduction in that export similarity by the end of the conflict.

I have not differentiated between winners and losers. It seems likely that losers are the ones to back out of the market, but I need further analysis to confirm this.

# Current State

Imports and Exports are ready for differentiation between the trade profiles of aggressors, defenders, joiners, and non-warring states.

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