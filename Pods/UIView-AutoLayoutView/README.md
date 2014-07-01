# UIView+AutoLayoutView

### About
A small Objective-C category on `UIView` that creates a UIView object that is ready to be used in programmatic AutoLayout. This class is useful for those of us who do a lot of our AutoLayout definitions outside of xibs and storyboards.

### Changelog (v1.0.0)
- Initial commit

### Installation Instructions
```
pod 'UIView-AutoLayoutView'
```

or simply drop **UIView+AutoLayoutView [.h|.m]** into your project, and reference `UIView+AutoLayoutView.h` in the classes that need access to the information it provides.

### The Interface

``` obj-c
@interface UIView (AutoLayoutView)

+ (instancetype)newAutoLayoutView;

@end
```

### The Implementation
``` obj-c
+ (instancetype)newAutoLayoutView
{
    UIView *view = [[self alloc] init];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return view;
}
```

### Created and Maintained by
[Arthur Ariel Sabintsev](http://www.sabintsev.com/) 
