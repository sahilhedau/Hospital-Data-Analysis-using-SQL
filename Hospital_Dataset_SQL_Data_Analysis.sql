create database Hospital;
use Hospital;

select * from hospital_data;

# total no of patients
select count(*) as total_patients from hospital_data;	

# avg age of patients
select avg(Age) as avg_age from hospital_data;

# avg age of people who are recovered
select avg(Age) as avg_age_recovered from hospital_data
where Outcome = 'Recovered'	;

# most common health condition
select Health_condition, count(*) from hospital_data
group by Health_condition
order by count(Patient_ID) desc;

# total recovered
select count(*) as total_recovered from hospital_data
where Outcome = 'Recovered';

# count recovery rate
select ((select count(*) from hospital_data
where Outcome = 'Recovered') / count(*)) * 100 as recovery_rate from hospital_data;


# recovered w.r.t health condition
select Health_condition,count(*) as total_patients, sum(Outcome = 'Recovered'), 
(sum(Outcome= 'Recovered')/count(*)) * 100 as recovery_rate from hospital_data
group by Health_condition
order by recovery_rate asc;

select Health_condition,count(*) as total_patients, sum(Outcome = 'Recovered'), 
(sum(Outcome= 'Recovered')/count(*)) * 100 as recovery_rate from hospital_data
group by Health_condition
order by recovery_rate;
# therefore, diabetes, stroke, hypertension, heart attack, respiratory infection, Osteorthritis has 0 recovery rate, they need to work on it 

# avg days of staying of the patients who are recoverd vs not recovered
select count(*) as total_patients, Health_condition, 
avg(Length_of_stay) as avg_days from hospital_data
where outcome != 'recovered'
group by Health_condition
order by avg_days desc;

# Satisfactory rate
Select Health_condition, Outcome, avg(Satisfaction) 
as avg_Satisfaction from hospital_data
group by Health_condition, Outcome
order by avg_Satisfaction asc;

Select Health_condition, Outcome, avg(Satisfaction) as avg_Satisfaction from hospital_data
group by Health_condition, Outcome
order by avg_Satisfaction; # Stroke and heart attack satisfaction level is low

# satisfaction after recovery
Select Health_condition, Outcome, avg(Satisfaction) 
as avg_Satisfaction from hospital_data
where outcome = 'Recovered'
group by Health_condition, Outcome
order by avg_Satisfaction; 
# appendicitis is low

#Total amount of readmission percentage
select ((select count(*) from hospital_data where Readmission = 'Yes') / count(*))*100 
as Readmission_Rate from hospital_data;

# readmission rate w.r.t health_condition
select Health_condition, count(*) as total_patients,sum(Readmission='Yes')
as readmitted_patients, (sum(Readmission = 'Yes')/count(*)) * 100 as readmission_rate 
from hospital_data
group by Health_condition
order by readmission_rate;

# readmission rate after recovered
select Health_condition, count(*) as total_patients,sum(Readmission='Yes')
as readmitted_patients, (sum(Readmission = 'Yes')/count(*)) * 100 as readmission_rate 
from hospital_data
where Outcome = 'Recovered'
group by Health_condition
order by readmission_rate;

# Readmission by age group
select
case
when Age < 18 then 'Child'
when Age between 18 and 40 then 'Young Adult'
when Age between 41 and 60 then 'Middle Aged'
else 'Senior'
end as age_group,
(sum(Readmission='Yes')/count(*))*100 AS readmission_rate
FROM hospital_data
group by age_group; 
# Focus on Young adult


# COSTS
select Procedures, avg(cost) as avg_cost, 
(sum(Readmission='Yes')/count(*))*100 AS readmission_rate from hospital_data
where Outcome != 'Recovered'
group by Procedures
order by avg_cost desc; 
# They need to work on Cardiac Catheterization

#Procedures with outcomes
select Procedures,sum(Outcome='Recovered') as total_recovered, 
avg(Outcome='Recovered') as avg_recovered from hospital_data
group by Procedures
order by total_recovered asc;



