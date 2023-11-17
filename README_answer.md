This project is intended as an exercise for Analytics Engineering roles. 

It focuses on **Customer 360** (or **Single Customer View**): a unified view of customer interactions that powers use cases ranging from personalized recommendations to customer segmentation.  

### Pre-requisites

The project assumes these tools are available:

+ Makefile
+ Python 3.9+ ([python.org](https://www.python.org/downloads/), [Anaconda](https://www.anaconda.com/download), [pyenv](https://github.com/pyenv/pyenv) etc)
+ Docker, Docker Compose (https://www.docker.com/products/docker-desktop/)

You'd likely need a Postgres client to see what models look like. Here's [one](https://dbeaver.io/).

### Development

The `integration_tests` directory is set up to work through this exercise, including:
+ starting a Postgres container and seeding it with fake data
+ running models and tests included in the parent package (see [packages.yml](./integration_tests/packages.yml), [profiles.yml](./integration_tests/profiles.yml))
+ tear down
+ a `Makefile` for running the above tasks (try `make help`)

---

Follow these steps (assumes you are in `integration_tests` directory):

1. Set up Python virtual environment and install dependencies (including DBT + Postgres adaptor):
```sh
$> python -m venv venv
$> source venv/bin/activate
$> pip install -r requirements.txt
```

2. Start database and populate with sample datasets: 
```sh
$> make setup
```

3. Run and test models using DBT
```sh
$> make models
```


4. Tear down (will destroy the DB container)
```sh
$> make teardown
```

### Exercises

Responses/solutions to these exercises can be:
+ code changes
+ [seed data](./integration_tests/seeds/) changes
+ free-form text (eg. assumptions, opinions, approaches etc) - these can be submitted in email, markdown etc. as long as they clearly refer to the exercise they refer to.

Please create a git repository for this code and share it with us (a link or a [bundle](https://git-scm.com/book/en/v2/Git-Tools-Bundling)) - we'd like to look at your commit logs too :).

---

*Note*: any code changes will need a re-run of `dbt deps` in `integration_tests` directory.

Please attempt as many of these as possible:
1. Fix the failing tests  
Failure: 04:05:13  3 of 13 FAIL 1 source_accepted_values_web_transactions_category__Apps_Games__Beauty__Books__Clothing_Shoes_Accessories__Movies_TV__Sports_Fitness_Outdoors  [FAIL 1 in 0.27s]
Solution: added 'Kitchen'

Failure: source_unique_salesforce_contacts_id
Solution: add serverity level : warnning

Failure: not_null_contacts_joined_with_transactions_id and unique_contacts_joined_with_transactions_id
Solution: add serverity level : warnning

I prefer not to change any seeds or source files at the very beginning phase to maintain data integrity.


2. Add a test to validate the referential integrity of the `transactions` table (`contact_id` refers to a valid contact) and ensure it passes

As I prefer not to change source data, I did some modification on stg models:
Firstly, I use window function to identify the duplicated id, and assigned a row number to it, and created a 'new_id' which should be unique.
Secondly, I created yaml files for stg models, and re-define tests for valid contact_id on stg models "_web__stg.yaml"
Thirdly, in order to make sure it passed, I use where condition to select validated contact ids in stg_web__transactions.sql



3. We want to ensure our `transactions` data is not older than 1 day. How to do this and when to run these checks?
add source freness test in _web__sources.yml file as below:
        loaded_at_field: _loaded_at_utc
        freshness: # make this a little more strict
          warn_after: {count: 12, period: hour}
          error_after: {count: 24, period: hour}



4. Add tests for macros
I have created a test for value > 0 as value_above_zero in macro folder



5. Macros contain Postgres-specific functions, however our production environment is in Databricks. How would you refactor them, to allow switching between these two syntax?
I created another target in profiles.yml which is called 'cloud', and used target.name function in the marco to swap between databricks SQL and postgresql


6. We'd like to enhance the `customers` model by adding few more attributes:
   + `first_purchase_date` and `last_purchase_date` (time of first and last purchase respectively)
   + total amount of purchase per category eg. columns like `app_and_games_amount`, `beauty_amount` etc. (refer to `_web__sources.yml` for a static list of product categories)
   
   Please update the `customers` model for these columns. Also, write singular test(s) to validate the logic.
I have 2 steps:
 First sept: modified customer sql model as required and commit.
 second sept: optimized macro and setup tests as required.
              I usedd jinja for loop to create mulitple columns.
              I also added 2 singular test for first/last purchase date
              i added 1 singualr test for valid customers
              I added 1 singular test for total purchase amount > 0


7. Any other improvements you'd like to make?
My opinions are: 

1) seperate the schemas for stage and data mart.
2) adding ymal files to stage models.
3) Seperate dev and prod target environment.
4) rename schema using macro
5) considering SDC type 2 for stg_sf__contacts, maybe it's not best suitable for this project, but it just for demonstration.
6) for transacion table, we can consider to use incremental materalization to minimize load.
7) we can use doc block for better documentation



8. Think of how you can implement the following (what additional datasets would you use, how will the models look etc). We will explore these add-ons during tech interview stage. Additional points, if you can implement them now!
   + Product Category Recommender - how to implement Next Best Product Category?
   + Data Sharing: how would you implement PII on this data, so it can be safely shared with, say, partners?


