//
//  RangeUISlider.swift
//
//  Created by Fabrizio Duroni on 25/03/2017.
//  2017 Fabrizio Duroni.
//

import Foundation
import UIKit

/**
 Protocol used delegate the read of the RangeUISlider data. Multiple RangeUISlider instance could use the same delegate.
 The current slider (on which the user is tapping) is returned in all the methods (so that could be identified on the
 delegate class).
 */
@objc public protocol RangeUISliderDelegate {
    
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
}

/**
 A custom slider with double knob that allow the user to select a range.
 Created using autolayout and IBDesignabled/IBInspectable.
 */
@IBDesignable
@objc public class RangeUISlider: UIView {
    
    // MARK: Inspectable property
    
    /// Slider identifier.
    @IBInspectable public var identifier: Int = 0
    /// Scale minimum value.
    @IBInspectable var scaleMinValue: CGFloat = 0.0
    /// Scale maximum value.
    @IBInspectable var scaleMaxValue: CGFloat = 1.0
    /// Selected range color.
    @IBInspectable var rangeSelectedColor: UIColor = UIColor.blue {
        
        didSet {
            
            self.selectedProgressView.backgroundColor = self.rangeSelectedColor
        }
    }
    /// Background range selected strechable image.
    @IBInspectable var rangeSelectedBackgroundImage: UIImage? {
        
        didSet {
            
            self.addBackgroundToRangeSelected()
        }
    }
    /// Background range selected top edge insect for background image.
    @IBInspectable var rangeSelectedBackgroundEdgeInsetTop: CGFloat = 0.0 {
        
        didSet {
            
            self.addBackgroundToRangeSelected()
        }
    }
    /// Background range selected left edge insect for background image.
    @IBInspectable var rangeSelectedBackgroundEdgeInsetLeft: CGFloat = 5.0 {
        
        didSet {
            
            self.addBackgroundToRangeSelected()
        }
    }
    /// Background range selected bottom edge insect for background image.
    @IBInspectable var rangeSelectedBackgroundEdgeInsetBottom: CGFloat = 0.0 {
        
        didSet {
            
            self.addBackgroundToRangeSelected()
        }
    }
    /// Background range selected right edge insect for background image.
    @IBInspectable var rangeSelectedBackgroundEdgeInsetRight: CGFloat = 5.0 {
        
        didSet {
            
            self.addBackgroundToRangeSelected()
        }
    }
    /// Gradient color 1 for range not selected.
    @IBInspectable var rangeSelectedGradientColor1: UIColor? {
        
        didSet {
            
            self.selectedProgressView.addGradient(firstColor: self.rangeSelectedGradientColor1,
                                                  secondColor: self.rangeSelectedGradientColor2,
                                                  startPoint: self.rangeSelectedGradientStartPoint,
                                                  endPoint: self.rangeSelectedGradientEndPoint)
        }
    }
    /// Gradient color 2 for range not selected.
    @IBInspectable var rangeSelectedGradientColor2: UIColor? {
        
        didSet {
            
            self.selectedProgressView.addGradient(firstColor: self.rangeSelectedGradientColor1,
                                                  secondColor: self.rangeSelectedGradientColor2,
                                                  startPoint: self.rangeSelectedGradientStartPoint,
                                                  endPoint: self.rangeSelectedGradientEndPoint)
        }
    }
    /// Gradient start point for not selected range.
    @IBInspectable var rangeSelectedGradientStartPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.selectedProgressView.addGradient(firstColor: self.rangeSelectedGradientColor1,
                                                  secondColor: self.rangeSelectedGradientColor2,
                                                  startPoint: self.rangeSelectedGradientStartPoint,
                                                  endPoint: self.rangeSelectedGradientEndPoint)
        }
    }
    /// Gradient end point for not selected range.
    @IBInspectable var rangeSelectedGradientEndPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.selectedProgressView.addGradient(firstColor: self.rangeSelectedGradientColor1,
                                                  secondColor: self.rangeSelectedGradientColor2,
                                                  startPoint: self.rangeSelectedGradientStartPoint,
                                                  endPoint: self.rangeSelectedGradientEndPoint)
        }
    }
    /// Not selected range color.
    @IBInspectable var rangeNotSelectedColor: UIColor = UIColor.lightGray {
        
        didSet {
            
            self.leftProgressView.backgroundColor = self.rangeNotSelectedColor
            self.rightProgressView.backgroundColor = self.rangeNotSelectedColor
        }
    }
    /// Background range selected strechable image.
    @IBInspectable var rangeNotSelectedBackgroundImage: UIImage? {
        
        didSet {
            
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Background range selected top edge insect for background image.
    @IBInspectable var rangeNotSelectedBackgroundEdgeInsetTop: CGFloat = 0.0 {
        
        didSet {
            
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Background range selected left edge insect for background image.
    @IBInspectable var rangeNotSelectedBackgroundEdgeInsetLeft: CGFloat = 5.0 {
        
        didSet {
            
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Background range selected bottom edge insect for background image.
    @IBInspectable var rangeNotSelectedBackgroundEdgeInsetBottom: CGFloat = 0.0 {
        
        didSet {
            
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Background range selected right edge insect for background image.
    @IBInspectable var rangeNotSelectedBackgroundEdgeInsetRight: CGFloat = 5.0 {
        
        didSet {
            
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Gradient color 1 for range not selected.
    @IBInspectable var rangeNotSelectedGradientColor1: UIColor? {
        
        didSet {
            
            self.addGradientToNotSelectedRangeIfNeeded()
        }
    }
    /// Gradient color 2 for range not selected.
    @IBInspectable var rangeNotSelectedGradientColor2: UIColor? {
        
        didSet {
            
            self.addGradientToNotSelectedRangeIfNeeded()
        }
    }
    /// Gradient start point for not selected range.
    @IBInspectable var rangeNotSelectedGradientStartPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.addGradientToNotSelectedRangeIfNeeded()
        }
    }
    /// Gradient end point for not selected range.
    @IBInspectable var rangeNotSelectedGradientEndPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.addGradientToNotSelectedRangeIfNeeded()
        }
    }
    /// Left knob width.
    @IBInspectable var leftKnobWidth: CGFloat = 30.0 {
        
        didSet {
            
            self.leftKnob.widthConstraint.constant = self.leftKnobWidth
        }
    }
    /// Left knob height.
    @IBInspectable var leftKnobHeight: CGFloat = 30.0 {
        
        didSet {
            
            self.leftKnob.heightConstraint.constant = self.leftKnobHeight
        }
    }
    /// Left knob corners.
    @IBInspectable var leftKnobCornes: CGFloat = 15.0 {
        
        didSet {
            
            self.leftKnob.backgroundView.layer.cornerRadius = self.leftKnobCornes
            self.leftKnob.backgroundView.layer.masksToBounds = self.leftKnobCornes > 0.0
        }
    }
    /// Left knob image.
    @IBInspectable var leftKnobImage: UIImage? {
        
        didSet {
            
            self.leftKnob.add(image: self.leftKnobImage)
        }
    }
    /// Left knob color.
    @IBInspectable var leftKnobColor: UIColor = UIColor.gray {
        
        didSet {
            
            self.leftKnob.backgroundView.backgroundColor = self.leftKnobColor
        }
    }
    /// Left knob shadow opacity.
    @IBInspectable var leftShadowOpacity: Float = 0.0 {
        
        didSet {
            
            self.leftKnob.layer.shadowOpacity = self.leftShadowOpacity
        }
    }
    /// Left knob shadow color.
    @IBInspectable var leftShadowColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.leftKnob.layer.shadowColor = self.leftShadowColor.cgColor
        }
    }
    /// Left knob shadow offset.
    @IBInspectable var leftShadowOffset: CGSize = CGSize() {
        
        didSet {
            
            
            self.leftKnob.layer.shadowOffset = self.leftShadowOffset
        }
    }
    /// Left knob shadow radius.
    @IBInspectable var leftShadowRadius: CGFloat = 0 {
        
        didSet {
            
            self.leftKnob.layer.shadowRadius = self.leftShadowRadius
        }
    }
    /// Gradient color 1 for range not selected.
    @IBInspectable var leftKnobGradientColor1: UIColor? {
        
        didSet {
            
            self.leftKnob.addGradient(firstColor: self.leftKnobGradientColor1,
                                      secondColor: self.leftKnobGradientColor2,
                                      startPoint: self.leftKnobGradientStartPoint,
                                      endPoint: self.leftKnobGradientEndPoint,
                                      cornerRadius: self.leftKnobCornes)
        }
    }
    /// Gradient color 2 for range not selected.
    @IBInspectable var leftKnobGradientColor2: UIColor? {
        
        didSet {
            
            self.leftKnob.addGradient(firstColor: self.leftKnobGradientColor1,
                                      secondColor: self.leftKnobGradientColor2,
                                      startPoint: self.leftKnobGradientStartPoint,
                                      endPoint: self.leftKnobGradientEndPoint,
                                      cornerRadius: self.leftKnobCornes)
        }
    }
    /// Gradient start point for not selected range.
    @IBInspectable var leftKnobGradientStartPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.leftKnob.addGradient(firstColor: self.leftKnobGradientColor1,
                                      secondColor: self.leftKnobGradientColor2,
                                      startPoint: self.leftKnobGradientStartPoint,
                                      endPoint: self.leftKnobGradientEndPoint,
                                      cornerRadius: self.leftKnobCornes)
        }
    }
    /// Gradient end point for not selected range.
    @IBInspectable var leftKnobGradientEndPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.leftKnob.addGradient(firstColor: self.leftKnobGradientColor1,
                                      secondColor: self.leftKnobGradientColor2,
                                      startPoint: self.leftKnobGradientStartPoint,
                                      endPoint: self.leftKnobGradientEndPoint,
                                      cornerRadius: self.leftKnobCornes)
        }
    }
    /// Left knob border width.
    @IBInspectable var leftKnobBorderWidth: CGFloat = 0.0 {
        
        didSet {
            
            self.leftKnob.addBorders(usingColor: self.leftKnobBorderColor,
                                     andWidth: self.leftKnobBorderWidth,
                                     andCorners: self.leftKnobCornes)
        }
    }
    /// Left knob border color.
    @IBInspectable var leftKnobBorderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.leftKnob.addBorders(usingColor: self.leftKnobBorderColor,
                                     andWidth: self.leftKnobBorderWidth,
                                     andCorners: self.leftKnobCornes)
        }
    }
    /// Right knob width.
    @IBInspectable var rightKnobWidth: CGFloat = 30.0 {
        
        didSet {
            
            self.rightKnob.widthConstraint.constant = self.rightKnobWidth
        }
    }
    /// Right knob height.
    @IBInspectable var rightKnobHeight: CGFloat = 30.0 {
        
        didSet {
            
            self.rightKnob.heightConstraint.constant = self.rightKnobHeight
        }
    }
    /// Right knob corners.
    @IBInspectable var rightKnobCornes: CGFloat = 15.0 {
        
        didSet {
            
            self.rightKnob.backgroundView.layer.cornerRadius = self.rightKnobCornes
            self.rightKnob.backgroundView.layer.masksToBounds = self.rightKnobCornes > 0.0
        }
    }
    /// Right knob image.
    @IBInspectable var rightKnobImage: UIImage? {
        
        didSet {
            
            self.rightKnob.add(image: self.rightKnobImage)
        }
    }
    /// Right knob color.
    @IBInspectable var rightKnobColor: UIColor = UIColor.gray {
        
        didSet {
            
            self.rightKnob.backgroundView.backgroundColor = self.rightKnobColor
        }
    }
    /// Right knob shadow opacity.
    @IBInspectable var rightShadowOpacity: Float = 0.0 {
        
        didSet {
            
            self.rightKnob.layer.shadowOpacity = self.rightShadowOpacity
        }
    }
    /// Right knob shadow color.
    @IBInspectable var rightShadowColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.rightKnob.layer.shadowColor = self.rightShadowColor.cgColor
        }
    }
    /// Right knob shadow offset.
    @IBInspectable var rightShadowOffset: CGSize = CGSize() {
        
        didSet {
            
            self.rightKnob.layer.shadowOffset = self.rightShadowOffset
        }
    }
    /// Right knob shadow radius.
    @IBInspectable var rightShadowRadius: CGFloat = 0 {
        
        didSet {
            
            self.rightKnob.layer.shadowRadius = self.rightShadowRadius
        }
    }
    /// Gradient color 1 for range not selected.
    @IBInspectable var rightKnobGradientColor1: UIColor? {
        
        didSet {
            
            self.rightKnob.addGradient(firstColor: self.rightKnobGradientColor1,
                                       secondColor: self.rightKnobGradientColor2,
                                       startPoint: self.rightKnobGradientStartPoint,
                                       endPoint: self.rightKnobGradientEndPoint,
                                       cornerRadius: self.rightKnobCornes)
        }
    }
    /// Gradient color 2 for range not selected.
    @IBInspectable var rightKnobGradientColor2: UIColor? {
        
        didSet {
            
            self.rightKnob.addGradient(firstColor: self.rightKnobGradientColor1,
                                       secondColor: self.rightKnobGradientColor2,
                                       startPoint: self.rightKnobGradientStartPoint,
                                       endPoint: self.rightKnobGradientEndPoint,
                                       cornerRadius: self.rightKnobCornes)
        }
    }
    /// Gradient start point for not selected range.
    @IBInspectable var rightKnobGradientStartPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.rightKnob.addGradient(firstColor: self.rightKnobGradientColor1,
                                       secondColor: self.rightKnobGradientColor2,
                                       startPoint: self.rightKnobGradientStartPoint,
                                       endPoint: self.rightKnobGradientEndPoint,
                                       cornerRadius: self.rightKnobCornes)
        }
    }
    /// Gradient end point for not selected range.
    @IBInspectable var rightKnobGradientEndPoint: CGPoint = CGPoint() {
        
        didSet {
            
            self.rightKnob.addGradient(firstColor: self.rightKnobGradientColor1,
                                       secondColor: self.rightKnobGradientColor2,
                                       startPoint: self.rightKnobGradientStartPoint,
                                       endPoint: self.rightKnobGradientEndPoint,
                                       cornerRadius: self.rightKnobCornes)
        }
    }
    /// Right knob border width.
    @IBInspectable var rightKnobBorderWidth: CGFloat = 0.0 {
        
        didSet {
            
            self.rightKnob.addBorders(usingColor: self.rightKnobBorderColor,
                                      andWidth: self.rightKnobBorderWidth,
                                      andCorners: self.rightKnobCornes)
        }
    }
    /// Right knob border color.
    @IBInspectable var rightKnobBorderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.rightKnob.addBorders(usingColor: self.rightKnobBorderColor,
                                      andWidth: self.rightKnobBorderWidth,
                                      andCorners: self.rightKnobCornes)
        }
    }
    /// Bar height.
    @IBInspectable var barHeight: CGFloat = 15.0 {
        
        didSet {
            
            self.bar.heightConstraint.constant = self.barHeight
        }
    }
    /// Bar leading offset.
    @IBInspectable var barLeading: CGFloat = 20.0 {
        
        didSet {
            
            self.bar.leadingConstraint.constant = self.barLeading
        }
    }
    /// Bar trailing offset.
    @IBInspectable var barTrailing: CGFloat = 20.0 {
        
        didSet {
            
            self.bar.trailingConstraint.constant = -self.barTrailing
        }
    }
    /// Bar corners.
    @IBInspectable var barCornes: CGFloat = 0.0 {
        
        didSet {
            
            self.leftProgressView.layer.cornerRadius = barCornes
            self.rightProgressView.layer.cornerRadius = barCornes
            self.addGradientToNotSelectedRangeIfNeeded()
            self.addBackgroundToRangeNotSelectedIfNeeded()
        }
    }
    /// Bar shadow opacity.
    @IBInspectable var barShadowOpacity: Float = 0.0 {
        
        didSet {
            
            self.bar.layer.shadowOpacity = self.barShadowOpacity
        }
    }
    /// Bar shadow color.
    @IBInspectable var barShadowColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.bar.layer.shadowColor = self.barShadowColor.cgColor
        }
    }
    /// Bar shadow offset.
    @IBInspectable var barShadowOffset: CGSize = CGSize() {
        
        didSet {
            
            self.bar.layer.shadowOffset = self.barShadowOffset
        }
    }
    /// Bar shadow radius.
    @IBInspectable var barShadowRadius: CGFloat = 0.0 {
        
        didSet {
            
            self.bar.layer.shadowRadius = self.barShadowRadius
        }
    }
    /// Bar border color.
    @IBInspectable var barBorderWidth: CGFloat = 0.0 {
        
        didSet {
            
            self.leftProgressView.layer.borderWidth = self.barBorderWidth
            self.rightProgressView.layer.borderWidth = self.barBorderWidth
            self.selectedProgressView.layer.borderWidth = self.barBorderWidth
        }
    }
    /// Bar border color.
    @IBInspectable var barBorderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.leftProgressView.layer.borderColor = self.barBorderColor.cgColor
            self.rightProgressView.layer.borderColor = self.barBorderColor.cgColor
            self.selectedProgressView.layer.borderColor = self.barBorderColor.cgColor
        }
    }
    /// Container corners.
    @IBInspectable var containerCorners: CGFloat = 0.0 {
        
        didSet {
            
            self.layer.cornerRadius = self.containerCorners
            self.layer.masksToBounds = self.containerCorners > 0.0
        }
    }
    
    // MARK: Instance property
    
    /// SliderBar component.
    private let bar: Bar = Bar()
    /// Left knob.
    private let leftKnob: Knob = Knob()
    /// Right knob.
    private let rightKnob: Knob = Knob()
    /// UIView used as marker for selected range progress.
    private let selectedProgressView: ProgressView = ProgressView()
    /// UIVIew used as progress bar for left knob.
    private let leftProgressView: ProgressView = ProgressView()
    /// UIVIew used as progress bar for right knob.
    private let rightProgressView: ProgressView = ProgressView()
    /// Slider delegate.
    public weak var delegate: RangeUISliderDelegate?
    
    /**
     Standard init using coder.
     
     - parameter aDecoder: the decoder used to init the sliders.
     */
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setup()
    }
    
    /**
     Standard init using a CGRect.
     
     - parameter frame: the frame used to init the slider.
     */
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    
    /**
     Method used to prepare fake values for interface builder preview.
     */
    public override func prepareForInterfaceBuilder() {
        
        //Fake values for interface builder.
        //Used to make visible the progress views.
        self.leftKnob.xPositionConstraint.constant = 40
        self.rightKnob.xPositionConstraint.constant = -40
    }
    
    /**
     Method used to setup all the range slider components. All its subviews and the related constraints are added in
     this method. All the compoents returns arrays of constrains that are activated in a single call to
     NSLayoutConstraint.activate(constraints) (to improve preformance).
     */
    private func setup() {
        
        self.addSubview(self.bar)
        self.bar.addSubview(self.selectedProgressView)
        self.bar.addSubview(self.leftProgressView)
        self.bar.addSubview(self.rightProgressView)
        self.bar.addSubview(self.leftKnob)
        self.bar.addSubview(self.rightKnob)
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(contentsOf: self.bar.setup(leftKnob: self.leftKnob,
                                                      rightKnob: self.rightKnob,
                                                      leading: self.barLeading,
                                                      trailing: self.barTrailing,
                                                      height: self.barHeight))
        
        constraints.append(contentsOf: self.leftKnob.setup(position: .left,
                                                           width: self.leftKnobWidth,
                                                           height: self.leftKnobHeight,
                                                           target: self,
                                                           selector: #selector(moveLeftKnob)))
        
        constraints.append(contentsOf: self.rightKnob.setup(position: .right,
                                                            width: self.rightKnobWidth,
                                                            height: self.rightKnobHeight,
                                                            target: self,
                                                            selector: #selector(moveRightKnob)))
        
        constraints.append(contentsOf: self.selectedProgressView.setup(leftAnchorView: self.leftKnob,
                                                                       leftAnchorConstraintAttribute: .centerX,
                                                                       rightAnchorView: self.rightKnob,
                                                                       rightAnchorConstraintAttribute:  .centerX,
                                                                       color: self.rangeSelectedColor))
        
        constraints.append(contentsOf: self.leftProgressView.setup(leftAnchorView: self.bar,
                                                                   leftAnchorConstraintAttribute: .leading,
                                                                   rightAnchorView: self.leftKnob,
                                                                   rightAnchorConstraintAttribute: .centerX,
                                                                   color: self.rangeNotSelectedColor))
        
        constraints.append(contentsOf: self.rightProgressView.setup(leftAnchorView: self.rightKnob,
                                                                    leftAnchorConstraintAttribute: .centerX,
                                                                    rightAnchorView: self.bar,
                                                                    rightAnchorConstraintAttribute: .trailing,
                                                                    color: self.rangeNotSelectedColor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /**
     Add a gradient layer to the not selected range views.
     */
    private func addGradientToNotSelectedRangeIfNeeded() {
        
        self.leftProgressView.addGradient(firstColor: self.rangeNotSelectedGradientColor1,
                                          secondColor: self.rangeNotSelectedGradientColor2,
                                          startPoint: self.rangeNotSelectedGradientStartPoint,
                                          endPoint: self.rangeNotSelectedGradientEndPoint,
                                          cornerRadius: self.barCornes)
        
        self.rightProgressView.addGradient(firstColor: self.rangeNotSelectedGradientColor1,
                                           secondColor: self.rangeNotSelectedGradientColor2,
                                           startPoint: self.rangeNotSelectedGradientStartPoint,
                                           endPoint: self.rangeNotSelectedGradientEndPoint,
                                           cornerRadius: self.barCornes)
    }
    
    /**
     Add a background image to the range not selected views.
     */
    func addBackgroundToRangeNotSelectedIfNeeded() {
        
        if let backgroundImage = self.rangeNotSelectedBackgroundImage {
            
            let edgeInset = UIEdgeInsets(top: self.rangeNotSelectedBackgroundEdgeInsetTop,
                                         left: self.rangeNotSelectedBackgroundEdgeInsetLeft,
                                         bottom: self.rangeNotSelectedBackgroundEdgeInsetBottom,
                                         right: self.rangeNotSelectedBackgroundEdgeInsetRight)
            
            self.leftProgressView.addBackground(usingImage: backgroundImage,
                                                andEdgeInset: edgeInset,
                                                andCorners: self.barCornes)
            
            self.rightProgressView.addBackground(usingImage: backgroundImage,
                                                 andEdgeInset: edgeInset,
                                                 andCorners: self.barCornes)
        }
    }
    
    /**
     Add a background image to the range selected views.
     */
    private func addBackgroundToRangeSelected() {
        
        if let backgroundImage = self.rangeSelectedBackgroundImage {
            
            let edgeInset = UIEdgeInsets(top: self.rangeSelectedBackgroundEdgeInsetTop,
                                         left: self.rangeSelectedBackgroundEdgeInsetLeft,
                                         bottom: self.rangeSelectedBackgroundEdgeInsetBottom,
                                         right: self.rangeSelectedBackgroundEdgeInsetRight)
            
            self.selectedProgressView.addBackground(usingImage: backgroundImage,
                                                    andEdgeInset: edgeInset,
                                                    andCorners: self.barCornes)
        }
    }
    
    
    // MARK: Gesture recognizer methods (knobs movements)
    
    /**
     Method used to respond to the gesture recognizer attached on the left knob.
     
     - parameter gestureRecognizer: the gesture recognizer that uses this method as selector.
     */
    public final func moveLeftKnob(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let positionForKnob = gestureRecognizer.location(in: self.bar).x
            let positionRightKnob = self.bar.frame.width + self.rightKnob.xPositionConstraint.constant
            
            if positionForKnob >= 0 && positionForKnob <= positionRightKnob {
                
                self.leftKnob.xPositionConstraint.constant = positionForKnob
            }
            
            self.rangeUpdate()
        }
        
        if gestureRecognizer.state == .ended {
            
            self.rangeSelected()
        }
    }
    
    /**
     Method used to respond to the gesture recognizer attached on the right knob.
     
     - parameter gestureRecognizer: the gesture recognizer that uses this method as selector.
     */
    public final func moveRightKnob(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let xLocationInBar = gestureRecognizer.location(in: self.bar).x
            let positionForKnob = xLocationInBar - self.bar.frame.width
            
            if positionForKnob <= 0 && xLocationInBar >= self.leftKnob.xPositionConstraint.constant {
                
                self.rightKnob.xPositionConstraint.constant = positionForKnob
            }
            
            self.rangeUpdate()
        }
        
        if gestureRecognizer.state == .ended {
            
            self.rangeSelected()
        }
    }
    
    // MARK: Range selected calculation.
    
    /**
     Method used to calculate the range selected during updates (moving knobs).
     The selection is adapted to the custom scale eventually setted.
     */
    private func rangeUpdate() {
        
        let rangeValues = self.calculateRangeSelected()
        
        self.delegate?.rangeIsChanging?(minValueSelected: rangeValues.minValue,
                                        maxValueSelected: rangeValues.maxValue,
                                        slider: self)
    }
    
    /**
     Method used to calculate the range selected after updates (moving knobs).
     The selection is adapted to the custom scale eventually setted.
     */
    func rangeSelected() {
        
        let rangeValues = self.calculateRangeSelected()
        
        self.delegate?.rangeChangeFinished(minValueSelected: rangeValues.minValue,
                                           maxValueSelected: rangeValues.maxValue,
                                           slider: self)
    }
    
    /**
     Calculate range selected based on knob position and scale.
     
     - returns: min and max values selected.
     */
    private func calculateRangeSelected() -> (minValue: CGFloat, maxValue: CGFloat) {
        
        let minValue = self.leftKnob.xPositionConstraint.constant / self.bar.frame.width
        let maxValue = 1.0  + self.rightKnob.xPositionConstraint.constant / self.bar.frame.width
        let scaledMinValue = self.linearMapping(value: minValue)
        let scaledMaxValue = self.linearMapping(value: maxValue)
        
        return (minValue: scaledMinValue, maxValue: scaledMaxValue)
    }
    
    /**
     Linear mapping of a values. A simple equation of a straight line. "Nothing to see", no need for more complex
     interpolation here (good old times, when I was studying interpolation in Perlin noise..I miss you... :D).
     
     - parameter value: value to be mapped.
     
     - returns: the mapped value.
     */
    private func linearMapping(value: CGFloat) -> CGFloat {
        
        return value * (self.scaleMaxValue - self.scaleMinValue) + self.scaleMinValue
    }
}

// MARK: Bar

/// Class used to describe the bar of the slider.
class Bar: UIView {
    
    /// Bar leading offset constraint.
    private(set) var leadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// Bar trailing offset constraint.
    private(set) var trailingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// Bar height constraint.
    private(set) var heightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// Left knob reference. Unforce wrapped because it surely exist from in range slider (refernce in main view).
    private weak var leftKnob: Knob!
    /// Right knob reference. Unforce wrapped because it surely exist from in range slider (refernce in main view).
    private weak var rightKnob: Knob!
    
    /**
     Method used to setup a bar. This methods returns all the constraints to be activated.
     
     - parameter leftKnob: the left knob of the bar.
     - parameter rightKnob: the right knob of the bar.
     - parameter leading: the leading constant value to be used when creating the leading constraint.
     - parameter trailing: the trailing constant value to be used when creating the trailing constraint.
     - parameter height: the height constant vallue to be used when creating the height constraint.
     
     - returns: an arrays of constraints to be activated.
     */
    fileprivate func setup(leftKnob: Knob,
                           rightKnob: Knob,
                           leading: CGFloat,
                           trailing: CGFloat,
                           height: CGFloat) -> [NSLayoutConstraint] {
        
        self.leftKnob = leftKnob
        self.rightKnob = rightKnob
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.leadingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: self.superview,
                                                    attribute: .leading,
                                                    multiplier: 1.0,
                                                    constant: leading)
        
        self.trailingConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self.superview,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: -1.0 * trailing)
        
        self.heightConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: height)
        
        let barConstraints: [NSLayoutConstraint] = [
            self.leadingConstraint,
            self.trailingConstraint,
            self.heightConstraint,
            NSLayoutConstraint(item: self,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.superview,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.superview,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        ]
        
        return barConstraints
    }
    
    /**
     Overridden hitTest method to support out of bounds view.
     In this case we have to manage the fact that the knobs must be
     draggable also outside of the bar bounds.
     
     - parameter point: the hit point inside the bar.
     - parameter event: the event that caused the hit.
     
     - returns the view that must manage the touch.
     */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if let leftKnobHittedView = self.hitTestViewFor(knob: self.leftKnob, contains: point, with: event)  {
            
            return leftKnobHittedView
        }
        
        if let rightKnobHittedView = self.hitTestViewFor(knob: self.rightKnob, contains: point, with: event)  {
            
            return rightKnobHittedView
        }
        
        return self
    }
    
    /**
     Select the hitTest for a specific knob if it contains the point of touch.
     
     - seealso: https://developer.apple.com/library/content/qa/qa2013/qa1812.html.
     
     - parameter point: the hit point inside the bar.
     - parameter event: the event that caused the hit.
     
     - returns: the view that must manage the touch.
     */
    fileprivate func hitTestViewFor(knob: Knob, contains point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let pointForTargetView = knob.convert(point, from: self)
        
        if knob.bounds.contains(pointForTargetView) {
            
            return knob.hitTest(pointForTargetView, with: event)
        }
        
        return nil
    }
}

// MARK: Gradient

fileprivate class GradientView: UIView {
    
    /// An additional layer to manage gradient effects.
    lazy private(set) var gradient: CAGradientLayer = CAGradientLayer()
    
    /**
     Layout subviews. In this case we need to layout the added gradient layer to get the size of the container.
     Disable also the CA default animation.
     */
    override func layoutSubviews() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.gradient.frame = self.bounds
        CATransaction.commit()
        CATransaction.setDisableActions(false)
    }
    
    /**
     Add a gradient to the view. This method execute the setup of the gradientLayer property, using data received.
     
     - parameter firstColor: the first color of the gradient.
     - parameter secondColor: the second color of the gradient.
     - parameter startPoint: the starting point of the gradient.
     - parameter endPoint: the end point of the gradient.
     - parameter cornerRadius: the corner radius inherited from the container. Default 0.0.
     */
    fileprivate func addGradient(firstColor: UIColor?,
                                 secondColor: UIColor?,
                                 startPoint: CGPoint?,
                                 endPoint: CGPoint?,
                                 cornerRadius: CGFloat = 0.0) {
        
        guard firstColor != nil && secondColor != nil else {
            
            return
        }
        
        let color1 = firstColor ?? UIColor(red: 140.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        let color2 = secondColor ?? UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        let begin = startPoint ?? CGPoint(x: 0.0, y: 0.5)
        let end = endPoint ?? CGPoint(x: 0.0, y: 1.0)
        
        self.gradient.colors = [color1.cgColor, color2.cgColor]
        self.gradient.startPoint = begin
        self.gradient.endPoint = end
        self.gradient.cornerRadius = cornerRadius
        
        self.layer.addSublayer(self.gradient)
    }
}

// MARK: Knob

/// Enum used to identify the knob position.
fileprivate enum KnobPosition {
    case left
    case right
}

/// Class used to describe the knobs of the slider.
fileprivate class Knob: GradientView {
    
    /// Knob background view.
    private(set) var backgroundView: UIView = UIView()
    /// ImageView used as background view when an image is choosed for knob.
    lazy private(set) var imageView: UIImageView = UIImageView()
    /// Knob x position constraint.
    private(set) var xPositionConstraint: NSLayoutConstraint!
    /// Knob width constraint.
    private(set) var widthConstraint: NSLayoutConstraint!
    /// Knob height constraint.
    private(set) var heightConstraint: NSLayoutConstraint!
    /// Knob position.
    private(set) var position: KnobPosition!
    /// Gesture recognizer target.
    private(set) var gestureRecognizerTarget: Any?
    
    /**
     Method used to setup the knob.
     
     - parameter position: the knob position.
     - parameter width: the knob width.
     - parameter height: the knob height.
     - parameter target: the knob gesture target.
     - parameter selector: the knob gesture selector.
     
     - returns: an arrays of knob constraints to be activated.
     */
    fileprivate func setup(position: KnobPosition,
                           width: CGFloat,
                           height: CGFloat,
                           target: Any?,
                           selector: Selector) -> [NSLayoutConstraint] {
        
        self.position = position
        self.translatesAutoresizingMaskIntoConstraints = false
        let knobBackgroundConstraints: [NSLayoutConstraint] = self.setupBackground()
        self.setXPositionConstraint()
        self.setDimensionConstraints(usingWidth: width, andHeight: height)
        self.setGestureRecognizer(withTarget: target, usingSelector: selector)
        
        let knobConstraints: [NSLayoutConstraint] = [
            self.xPositionConstraint,
            self.centerVerticallyConstraint(),
            self.widthConstraint,
            self.heightConstraint
        ]
        
        return knobConstraints + knobBackgroundConstraints
    }
    
    /**
     Method used to setup a knob background.
     
     - returns: an arrays of knob background constraints to be activated.
     */
    private func setupBackground() -> [NSLayoutConstraint] {
        
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.backgroundView)
        
        let knobBackgroundViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: self.backgroundView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self.backgroundView,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self.backgroundView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self.backgroundView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)
        ]
        
        return knobBackgroundViewConstraints
    }
    
    /**
     Method used to create a constraint to manage the x position of the knob.
     */
    private func setXPositionConstraint() {
        
        self.xPositionConstraint = NSLayoutConstraint(item: self,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: self.superview,
                                                      attribute: self.position == .left ? .leading : .trailing,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
    }
    
    /**
     Method used to create the constraints used to manage the width and height of the knob.
     
     - parameter width: the width of the knob.
     - parameter height: the height of the knob.
     */
    private func setDimensionConstraints(usingWidth width: CGFloat, andHeight height: CGFloat) {
        
        self.widthConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: width)
        
        self.heightConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: height)
    }
    
    /**
     Method used to create the constraint used to manage the Y position of the knob.
     
     - returns: an NSLayoutConstraint used to manage the y position of the knob.
     */
    private func centerVerticallyConstraint() -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: self,
                                  attribute: .centerY,
                                  relatedBy: .equal,
                                  toItem: self.superview,
                                  attribute: .centerY,
                                  multiplier: 1.0,
                                  constant: 1.0)
    }
    
    /**
     Method used to create and attach a gesture recognizer to the knob.
     
     - parameter target: the target for the gesture recognizer selector action.
     - parameter selector: the selector used by the target to manage the action.
     */
    private func setGestureRecognizer(withTarget target: Any?, usingSelector selector: Selector) {
        
        let gesture = UIPanGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(gesture)
    }
    
    /**
     Method used to add an image on the knob (to use as background).
     
     - parameter anImage: the image to be used as background of the knob.
     */
    fileprivate func add(image anImage: UIImage?) {
        
        if let image = anImage {
            
            self.imageView.image = image
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.contentMode = .scaleToFill
            self.addSubview(self.imageView)
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: self.imageView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .centerX,
                                   multiplier: 1.0,
                                   constant: 0.0),
                NSLayoutConstraint(item: self.imageView,
                                   attribute: .centerY,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .centerY,
                                   multiplier: 1.0,
                                   constant: 0.0),
                NSLayoutConstraint(item: self.imageView,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .width,
                                   multiplier: 1.0,
                                   constant: 0.0),
                NSLayoutConstraint(item: self.imageView,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .height,
                                   multiplier: 1.0,
                                   constant: 0.0)
                ])
        }
    }
    
    /**
     Add borders to the knob.
     
     - parameter color: the border UIColor.
     - parameter width: the border width.
     - parameter corners: the current corner radius of the knob.
     */
    fileprivate func addBorders(usingColor color: UIColor, andWidth width: CGFloat, andCorners corners: CGFloat) {
        
        if self.imageView.image != nil {
            
            self.addBorders(toView: self.imageView, usingColor: color, andWidth: width)
            self.imageView.layer.cornerRadius = corners
        } else {
            
            self.addBorders(toView: self.backgroundView, usingColor: color, andWidth: width)
        }
    }
    
    /**
     Add borders to a specific view.
     
     - parameter view: the view on which the border will be added.
     - parameter color: the border UIColor.
     - parameter width: the border width.
     */
    private func addBorders(toView view: UIView,
                            usingColor color: UIColor,
                            andWidth width: CGFloat) {
        
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
    }
}

// MARK: Progress

/// Class used to describe the progress view inside the bar of the range slider.
fileprivate class ProgressView: GradientView {
    
    /**
     Method used to setup the background of the progress view using an image.
     The image is streched using the resizable with cap api.
     
     - parameter image: the image to be used as background.
     - parameter edgeInset: the edge inset to be used for image stretching.
     - parameter corners: corner radius ihnerited from the bar (container of the progress views).
     */
    fileprivate func addBackground(usingImage image: UIImage,
                                   andEdgeInset edgeInset: UIEdgeInsets,
                                   andCorners corners: CGFloat) {
        
        let backgroundResizableImage = image.resizableImage(withCapInsets: edgeInset)
        let backgroundImageView = UIImageView(image: backgroundResizableImage)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.layer.masksToBounds = corners > 0
        backgroundImageView.layer.cornerRadius = corners
        self.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: backgroundImageView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: backgroundImageView,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: backgroundImageView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: backgroundImageView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)
            ])
    }
    
    /**
     Method used to setup the progress view.
     
     - parameter leftAnchorView: the view used as left reference for the progress view constraints.
     - parameter leftAnchorConstraintAttribute: the attribute to be used for left margin constraint.
     - parameter rightAnchorView: the view used as rightreference for the progress view constraints.
     - parameter rightAnchorConstraintAttribute: the attribute to be used for right margin constraint.
     - parameter color: the background color of the progress view.
     
     - returns: an array of progress view constraints.
     */
    fileprivate func setup(leftAnchorView: UIView,
                           leftAnchorConstraintAttribute: NSLayoutAttribute,
                           rightAnchorView: UIView,
                           rightAnchorConstraintAttribute: NSLayoutAttribute,
                           color: UIColor) -> [NSLayoutConstraint] {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
        
        let progressViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: self,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self.superview,
                               attribute: .height,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.superview,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: leftAnchorView,
                               attribute: leftAnchorConstraintAttribute,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: self,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: rightAnchorView,
                               attribute: rightAnchorConstraintAttribute,
                               multiplier: 1.0,
                               constant: 0.0)
        ]
        
        return progressViewConstraints
    }
}
