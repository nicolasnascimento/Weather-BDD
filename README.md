# Weather - BDD

An example iOS application written as an example of the proposed workflow

# Features

## Listing forecast of Cities
    AS                  A WORLD TRAVELLER
    I WANT TO BE ABLE   TO SEE CITIES AND THEIR FORECASTS
    SO THAT             I CAN KNOW THE FORECAST AROUND THE WORLD
    
### Scenario 1 - Loading forecast successfully for two cities 
    GIVEN   the target cities are San Francisco (SFO) and Porto Alegre (POA)
    AND     in SFO, it is 20º, "Sunny", with a min-max of 15º and 25º
    AND     in POA, it is 15º, "Cloudy", with a min-max of 10º and 20º
    AND     the App has started to load the forecast for the target cities
    WHEN    loading finishes successfully
    THEN    there should be two cities loaded, SFO and POA
    AND     the cities should be in alphabetic order
    AND     it should be 15º, "Cloudy", with a min-max of 10º and 20º
    AND     it should be 20º, "Sunny", with a min-max of 15º and 25º
    
### Scenario 2 - Failed to load weather

    GIVEN   the App is loading weather info for my prefered cities
    AND     I am in the HomeScreen
    AND     I am connected to the internet
    
    WHEN    The app finishes loading with an error
    
    THEN    the App should provide a error message to the user
    AND     I should be presented a Try again App
    
### Scenario 3 - Launching App
    GIVEN   the App is not open
    WHEN    I open the App
    THEN    I should be in the HomeScreen
    AND     the App should have started to load weather info for my prefered cities
