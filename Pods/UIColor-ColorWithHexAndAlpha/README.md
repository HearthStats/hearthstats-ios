# UIColor+ColorWithHexAndAlpha

## Create UIColor Objects using Hex Values

### About
**UIColor+ColorWithHexAndAlpha** is a category on UIColor that enables you to use 3-character and 6-character hex color values to create UIColor objects.

###  Release Notes (v1.2.0):
- Added CocoaPods support

### Installation:

```
pod 'UIColor-ColorWithHexAndAlpha'
```
 
### Example:
<pre>

// Example with 6 Characters
UIColor *limeGreenColor = [UIColor colorWithHex:@"BFFF00" andAlpha:1.0f];

// Example with 3 Characters
UIColor *aquaBlueColor = [UIColor colorWithHex:@"0FF" andAlpha:1.0f];

</pre>

### Inspired by:
- [Tom Rybakiewicz's answer on StackOverflow](http://stackoverflow.com/a/8855057/814861)

### Created and maintained by:

Created by [Arthur Ariel Sabintsev](http://www.sabintsev.com)  

### License
The MIT License (MIT)
Copyright (c) 2013-2014 Arthur Ariel Sabintsev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
