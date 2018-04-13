# Snap2me

[![Version](https://img.shields.io/cocoapods/v/Snap2me.svg?style=flat)](http://cocoapods.org/pods/Snap2me)
[![License](https://img.shields.io/cocoapods/l/Snap2me.svg?style=flat)](http://cocoapods.org/pods/Snap2me)
[![Platform](https://img.shields.io/cocoapods/p/Snap2me.svg?style=flat)](http://cocoapods.org/pods/Snap2me)


Snap2me helps you add the snap feature to your views. Your views need some guidance when users drag and drop things in it. Snap2me helps you implement these line guides into any view and its subviews are snapped once they are captured in a threshold.


## Example project

To run the example project, open up a terminal screen and copy paste the code below:
```ruby
pod try 'Snap2me'
```

### Storyboard support

Put two views in a view controller, then you can bind  `viewToSnapInStoryBoard` by dragging property, right in the Xcode.

![Storyboard](https://github.com/erkekin/Snap2me/blob/master/gifs/storyboard.gif?raw=true "Storyboard")

### Programmatic support

You can set snapping lines just like the following. 

```swift
draggingView.axisPercentages = [
    GuideLine.AxisPercentage(axis: .vertical, percentage: 0.5),
    GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.5),
    GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.1),
    GuideLine.AxisPercentage(axis: .vertical, percentage: 0.1),
    GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.9),
    GuideLine.AxisPercentage(axis: .vertical, percentage: 0.9)
]
```
![Programmatic](https://github.com/erkekin/Snap2me/blob/master/gifs/swift.gif?raw=true "Programmatic")

## Customization

```swift
draggableView.settings = GuideLine.Settings(
    lineColor: UIColor.red,
    lineWidth: 4,
    shadowColor: UIColor.brown,
    flushesInitially: true,
    threshold: 15
)
```

## Installation

Snap2me is available through [CocoaPods](http://cocoapods.org). To install it, add the following line to your `Podfile`:

```ruby
pod 'Snap2me'
```

## Features

- [x] Clean, easy to comprehend swift implementation, subclass the `Snap2meView` and enjoy dragging

- [x] Storyboard implementation

- [x] Programmatic implementation

- [x] Percent driven guide line distances

- [ ] Constant guide line distances

- [ ] Orientation handling

- [ ] Top, bottom, left, right snaps

- [ ] IBDesignables and IBInspectibles for `Snap2meView`

- [ ] Wider test coverage


## Tests

To run the tests simply select test target and select `Snap2me_Example` as the host application. This is caused by an issue between Cocoapods and modern Xcode versions.

## Author

erkekin, erkekin@gmail.com

## Contribution

IBDesignable and IBInspectible for guide lines,  constant line distance accompanying to percentage, top, bottom, left and right snaps, support for rotaion change are considered to be improved, please contribute!

## License

Snap2me is available under the MIT license. See the LICENSE file for more info.
