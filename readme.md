
Gives us the euro rate based on the weeks average from [bitcoinaverage.com](https://bitcoinaverage.com)

Also grabs employee names, and number of days from a file, and gives you BTC amounts for each person.  

Room for improvement: Plenty

[see it live on heroku](https://blooming-lowlands-17270.herokuapp.com/)

payroll.yaml looks like this:
```yaml
day_rate: 200
people: 
  - name: alice
    days_per_week: 1
  - name: bob
    days_per_week: 2
  - name: carol
    days_per_week: 5
```

