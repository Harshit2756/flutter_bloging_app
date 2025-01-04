//~ This is Data Layer
// - This layer contains all the data sources (remote and local), repositories(implementation) and models.
// - This layer is dependent on the domain layer and the presentation layer.
// - This layer is responsible for handling all the data operations(like network calls, Reading and writing to the database).

//. DataSources
//- DataSources are classes that contain the implementation of the abstract class defined in the domain layer.
//- This class is responsible for handling all the network calls or database operations related to the feature.


//. Repositories
//- Repositories are classes that contain the implementation of the abstract class defined in the domain layer using the data sources.
//- This class is responsible for handling all the data operations related to authentication.


//. Models
//- Models are classes that contain the structure of the data that is being used in the application.
//- Models extends the entities defined in the domain layer and uses the super variables to pass data.
// - Example: User model extends UserEntity and uses the super variables to pass user data between the data layer and the domain layer (used in Implementation).