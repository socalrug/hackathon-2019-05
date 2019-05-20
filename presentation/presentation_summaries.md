OCRUG Hackathon Presentation Summaries
================

Ready to R
----------

-   Predicted the number of regulatory activities in each county out to 2050
-   Looked at the total population of the county and the percentage of residents supplied by public vs. private water systems
-   Looked at the total number of measured wells per year in each county

HydroPy
-------

-   Built an autoregressive model to forecast future water needs based on groundwater levels and population size
-   Predicted that in 2019, Fresno and Madera counties are not meeting their current water needs
-   Water needs do not appear to be related to population size, probably because of agricultural water requirements

Captain Rrrr
---------

### Winner: Visualization

-   Investigated relationship between population size and water depletion
-   Found a sharper gradient (faster groundwater depletion) in agricultural vs. urban counties
-   Orange County showed an opposite relationship to nearby large urban counties that could not be explained
-   Water levels are highly correlated with drought severity
-   Built a decision tree model to predict whether water level in 2019 is higher/lower compared to 2014

watRinspectR
------------

### Winner: Insight

### Runner-Up: Visualization

-   Looked at the violations by type of violation, analyte type, county, and year
-   Looked at combinations of analyte and violation type in different counties in 2018
-   Built two predictive models (random forest and naive Bayes) to predict the type of violation
-   88-89% accuracy with a no-information rate of 64-65%

Pionee
------

### Runner-Up: Insight

-   Arsenic violations in Kern County were much higher than in any other county
-   Number and severity of violations resulted in a $14,750 fine to Kern County Water System
-   New $14 million project to bring safe water to Arvin

Below The Mean
--------------

### Most Helpful Person: Sep Dadsetan

-   Investigated where violations occurred, what types of violations occurred, and how long it took to respond
-   The longest violation response time, on average, occurred in Del Norte County followed by Santa Cruz County
-   Built a model based on locally fitted Poisson regression to determine the number of violations in a given year
-   Found that many of the contaminants were actually coming from the water treatment systems

A Team Has No Name
------------------

-   Aggregated violations at both the county and ZIP code level
-   Built an interactive map of violations using Shiny
-   Although 1% of all measurements were "Dry Well", those wells ended up being about 5% of the measured well stations

Save the WoRld
--------------

### Winner: Model

-   Modeled the proportion of residents in fair/poor health in a county based on the contaminant levels and standard demographic controls
-   Investigated both ordinary least squares regression and generalized additive models
-   Arsenic appears to have a nonlinear effect not picked up by ordinary least squares
-   Started to look at how contaminants affect birth rates
-   Found a general decline in health (across multiple measures) in California since 2010
