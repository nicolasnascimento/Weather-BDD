#  Listing Weather of Cities

## Story
    AS A                User
    I WOULD LIKE TO     see a list of cities and their weather
    SO THAT             I can know the forecast around the world
    
    
### Scenario 1 - Launching App
    GIVEN   the App is not open
    WHEN    I open the App
    THEN    I should be in the HomeScreen
    AND     the App should have started to load weather info for my prefered cities


### Scenario 2 - Successfully loaded weather

    GIVEN   the App is loading weather info for my prefered cities
    AND     I am in the First Screen
    AND     I am is connected to the internet
    AND     My favorite cities are San Francisco, London, São Paulo and Porto Alegre
    AND     their temperature, and forecast are the following:
    | City           | Max T. | Min T. | Current T. | Current Forecast |
    |----------------|--------|--------|------------|------------------|
    | San Franscisco | 25     | 15     | 20         | Sunny            |
    | London         | 20     | 10     | 15         | Cloudy           |
    | São Paulo      | 23     | 18     | 20         | Rainy            |
    | Porto Alegre   | 30     | 20     | 28         | Sunny            |
    
    WHEN    The app finishes loading
    
    THEN    the App should display four cities
    AND     their temperature, and forecast should be the following
    | City           | Max T. | Min T. | Current T. | Current Forecast |
    |----------------|--------|--------|------------|------------------|
    | San Franscisco | 25     | 15     | 20         | Sunny            |
    | London         | 20     | 10     | 15         | Cloudy           |
    | São Paulo      | 23     | 18     | 20         | Rainy            |
    | Porto Alegre   | 30     | 20     | 28         | Sunny            |
    
### Scenario 3 - Failed to load weather

    GIVEN   the App is loading weather info for my prefered cities
    AND     I am in the HomeScreen
    AND     I am connected to the internet
    
    WHEN    The app finishes loading with an error
    
    THEN    the App should provide a error message to the user
    AND     I should be presented a Try again App
