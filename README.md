CustomLoadingIndicator
======================

![Custom Loading Indicator](https://raw.github.com/MattMcEachern/CustomLoadingIndicator/master/CustomLoadingIndicator.gif)

# Installation

Add the file `CustomLoadingIndicator.swift` to your Xcode project.

# Usage

CustomLoadingIndicator size does not depend on the frame. To adjust its size, use the transform property.

## Initialization
``` swift
override func viewDidLoad() {
	let customLoadingIndicator = CustomLoadingIndicator()
	self.view.addSubview(customLoadingIndicator)
	customLoadingIndicator.center = self.view.center
}
```
## Toggling
``` swift
customLoadingIndicator.startAnimating()
customLoadingIndicator.stopAnimatiing()
```

## Checking State
``` swift
let isAnimating = customLoadingIndicator.isAnimating()
```

## Credits
- Animation is based on the beauiful gif, "orb spiral" by Dave Whyte. http://beesandbombs.tumblr.com/page/11



