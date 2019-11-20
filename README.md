# Question
Do countries which export similar goods to the same customers fight more?

Chatagnier and Kavakli 2017 show that countries which export similar goods fight more. They did not account for competition over specific customers. They also did not examine import competition.

I will replicate and improve their work by adding country-specific data to the profiles and by examining product-based differences.

# Current State

Proof of Concept was a success. Next step is to process the data as described in correlator below.

# Proof of Concept
proof.of.concept.R applies Pearson's correlation to trade profiles from 3d.all18.csv to create dyadic2018.rds

I can use this same process to create dyadic trade competition profiles for each year.

# Correlator

This is my work-in-progress attempt to replicate the product-level correlations for exports, as C&K17 did, and for imports. 

Once I have finished processing these data, I will bind them with war data to analyze accordingly.

# End Game
Once I have dyadic trade competition, I will regress it against MIDs from the correlates of war project with appropriate controls.

# Potential improvement
## More Specific Product Codes
The more digits of a product code one uses, the more specific a trade profile can be built. I have downloaded 3-digits for the proof of concept, but 4 digits are available. That will be the next step.

## Monopolizability, High Rents, More Conflict
It may be the case that more monopolizable industries are more worth fighting over, since those industries could yield higher rents. It may be worthwhile to weight certain products accordingly.

# Data Sources
[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).
[Wits data came from here.](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData)