# RangeUISlider

[![Build Status](https://travis-ci.org/chicio/RangeUISlider.svg?branch=master)](https://travis-ci.org/chicio/RangeUISlider.svg?branch=master)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/chicio/RangeUISlider/master/LICENSE.md)
[![Supported platform](https://img.shields.io/badge/platforms-iOS-orange.svg)](https://img.shields.io/badge/platforms-iOS-orange.svg)

A highly customizable iOS range selection slider, developed using autolayout and completely customizable using IBDesignabled and IBInspectable.

***

### Installation

There are two ways to install RangeUISlider in your project: manual installation of as a framework.

**Manual installation**

To manually install RangeUISlider simply drag and drop the <a href="https://github.com/chicio/RangeUISlider/blob/master/RangeUISlider/RangeUISlider.swift">RangeUISlider.swift</a> file inside your project.

**Framework**

RangeUISlider is available also as a CocoaTouchFramework. To install follow the standard procedure used to install a custom cocoa touch framework 
(simply drag the RangeUISlider.xcodeproj inside you project and add it to the Embedded Binaries/Linked Frameworks and Libraries section of your 
project. See the demo project for a complete example of the setup of the framework.

### Usage

The step needed to use RangeUISlider are:

 - drag a UIView into you storyboard
 - set RangeUISlider as custom class of that view
 - start editing using interface builder
	
<p align="center">
<img src="https://raw.githubusercontent.com/chicio/RangeUISlider/master/Screenshots/tutorial.gif">
</p>


To get the current values from the slider, set its delegate property.
The delegate of the RangeUISLider must implement the ```swift RangeUISliderDelegate``` protocol, that has two methods:

```swift

/**
 Calls the delegate when the user is changing the range by moving the knobs.
     
 - parameter minValueSelected: the minimum value selected.
 - parameter maxValueSelected: the maximum value selected.
 - parameter slider: the slider on which the range has been modified.
 */
 @objc optional func rangeIsChanging(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider)
    
/**
 Calls the delegate when the user has finished the change of the range.
    
 - parameter minValueSelected: the minimum value selected.
 - parameter maxValueSelected: the maximum value selected.
 - parameter slider: the slider on which the range has been modified.
 */
 @objc func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider)

```

### Customizable property

This is the list of the current customizable property of the RangeUISlider directly from Interface Builder using IBDesignable/IBInspectable:

 - range selected color
 - range selected image (override range selected color property)
 - range selected edge inset top, left, bottom, right (used only if range selected image has been setted)
 - range selected gradient color 1 (override range selected color and image)
 - range selected gradient color 1 (override range selected color and image)
 - range selected gradient start point (used only if range selected gradients color has been choosed)
 - range selected gradient end point (used only if range selected gradients color has been choosed)
 - range not selected color
 - range not selected image (override range not selected color property)
 - range not selected edge inset top, left, bottom, right (used only if range not selected image has been setted)
 - range not selected gradient color 1 (override range not selected color and image)
 - range not selected gradient color 1 (override range not selected color and image)
 - range not selected gradient start point (used only if range not selected gradients color has been choosed)
 - range not selected gradient end point (used only if range not selected gradients color has been choosed)
 - left knob width
 - left knob height
 - left knob corners radius 
 - left knob color
 - left knob image (override color) 
 - left knob shadow opacity
 - left knob shadow color
 - left knob shadow offset
 - left knob shadow radius
 - left knob gradient color 1 (override left knob color and image)
 - left knob gradient color 2 (override left knob color and image)
 - left knob gradient start point (used only if left knob gradients color has been choosed)
 - left knob gradient end point (used only if left knob gradients color has been choosed)
 - right knob width
 - right knob height
 - right knob corners radius 
 - right knob color
 - right knob image (override color) 
 - right knob shadow opacity
 - right knob shadow color
 - right knob shadow offset
 - right knob shadow radius
 - right knob gradient color 1 (override right knob color and image)
 - right knob gradient color 2 (override right knob color and image)
 - right knob gradient start point (used only if right knob gradients color has been choosed)
 - right knob gradient end point (used only if right knob gradients color has been choosed) 
 - bar height 
 - bar leading distance from container view
 - bar trailing distance from container view
 - bar cornes
 - bar shadow opacity
 - bar shadow color
 - bar shadow offset
 - bar shadow radius
 - container corners

### Examples

In the following screenshot you can find some examples of the level of customization that it is possible to reach. You can find this example in the demo project.

**Mixed examples**

Various range slider examples created using simple UIColors, images, gradients using CALayers, shadows.

<p align="center">
<img src="https://raw.githubusercontent.com/chicio/RangeUISlider/master/Screenshots/01-mixed.png">
</p>

**Only colors**

A range slider example created using only UIColors.

<p align="center">
<img src="https://raw.githubusercontent.com/chicio/RangeUISlider/master/Screenshots/02-only-colors.png">
</p>

**Only images**

A range slider example created using only images.

<p align="center">
<img src="https://raw.githubusercontent.com/chicio/RangeUISlider/master/Screenshots/03-only-images.png">
</p>

**Only gradients**

<p align="center">
<img src="https://raw.githubusercontent.com/chicio/RangeUISlider/master/Screenshots/04-only-gradients.png">
</p>
