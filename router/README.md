## Swift Router

Example: 

```swift
Alamofire.request(Router.GetAccessToken(email, password)).validate().responseJSON { (response: Response<AnyObject, NSError>) in

  // do something

})
```