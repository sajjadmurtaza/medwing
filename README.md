# Medwing
#### storing readings from IoT thermostats

Need to collect readings from IoT thermostats in each apartment so that we can adjust the temperature in all the apartments in real time.

### Key files

    
    app
    ├── controller
    │      ├── api                             
    │      │     └── v1                        
    │      │         ├── readings_controller  
    │      │         └── thermostats_controller
    │      │ 
    │      └── application_controller
    │
    ├── jobs
    │      └── reading_job
    │ 
    ├── models     
    │      ├── thermostat       
    │      └── reading
    │
    ├── spec
    │      ├── contriller 
    │      │     └── api               
    │      │          └── v1 
    │      │               ├── thermostats_controller                        
    │      │               └── readings_controller_spec
    │      │
    │      └── models
    │             ├── reading_spec
    │             └── thermostat_spec 
    └── 

**Setup**

* first clone the directory 
                      ```
                      git clone git@github.com:sajjadmurtaza/medwing.git'
                      ```
 *  ```cd medwing```
 *  ```bundle install ```
 *  ```rails s ```
 * In next tab of terminal: ```bundle exec sidekiq -q default```

### Workflow - How does it work?

The following diagram show the process/workflow to get thermostats stats.


    Postman/ Browser                            Server
 
    │      1. Get/stats with HouseholdToken          │
    │ http://localhost:3000/api/v1/thermostats/stats │
    ├───────────────────────────────────────────────>│     
    │                                                ├ 2. Calculate the average, minimum and maximum by 
    │                                                │    temperature, humidity and battery_charge 
    │                                                │   
    │                                                │ (If HouseholdToken wrong or invalid route then you will get error message)                    
    │    3. Return response to client                │               
    │<───────────────────────────────────────────────│
    
Input: 
```ruby
 URL: 
      http://localhost:3000/api/v1/thermostats/stats
 Header:
      HouseholdToken = di0o7o4py02wz3nsarzt
```
Output:
```ruby    
    {
        "data": [
            {
                "temperature_avg": 1.1000000000000003,
                "humidity_avg": 1.1000000000000003,
                "battery_charge_avg": 63.438095238095244
            },
            {
                "temperature_min": 1.1,
                "humidity_min": 1.1,
                "battery_charge_min": 1.1
            },
            {
                "temperature_max": 1.1,
                "humidity_max": 1.1,
                "battery_charge_max": 70
            }
        ]
    }
```

If you will enter wrong Token then you will get following error message
```ruby 
{
    "message": "Oops, No Thermostat found! Please double check that you entered correct HouseholdToken"
}
```

![alt text](https://raw.githubusercontent.com/sajjadmurtaza/medwing/master/public/1.png "api Screenshot")

***

The following diagram show the process/workflow to get reading.


    Postman/ Browser                            Server
 
    │      1. Get/readings with id & HouseholdToken     │
    │      http://localhost:3000/api/v1/readings/:id    │
    ├──────────────────────────────────────────────────>│     
    │                                                   ├ 2. get Thermostat and readings   
    │                                                   │ (If HouseholdToken wrong or invalid route then you will get error message)                    
    │    3. Return response to client                   │               
    │<──────────────────────────────────────────────────│
Input: 
```ruby
 URL: 
      http://localhost:3000/api/v1/readings/:id
 Header:
      HouseholdToken = di0o7o4py02wz3nsarzt
```
Output:
```ruby    
    {
        "data": {
            "thermostat": {
                "id": 1,
                "household_token": "di0o7o4py02wz3nsarzt",
                "location": "1341 Rolf Mills, West Georgiann, VT 70630-2162"
            },
            "reading": {
                "id": 11,
                "thermostat_id": 1,
                "number": 11,
                "temperature": 1.1,
                "humidity": 1.1,
                "battery_charge": 70
            }
        }
    }
```    
![alt text](https://raw.githubusercontent.com/sajjadmurtaza/medwing/master/public/2.png "api Screenshot")

***

The following diagram show the process/workflow to create reading.


    Postman/ Browser                            Server
 
    │      1. Post/readings with HouseholdToken     │
    │      http://localhost:3000/api/v1/readings    │
    ├──────────────────────────────────────────────>│     
    │                                               ├ 2. hit readings controller create method   
    │                                               │ call background job (high request) and start to creat reading                  
    │    3. Return response to client               │               
    │<──────────────────────────────────────────────│
    │                                               │ Client will get a response as he don't have to wait too much even reading in Que
    
Input: 
```ruby
 URL: 
      http://localhost:3000/api/v1/readings/
 Header:
      HouseholdToken = di0o7o4py02wz3nsarzt
```
Output:
```ruby    
    {
        "message": "Saving is reading for number: :id"
    }
```    
![alt text](https://raw.githubusercontent.com/sajjadmurtaza/medwing/master/public/3.png "api Screenshot")



### Specs

run ``` bundle exe rspec   ``` to run the tests
