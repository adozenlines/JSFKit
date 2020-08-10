# JSFKit

JSFKit- A swift JSON parser implementation for RSS data  

Example usage:
```
let reader = JSReader(url: URL(string: "https://www.jsonfeed.org/feed.json"))
reader.read { (jsfeed, error) in
    if let error = error {
        print("\(error.localizedDescription)")
    } else {
        guard let title = jsfeed?.title else { return }
        print("\(title)")
    }
}
```
