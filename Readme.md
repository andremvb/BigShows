# Big Shows

App that uses [TVMaze](http://www.tvmaze.com/api) to search throw shows, and it's respective episodes.

## External Frameworks

This project only uses one external dependency:

### [LBTATools](https://github.com/bhlvoong/LBTATools)

This dependency is used to build the UI programmaticaly faster. It provides anchor helpers, and easy initializers for common UIKit components.

------

For example, to fill a label in the view.
```swift
let label = UILabel()
view.addSubview(label)
label.translatesAutoresizingMaskIntoConstraints = false
label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
```

We set the constraints like this:
```swift
let label = UILabel()
view.addSubview(label)
label.fillSuperview()
```

-----

Other powerful example. Instead of set a UIStackView, and add it filled to the view.
```swift
let view = UIView()
let myStack = UIStackView(arrangedSubviews: [view1, view2])
myStack.axis = .vertical
myStack.alignment = .center
myStack.distribution = .fillProportionally

view.addSubview(myStack)
myStack.translatesAutoresizingMaskIntoConstraints = false
myStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
myStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
myStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
myStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

```
We create the stack in one line:
```swift
let view = UIView()
let myStack = view.stack(view1, view2, alignment: .center), distribution: .fillProportionally)
```
