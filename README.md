# Mercadolivre
 
## Run Requirements 
 * IOS15.2
 * XCode Version 13.2.1
 

 ## OVERVIEW
  - Mercadolivre is a simple iOS App built using Clean Architecture and MVP.

## High Level Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces.
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB.
* **Presentation Layer (MVP)** = Presenters + Views.

## Data Flow
* 1. `View(UI)` calls method from `(Presenter)`.
* 2. `Presenter` executes Use Case.
* 3. `Use Case` combines data from User and Repositories.
* 4. Each Repository returns data from a Remote Data `(Network)`, Persistent DB Storage Source or In-memory Data (Remote or Cached).
* 5. Information flows back to the `View(UI)` where we display the list of items.

## Dependency Direction
* `Presentation Layer` `->` `Domain Layer` `<-` `Data Repositories Layer`
* `Presentation Layer (MVP)` = `Presenters` + `Views(UI)`
* `Domain Layer` = `Entities` + `Use Cases` + `Repositories Interfaces`
* `Data Repositories Layer` = `Repositories Implementations` + `API(Network)` + `Persistence DB`


##### Domain Layer
* It contains Entities, FetchProductsUseCase which fetches the products data.
* it contains Data Repositories Interfaces which are needed for Dependency Inversion.


##### Presentation Layer
* Containts the all the presenters and view controllers with data and business logic.

**`Presenter`** Contains the view controller business logic apstracted with provided presenter Protocol.
* `Note` UI cannot have access to business logic or application logic (Business Models and UseCases), only Presenters can do it. This is the separation of concerns. We cannot pass business models directly to the View (UI).

* Containts Flow `Router` for presentation logic.
* `Note` Flow Router for presentation logic, to reduce View Controllers’ size and responsibility.


##### Data Layer
* Contains `Repositories` Implementaion, It conforms to interfaces defined inside Domain Layer.
* `Note`  Data Layer conforms to interfaces defined inside Domain Layer in order to achieve (Dependency Inversion).

* Contains the `DTO` and mapping objects.
* `Note` Data Transfer Objects DTO is used as intermediate object for mapping from JSON response into Domain. Also for mapping data to the persistent storage.


##### Infrastructure Layer (Network)

* **`Service / Networking`** - contains the Router enum that is responsible for the apis structure.
* `Endpoint` - contains the BasAPI Genaric class which represents the genaric base api request.
* `Encoding` - contains the all the necessarily encoding methods for building the urls.
