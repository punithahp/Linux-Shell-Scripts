# Linux-Shell-Scripts
This Git folder or Repo contains projects related to Linux shell scripting (ETL, automated run/scheduling using crontab). 

**Business usecase of this project:**
There is a need to create an automated Extract, Transform, Load (ETL) process to extract daily weather forecast and observed weather data and load it into a live report to be used for further analysis by the analytics team. 

**Requirements:**
1. As a proof-of-concept (POC)need to be completed for a single station and one source to begin with. For each day at noon (local time), need to gather both the actual temperature and the temperature forecasted for noon on the following day for Casablanca, Morocco.

2. At a later stage, the team anticipates extending the report to include lists of locations, different forecasting sources, different update frequencies, and other weather metrics such as wind speed and direction, precipitation, and visibility.

3. Data source: use the weather data package provided by the open source project wttr.in, a web service that provides weather forecast information in a simple and text-based format. For further information, you can read more about the service on its GitHub Repo.

4. You must extract and store the following data every day at noon, local time, for Casablanca, Morocco: wttr.in/casablanca and wttr.in/morocco
  The actual temperature (in degrees Celsius)
  The forecasted temperature (in degrees Celsius) for the following day at noon
  Here is an example of what the the resulting weather report should look like:


  year  month  day  obs_tmp  fc_temp
  
  2023  1  1  10  11
  
  2023  1  2  11  12
  
  2023  1  3  12  10


**Steps involved:**

a. Download raw weather data

b. Extract data of interest from the raw data

c. Transform the data as required

d. Load the data into a log file using a tabular format

e. Schedule the entire process to run automatically at a set time daily


**Code/Shell script:**

Please refer to the "Daily_Weather_Report_Obs_Versus_Fcs.sh" folder in the repo for code/script details.

**Scheduling**

The requirement is to run the job at noon everyday depending on the target city timezone. Please note the system time we are running is in a different timezone. so, we need to find the UTC date for both the timezones and then find the difference between the 2 zones. This will help find the right system time to run the script on a daily basis.

example:

  Running the following commands gives you the info you need to get the time difference between your system and UTC.
      
      *$ date*
      
      *Mon Feb 13 11:28:12 EST 2023*
      
      *$ date -u*
      
      *Mon Feb 13 16:28:16 UTC 2023*
  

From the example above, we see that the system time relative to UTC is UTC+5 (i.e., 16 - 11 = 5).
We know Casablanca is UTC+1, so the system time relative to Casablanca is 4 hours earlier. Thus, to run your script at noon Casablanca time, you need to run it at 8 am.

    Create a cron job that runs your script:
      
      #enter the below command in the terminal
      
      *crontab -e*
    
      
      #In the crontab screen, you can schedule the job as follows:
      
      *0 8 * * * /home/project/Daily_Weather_Report_Obs_Versus_Fcs.sh*
  
