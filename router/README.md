## Swift Router

Example: 

```swift
import Alamofire

Alamofire.request(Router.fetchFeed).responseJSON { (response: Response<AnyObject, NSError>) in

  // do something

}
```

Example using `JSON` and `ResultType`: 

```swift 

func fetchFeed(completion: (ResultType<[Post]>) -> Void) {

	Alamofire.request(Router.fetchFeed).responseJSON { (response: Response<AnyObject, NSError>) in
	
		guard let json = response.result as? JSON else {
			completion(.Error("Invalid response: Expected JSON")
			return 
		}
	
		if response.result.isSuccess {
			let posts = json.map { Post($0) }
			completion(.Success(posts))
		} else {
			completion(.Error(json["error_message"]))
		}
	
	}
	
)
```

Handling the response

```swift
fetchFeed { (response: ResultType<[Post]>) in
	switch response {
		case .Success(let posts):
			self.posts = posts
			self.tableView.reloadData()
		case .Error(let message):
			print("Error: \(message)")
	}
}

```