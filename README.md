# Introduction

As established by [Tyson Chatagnier and Kerim Kavakli 2017](https://journals.sagepub.com/doi/abs/10.1177/0022002715613565?journalCode=jcrb), countries which export similar goods are more likely to engage in militarized interstate disputes. By lobbying for interstate conflict, firms can remove interstate competitiors in their industries.
In the aftermath of militarized interstate disputes, losers leave markets in which they previously competed with the victors. This evidence suggests that lobbying for war is a viable alternative to market competition for firms seeeking to remove interstate competition.

# Revisiting Chatangier and Kavakli's findings

As used below, "similarity" is the Pearson's correlation between dollar values of all goods exported from a dyad-year. Two countries who export none of the same goods within the same year will have an export similarity of zero. Two countries who export all of the same goods in the same proportions within the same year (regardless of economy size) will have an export similarity score of 1. The highest scores tend to be between oil exporting countries. 

The terms "similarity" and "competition" are used interchangeably below. This is because I assume that firms which sell similar goods are in market competition for resource inputs and customers.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/ExpImpSim.png)

Summary Stats  |1st Quartile |Median      |Mean 3rd     |Quartile
-------------------------------------------------------------------
MID Exports    |0.0049918096 |0.036941446 |0.12774894   |0.18326042
No MID Exports |0.0001010672 |0.003017975 |0.03495137   |0.01970459
MID Imports    |0.0435457832 |0.103477091 |0.15263261   |0.20258291
No MID Imports |0.0281341570 |0.068383682 |0.10613178   |0.14084482

Export similarity is higher among MID dyad-years than among non-MID dyad-years. Import similarity is also higher for MID versus non-MID dyad-years. The correlation between MIDs and trade profiles is stronger for exports than for imports.

Exports tend to be more specific to a country's production factor endowments. A country can't export what it can't produce. Imports do not tend to be so specific because they include goods not used for industry. Thus, it is unsurprising that the correlation is stronger for imports than for exports and that imports are generally more similar than exports are.

The explanation given by Chatagnier and Kavakli is that firms with interstate competitors lobby their governments to take more hostile postures toward each other. They intend to remove competitors from the market by force. I investigate whether this goal is achieved by militarized interstate disputes.

# Evidence for My Claims

Losers leave markets. Two forms of evidence are shown below. First, trade similarity within a dyad decreases from the onset of a MID to the end of that MID. Second, trade similarity between a state before an MID and that same state after an MID is less similar for losers than for winners. In other words, losers' export portfolios change more drastically than winners' export portfolios do over the course of an MID. For both pieces of evidence, the effect is much stronger with more hostile MIDs (i.e. actual war rather than threats).

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/ExpChangeHost1.png)

In the above chart, X is pre-MID dyadic export competition, and Y is post-MID dyadic export competition. A black line has been drawn at 45 degrees for reference. Dyads whose export similarity has not changed over the duration of the MID would be on the 45 degree line. Data below the 45 degree line indicate a reduction of export similarity from the beginning to the end of the MID. If states with more similar exports are fighting to remove each other from the market (as Chatagnier and Kavakli claim) and it works (as I claim), then we should expect regression lines below 45 degrees. We do, in fact, see that, but only as hostility increases. It seems that high-hostility MIDs correlate with reduced export competition.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/LosersWeep.png)

This chart shows the distribution of similarities between a state's Pre-MID export portfolio and that same state's post-MID export portfolio. 1 indicates an identical export portfolio before and after the MID. 0 indicates an absolutely different export portfolio. 

Losers' export portfolios change more during the course of a war than winners' export portfolios do. This is exactly what we should expect if winners force losers out of the markets in which they were previously competing. In this chart, MIDs in which neither side was coded as having "yielded" or achieving "victory" were coded as "Neither", for reference.

![](https://github.com/Chris-FSU/Trade.War/blob/master/fig/LosersWeepHarder.png)

This chart shows the same information for only the two highest levels of hostility: Use of Force and War. The export-altering effect is exacerbated by the level of hostility in a conflict. In more hostile conflicts, losers' export portfolios change more drastically than in less hostile conflicts. Hostility level does not change the winners' exports.

# Preliminary Result

Lobbying for interstate conflict seems to be an effective means of removing interstate market competitors.

# Data Sources
[Chatagnier and Kavakli's article can be found here](https://journals.sagepub.com/doi/abs/10.1177/0022002715613565?journalCode=jcrb).

[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).

[Wits data came from here](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData).

[COW data came from the Dyadic Inter-state War Dataset here](https://correlatesofwar.org/data-sets/COW-war).