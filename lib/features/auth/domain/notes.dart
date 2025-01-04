//~ This is Domain Layer
// - This layer contains all the business logic of the application.
// - This layer is independent of every other layer and less likely to change when other layers change.
// - This layer is a pure dart package and does not depend on any other package.
// - This layer contains all the usecases, entities, and repositories(interface).


//. Repositories
//- Repositories here are abstract classes that contain the method definition of the data operations related to the feature.
//- This class is implemented in the data layer using the data sources.
//- This class is used to perform data operations related to the feature.
//- Example: AuthRepository is used to perform data operations related to authentication like user sign up, user sign in, etc.

//. UseCase
//- UseCase is a class that contains a single method call .
//- This method is used to perform business logic using the repository  interface(reason: to make the usecase independent of the data layer if the implementation of the repository changes from network to database, the usecase will not be affected).
//- This method returns a Future of Either(Failure, SuccessType) from the fpdart package.
//- This method is called from the Presentation Layer(Widgets) to perform business logic.
// - Example: UserSignUp usecase is used to perform user sign up operation using the AuthRepository.

//. Entities
//- Entities  are classes that contain the structure of the data that is being used in the application. they are same as models but they are independent of the data layer.
//- Entities are used to pass data between different layers of the application.
//- Example: UserEntity is used to pass user data between the data layer and the domain layer (used in interface).



