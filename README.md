#  Last FM Project


For this project I used Alamofire for networking operations and SDWebImage for image handling.

The architecture is MVP and additionally I created a network layer which is wrapped on operations. The point of doing this, is to allow me to do things such as perform network operations in parrallel (request artists, tracks and albums at the same time) and not to write the same exact code every time I do a network request.

In general I believe the code is really clean and follows the following pattern:
View controller receives event -> View controller sends event to presenter -> Presenter handles event -> Presenter requests info from repository -> Repository fetches the data -> Presenter receives data -> Presenter informs the view controller it has the data.

This pattern allows decoupling, testing and most important of all, a clear code. I hope you enjoy reading (debuggin it) 🙂. 


