<p align="center">
  <img src='https://ucarecdn.com/b23cdfa3-9e8d-4799-aa9b-6c9af94f2d67/' alt="Cascade Debt" width=350px/>
  <br><br>
</p>

# Skill Assessment: _dbt_ Data Engineer

## Background

:clap: A sincere congratulations on progressing your candidacy for the Data Engineer role at Cascade Debt! This role is a critical part of our ELT pipeline team, and will largely address transformation from client raw data models into frontend mart models. As such, we'd love for you to show off your dbt skills to us! :sunglasses: 

For this final assessment, please build a dbt project that addresses the problem listed below. Ensure that you have it cloned to a git-based sharable repository, and that you have a README.md file in the repository's root discussing your analysis for the problem. You may use whichever SQL database flavor you prefer (we use PostgreSQL), just state which was chosen in your README.md. 

---

## Problem: *Where in the World is Carmen Sandiego*? 

<table>
  <tr>
    <td> <img src="https://www.mobygames.com/images/covers/l/32898-where-in-the-world-is-carmen-sandiego-deluxe-edition-dos-front-cover.jpg" alt="WIWICSD" width=150px/></td>
    <td width=450px> 
        Some may know this <a href="https://en.wikipedia.org/wiki/Carmen_Sandiego_(video_game_series)">popular game franchise</a> in which players answer questions to solve the titular riddle. Your task today is an homage to this game! You've recently come aboard Interpol's team as a data engineer. Their dedicated data team has collected, parsed, and assembled several agent field reports over the years, but in Excel only. Their final collection is provided in the next subsection - your task is to engineer this data to provide analytical answers to the Interpol team!
    </td>
  </tr>
</table>

---

## Data Sources & Common Model Development

The data is contained in the attached Excel workbook [*carmen_sightings_20220629061307.xlsx*](https://github.com/cascadedebt/skills-assessment-data-engineer/blob/f913f119c3ab2aab4630f4ab0aecfe4d1b3f54b0/carmen_sightings_20220629061307.xlsx). Note the sheets are organized by eight (nearly continential) **regions** - there is an Interpol agency HQ in a city of each region to which the agents report. Each agency HQ uses their own language or dialect to compile their regional reports, but those reports are in [first normal form (1NF)](https://en.wikipedia.org/wiki/First_normal_form). 

> 1. _The first step of your task is to extract data from Excel workbook, treating as initial sources._
> **HINT:** _CSV exports into `seeds` - whether by Excel or pandas - is a great way to start..._ :eyes:

As seen from the data, agencies are free to name report columns according to their custom - but let's call each "yablaka" an apple! :apple: 
Each source ought follow a _common data dictionary_ of 

| Column | Description | Type |
| ------------ | ----------- | -----|
| date_witness | Date of witness sighting | date |
| witness | Name of witness sighting the perpetrator | string |
| agent | Name of field agent filing the report | string |
| date_agent | Date of field agent filing the report | date |
| city_agent | HQ city where field agent files the report | string |
| country | Country of sighting | string | 
| city | City of sighting | string |
| latitude | Latitude of sighting | float |
| longitude | Longitude of sighting | float |
| has_weapon | Was the perpetrator observed to be armed? | boolean |
| has_hat | Was the perpetrator wearing a hat? | boolean |
| has_jacket | Was the perpetrator wearing a jacket? | boolean |
| behavior | Short description of perpetrator behavior | string |

> 2. _The second step of your task is to create view models that columnarly maps these eight different sources, each into this common data dictionary._ 
> **HINT:** _You can do this as you wish - via CTE stages, macros, go wild! The end result however must be a view model for each source._ 

Now that you have eight models, all with the same columns - join them together, but with a caveat:

> 3. _The third step of your task is to join the six different views into ONE schema that goes beyond 1NF (\[2-6\]NF, BCNF). You have a great deal of design freedom here, so get creative! Just persist final resulting schema as tables into a new schema - please present your design's entity-relation-diagram in your README.md._

---

## Analytics

* This new schema includes the >1NF model you've just developed, as tables. From this model, it ought be fairly straightforward for you to create analytical view(s) to answer the following questions:

    a. For each month, which agency region is Carmen Sandiego most likely to be found? 

    b. Also for each month, what is the probability that Ms. Sandiego is armed __AND__ wearing a jacket, but __NOT__ a hat? What general observations about Ms. Sandiego can you make from this? 

    c. What are the three most occuring behaviors of Ms. Sandiego?

    d. For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?

> 4. _Create analytical views in your new schema to answer the four above questions. Document your steps and logic in your README.md._
> **HINT:** _`dbt docs` (and its screenshots) are a great resource!_

---

## Submission

>**NOTE:** Throughout, I've referenced `README.md`. If you are unfamiliar with [GitHub Markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax), feel free to use your most convenient method: Word document, Google Doc, textfile (with image attachments), html - however you can best communicate your thoughts and ideas!

* **Ensure that your project runs fully BEFORE submission!** 

* Verify that you have the f analytical questions answered in your README.md, and you are confident with your presentation. 

* Push and merge into your git repository's main branch. 

* Submit your project's git repository URL to either the Rippling comms channel or via email to `joshua@cascadedebt.com`.
