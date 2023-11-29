# Dog-Shelter-Project 

# Purpose
This is an end-to-end personal project looking at several online datasets on dog (and cat) adoptions in the USA. 
I wanted to determine whether there were any trends or noteworthy conclusions that could be determined from the data. Among other things, I looked into whether the claim that animal shelters were "empty" in the USA during the 2020 lockdowns was a result of a significant increase in adoptions.
I also looked at which states and which years (2019-2022) had the highest and lowest intakes, adoptions, and euthanasia of dogs (and cats).
And I looked at available data to determine which dog breeds, colours, ages, and sizes were the most likely to be up for adoption and to be adopted in the USA. 

# Methods
I cleaned and queried the data primarily using Microsoft SQL Server. 
I visualised data using Tableau public. The dashboard for this project can be found at: https://public.tableau.com/app/profile/ana4474/viz/NationalCanineAdoptionTrends/Dashboard1

# Main Conclusions
Fewer dogs were adopted from shelters in 2020 than any other year from 2019-2022. The highest number were adopted out in 2019. This contradicts the idea that shelters were empty because more people were adopting dogs during lockdowns. The missing piece of the puzzle may be that fewer dogs were also relinquished to shelters by their owners in 2020 than any other year for which I analysed the data, while more dogs were relinquished by their owners in 2019 than any other year.

Labrador Retrievers and Lab mixes were among the most likely breed to be up for adoption while the most common purebred dogs up for adoption were Pit Bull Terriers. 
Young dogs and puppies had the shortest average wait time to adoption while senior dogs had the longest wait time to adoption, which matched with my hypothesis. 
However, although I had seen claims that large dogs are harder to adopt out than small dogs, my data did not bear this out and showed no real differnece in time to adoption based on dog size.

# Other Notes and Further Research
While the data that was used in this project was varied and I believe largely useful in answering my hypotheses, it was also incomplete.
For instance, data on US shelters nationally was collected on a voluntary basis, and therefore many more shelters didn't participate than did. 
The available data to determine which dog breeds, ages, etc. was only collected for one month and it wasn't always possible to know from the available data when a dog
was first listed on the site, or when it was adopted out in cases when the adoption occurred before the first date or after the last date of data collection.
My doubt in some of these findings is furhter supported by the fact that in almost all cases, I did not see the results I expected. 
Therefore, while I am confident in the queries and methods used, I would like to repeat these queries with a more complete dataset if such becomes available in the future. 
