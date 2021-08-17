//
//  libQuicklyView
//

import Foundation
import libQuicklyCore

public class QButtonView : IQButtonView {
    
    public var layout: IQLayout? {
        get { return self._view.layout }
    }
    public unowned var item: QLayoutItem? {
        set(value) { self._view.item = value }
        get { return self._view.item }
    }
    public var native: QNativeView {
        return self._view.native
    }
    public var isLoaded: Bool {
        return self._view.isLoaded
    }
    public var bounds: QRect {
        return self._view.bounds
    }
    public var isVisible: Bool {
        return self._view.isVisible
    }
    public var inset: QInset {
        set(value) { self.setNeedForceLayout() }
        get { return self._layout.inset }
    }
    public var backgroundView: IQView
    public var spinnerPosition: QButtonViewSpinnerPosition {
        set(value) { self._layout.spinnerPosition = value }
        get { return self._layout.spinnerPosition }
    }
    public var spinnerAnimating: Bool {
        set(value) {
            self._layout.spinnerAnimating = value
            self.spinnerView?.animating(value)
        }
        get { return self._layout.spinnerAnimating }
    }
    public var spinnerView: IQSpinnerView?
    public var imagePosition: QButtonViewImagePosition {
        set(value) { self._layout.imagePosition = value }
        get { return self._layout.imagePosition }
    }
    public var imageInset: QInset {
        set(value) { self._layout.imageInset = value }
        get { return self._layout.imageInset }
    }
    public var imageView: IQView?
    public var textInset: QInset {
        set(value) { self._layout.textInset = value }
        get { return self._layout.textInset }
    }
    public var textView: IQView?
    public var isHighlighted: Bool {
        set(value) {
            if self._isHighlighted != value {
                self._isHighlighted = value
                self.triggeredChangeStyle(false)
            }
        }
        get { return self._isHighlighted }
    }
    public var isSelected: Bool {
        set(value) {
            if self._isSelected != value {
                self._isSelected = value
                self.triggeredChangeStyle(false)
            }
        }
        get { return self._isSelected }
    }
    public var color: QColor? {
        set(value) { self._view.color = value }
        get { return self._view.color }
    }
    public var cornerRadius: QViewCornerRadius {
        set(value) { self._view.cornerRadius = value }
        get { return self._view.cornerRadius }
    }
    public var border: QViewBorder {
        set(value) { self._view.border = value }
        get { return self._view.border }
    }
    public var shadow: QViewShadow? {
        set(value) { self._view.shadow = value }
        get { return self._view.shadow }
    }
    public var alpha: Float {
        set(value) { self._view.alpha = value }
        get { return self._view.alpha }
    }
    
    private var _layout: Layout
    private var _view: QControlView< Layout >
    private var _isHighlighted: Bool
    private var _isSelected: Bool
    private var _onChangeStyle: ((_ userIteraction: Bool) -> Void)?
    
    public init(
        inset: QInset = QInset(horizontal: 4, vertical: 4),
        backgroundView: IQView,
        spinnerPosition: QButtonViewSpinnerPosition = .fill,
        spinnerView: IQSpinnerView? = nil,
        spinnerAnimating: Bool = false,
        imagePosition: QButtonViewImagePosition = .left,
        imageInset: QInset = QInset(horizontal: 4, vertical: 4),
        imageView: IQView? = nil,
        textInset: QInset = QInset(horizontal: 4, vertical: 4),
        textView: IQView? = nil,
        isHighlighted: Bool = false,
        isSelected: Bool = false,
        color: QColor? = nil,
        border: QViewBorder = .none,
        cornerRadius: QViewCornerRadius = .none,
        shadow: QViewShadow? = nil,
        alpha: Float = 1
    ) {
        self.backgroundView = backgroundView
        self.spinnerView = spinnerView
        self.imageView = imageView
        self.textView = textView
        self._layout = Layout(
            inset: inset,
            backgroundItem: QLayoutItem(view: backgroundView),
            spinnerPosition: spinnerPosition,
            spinnerItem: spinnerView.flatMap({ return QLayoutItem(view: $0) }),
            spinnerAnimating: spinnerAnimating,
            imagePosition: imagePosition,
            imageInset: imageInset,
            imageItem: imageView.flatMap({ return QLayoutItem(view: $0) }),
            textInset: textInset,
            textItem: textView.flatMap({ return QLayoutItem(view: $0) })
        )
        self._view = QControlView(
            contentLayout: self._layout,
            shouldHighlighting: true,
            shouldPressed: true,
            color: color,
            border: border,
            cornerRadius: cornerRadius,
            shadow: shadow,
            alpha: alpha
        )
        self._isHighlighted = isHighlighted
        self._isSelected = isSelected
    }
    
    public func loadIfNeeded() {
        self._view.loadIfNeeded()
    }
    
    public func size(_ available: QSize) -> QSize {
        return self._view.size(available)
    }
    
    public func appear(to layout: IQLayout) {
        self._view.appear(to: layout)
    }
    
    public func disappear() {
        self._view.disappear()
    }
    
    public func visible() {
        self._view.visible()
    }
    
    public func visibility() {
        self._view.visibility()
    }
    
    public func invisible() {
        self._view.invisible()
    }
    
    public func triggeredChangeStyle(_ userIteraction: Bool) {
        self._onChangeStyle?(userIteraction)
    }
    
    @discardableResult
    public func inset(_ value: QInset) -> Self {
        self.inset = value
        return self
    }
    
    @discardableResult
    public func spinnerPosition(_ value: QButtonViewSpinnerPosition) -> Self {
        self.spinnerPosition = value
        return self
    }
    
    @discardableResult
    public func spinnerAnimating(_ value: Bool) -> Self {
        self.spinnerAnimating = value
        return self
    }
    
    @discardableResult
    public func imagePosition(_ value: QButtonViewImagePosition) -> Self {
        self.imagePosition = value
        return self
    }
    
    @discardableResult
    public func imageInset(_ value: QInset) -> Self {
        self.imageInset = value
        return self
    }
    
    @discardableResult
    public func textInset(_ value: QInset) -> Self {
        self.textInset = value
        return self
    }
    
    @discardableResult
    public func highlight(_ value: Bool) -> Self {
        self.isHighlighted = value
        return self
    }
    
    @discardableResult
    public func select(_ value: Bool) -> Self {
        self.isSelected = value
        return self
    }
    
    @discardableResult
    public func color(_ value: QColor?) -> Self {
        self._view.color(value)
        return self
    }
    
    @discardableResult
    public func border(_ value: QViewBorder) -> Self {
        self._view.border(value)
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ value: QViewCornerRadius) -> Self {
        self._view.cornerRadius(value)
        return self
    }
    
    @discardableResult
    public func shadow(_ value: QViewShadow?) -> Self {
        self._view.shadow(value)
        return self
    }
    
    @discardableResult
    public func alpha(_ value: Float) -> Self {
        self._view.alpha(value)
        return self
    }
    
    @discardableResult
    public func onAppear(_ value: (() -> Void)?) -> Self {
        self._view.onAppear(value)
        return self
    }
    
    @discardableResult
    public func onDisappear(_ value: (() -> Void)?) -> Self {
        self._view.onDisappear(value)
        return self
    }
    
    @discardableResult
    public func onVisible(_ value: (() -> Void)?) -> Self {
        self._view.onVisible(value)
        return self
    }
    
    @discardableResult
    public func onVisibility(_ value: (() -> Void)?) -> Self {
        self._view.onVisibility(value)
        return self
    }
    
    @discardableResult
    public func onInvisible(_ value: (() -> Void)?) -> Self {
        self._view.onInvisible(value)
        return self
    }
    
    @discardableResult
    public func onChangeStyle(_ value: ((_ userIteraction: Bool) -> Void)?) -> Self {
        self._view.onChangeStyle(value)
        return self
    }
    
    @discardableResult
    public func onPressed(_ value: (() -> Void)?) -> Self {
        self._view.onPressed(value)
        return self
    }
    
}

extension QButtonView {
    
    class Layout : IQLayout {
        
        unowned var delegate: IQLayoutDelegate?
        unowned var view: IQView?
        var inset: QInset {
            didSet { self.setNeedForceUpdate() }
        }
        var backgroundItem: QLayoutItem {
            didSet { self.setNeedForceUpdate(item: self.backgroundItem) }
        }
        var spinnerPosition: QButtonViewSpinnerPosition {
            didSet { self.setNeedForceUpdate() }
        }
        var spinnerItem: QLayoutItem? {
            didSet { self.setNeedForceUpdate(item: self.spinnerItem) }
        }
        var spinnerAnimating: Bool {
            didSet { self.setNeedForceUpdate() }
        }
        var imagePosition: QButtonViewImagePosition {
            didSet { self.setNeedForceUpdate() }
        }
        var imageInset: QInset {
            didSet { self.setNeedForceUpdate() }
        }
        var imageItem: QLayoutItem? {
            didSet { self.setNeedForceUpdate(item: self.imageItem) }
        }
        var textInset: QInset {
            didSet { self.setNeedForceUpdate() }
        }
        var textItem: QLayoutItem? {
            didSet { self.setNeedForceUpdate(item: self.textItem) }
        }
        private var _cacheSpinnerSize: QSize?
        private var _cacheImageSize: QSize?
        private var _cacheTextSize: QSize?

        init(
            inset: QInset,
            backgroundItem: QLayoutItem,
            spinnerPosition: QButtonViewSpinnerPosition,
            spinnerItem: QLayoutItem?,
            spinnerAnimating: Bool,
            imagePosition: QButtonViewImagePosition,
            imageInset: QInset,
            imageItem: QLayoutItem?,
            textInset: QInset,
            textItem: QLayoutItem?
        ) {
            self.inset = inset
            self.backgroundItem = backgroundItem
            self.spinnerPosition = spinnerPosition
            self.spinnerItem = spinnerItem
            self.spinnerAnimating = spinnerAnimating
            self.imagePosition = imagePosition
            self.imageInset = imageInset
            self.imageItem = imageItem
            self.textInset = textInset
            self.textItem = textItem
        }
        
        public func invalidate(item: QLayoutItem) {
            if self.spinnerItem === item {
                self._cacheSpinnerSize = nil
            } else if self.imageItem === item {
                self._cacheImageSize = nil
            } else if self.textItem === item {
                self._cacheTextSize = nil
            }
        }
        
        func layout(bounds: QRect) -> QSize {
            self.backgroundItem.frame = bounds
            if self.spinnerAnimating == true, let spinnerItem = self.spinnerItem {
                let spinnerSize = self._spinnerSize(bounds.size, item: spinnerItem)
                switch self.spinnerPosition {
                case .fill:
                    spinnerItem.frame = QRect(center: bounds.center, size: spinnerSize)
                case .image:
                    if self.imageItem != nil, let textItem = self.textItem {
                        let textSize = self._textSize(bounds.size, item: textItem)
                        let frames = self._frame(
                            position: self.imagePosition,
                            bounds: bounds,
                            primarySize: spinnerSize,
                            primaryInset: self.imageInset,
                            secondarySize: textSize,
                            secondaryInset: self.textInset
                        )
                        spinnerItem.frame = frames.primary
                        textItem.frame = frames.secondary
                    } else {
                        spinnerItem.frame = QRect(center: bounds.center, size: spinnerSize)
                    }
                }
            } else if let imageItem = self.imageItem, let textItem = self.textItem {
                let imageSize = self._imageSize(bounds.size, item: imageItem)
                let textSize = self._textSize(bounds.size, item: textItem)
                let frames = self._frame(
                    position: self.imagePosition,
                    bounds: bounds,
                    primarySize: imageSize,
                    primaryInset: self.imageInset,
                    secondarySize: textSize,
                    secondaryInset: self.textInset
                )
                imageItem.frame = frames.primary
                textItem.frame = frames.secondary
            } else if let imageItem = self.imageItem {
                let imageSize = self._imageSize(bounds.size, item: imageItem)
                imageItem.frame = QRect(center: bounds.center, size: imageSize)
            } else if let textItem = self.textItem {
                let textSize = self._textSize(bounds.size, item: textItem)
                textItem.frame = QRect(center: bounds.center, size: textSize)
            }
            return bounds.size
        }
        
        func size(_ available: QSize) -> QSize {
            var size = QSize(width: 0, height: 0)
            let spinnerSize = self.spinnerItem.flatMap({ return $0.size(available) })
            let imageSize = self.imageItem.flatMap({ return $0.size(available) })
            let textSize = self.textItem.flatMap({ return $0.size(available) })
            if self.spinnerAnimating == true, let spinnerSize = spinnerSize {
                switch self.spinnerPosition {
                case .fill:
                    size.width = self.inset.left + spinnerSize.width + self.inset.right
                    size.height = self.inset.top + spinnerSize.height + self.inset.bottom
                case .image:
                    if imageSize != nil, let textSize = textSize {
                        switch self.imagePosition {
                        case .top:
                            size.width = self.inset.left + max(spinnerSize.width, textSize.width) + self.inset.right
                            size.height = self.inset.top + spinnerSize.height + self.imageInset.bottom + self.textInset.top + textSize.height + self.inset.bottom
                        case .left:
                            size.width += self.inset.left + spinnerSize.width + self.imageInset.right + self.textInset.left + textSize.width + self.inset.right
                            size.height = self.inset.top + max(spinnerSize.height, textSize.height) + self.inset.bottom
                        case .right:
                            size.width = self.inset.left + textSize.width + self.textInset.right + self.imageInset.left + spinnerSize.width + self.inset.right
                            size.height = self.inset.top + max(spinnerSize.height, textSize.height) + self.inset.bottom
                        case .bottom:
                            size.width = self.inset.left + max(spinnerSize.width, textSize.width) + self.inset.right
                            size.height = self.inset.top + textSize.height + self.textInset.bottom + self.imageInset.top + spinnerSize.height + self.inset.bottom
                        }
                    } else {
                        size.width = self.inset.left + spinnerSize.width + self.inset.right
                        size.height = self.inset.top + spinnerSize.height + self.inset.bottom
                    }
                }
            } else if let imageSize = imageSize, let textSize = textSize {
                switch self.imagePosition {
                case .top:
                    size.width = self.inset.left + max(imageSize.width, textSize.width) + self.inset.right
                    size.height = self.inset.top + imageSize.height + self.imageInset.bottom + self.textInset.top + textSize.height + self.inset.bottom
                case .left:
                    size.width = self.inset.left + imageSize.width + self.imageInset.right + self.textInset.left + textSize.width + self.inset.right
                    size.height = self.inset.top + max(imageSize.height, textSize.height) + self.inset.bottom
                case .right:
                    size.width = self.inset.left + textSize.width + self.textInset.right + self.imageInset.left + imageSize.width + self.inset.right
                    size.height = self.inset.top + max(imageSize.height, textSize.height) + self.inset.bottom
                case .bottom:
                    size.width = self.inset.left + max(imageSize.width, textSize.width) + self.inset.right
                    size.height = self.inset.top + textSize.height + self.textInset.bottom + self.imageInset.top + imageSize.height + self.inset.bottom
                }
            } else if let imageSize = imageSize {
                size.width = self.inset.left + imageSize.width + self.inset.right
                size.height = self.inset.top + imageSize.height + self.inset.bottom
            } else if let textSize = textSize {
                size.width = self.inset.left + textSize.width + self.inset.right
                size.height = self.inset.top + textSize.height + self.inset.bottom
            }
            return size
        }
        
        func items(bounds: QRect) -> [QLayoutItem] {
            var items: [QLayoutItem] = [ self.backgroundItem ]
            if self.spinnerAnimating == true {
                if let item = self.spinnerItem {
                    items.append(item)
                }
            } else {
                if let item = self.imageItem {
                    items.append(item)
                }
                if let item = self.textItem {
                    items.append(item)
                }
            }
            return items
        }
        
    }
    
}

private extension QButtonView.Layout {
    
    func _spinnerSize(_ available: QSize, item: QLayoutItem) -> QSize {
        if let size = self._cacheSpinnerSize {
            return size
        }
        self._cacheSpinnerSize = item.size(available)
        return self._cacheSpinnerSize!
    }
    
    func _imageSize(_ available: QSize, item: QLayoutItem) -> QSize {
        if let size = self._cacheImageSize {
            return size
        }
        self._cacheImageSize = item.size(available)
        return self._cacheImageSize!
    }
    
    func _textSize(_ available: QSize, item: QLayoutItem) -> QSize {
        if let size = self._cacheTextSize {
            return size
        }
        self._cacheTextSize = item.size(available)
        return self._cacheTextSize!
    }
    
    func _frame(position: QButtonViewImagePosition, bounds: QRect, primarySize: QSize, primaryInset: QInset, secondarySize: QSize, secondaryInset: QInset) -> (primary: QRect, secondary: QRect) {
        let primary: QRect
        let secondary: QRect
        switch position {
        case .top:
            let offest = primaryInset.top + primarySize.height + secondaryInset.top
            let baseline = max(primarySize.width, secondarySize.width) / 2
            primary = QRect(
                x: baseline - (primarySize.width / 2),
                y: 0,
                width: primarySize.width,
                height: primarySize.height
            )
            secondary = QRect(
                x: baseline - (secondarySize.width / 2),
                y: offest,
                width: secondarySize.width,
                height: secondarySize.height
            )
        case .left:
            let offest = primaryInset.left + primarySize.width + secondaryInset.left
            let baseline = max(primarySize.height, secondarySize.height) / 2
            primary = QRect(
                x: 0,
                y: baseline - (primarySize.height / 2),
                width: primarySize.width,
                height: primarySize.height
            )
            secondary = QRect(
                x: offest,
                y: baseline - (secondarySize.height / 2),
                width: secondarySize.width,
                height: secondarySize.height
            )
        case .right:
            let offest = primaryInset.left + secondarySize.width + secondaryInset.right
            let baseline = max(primarySize.width, secondarySize.width) / 2
            primary = QRect(
                x: offest,
                y: baseline - (primarySize.height / 2),
                width: primarySize.width,
                height: primarySize.height)
            secondary = QRect(
                x: 0,
                y: baseline - (secondarySize.height / 2),
                width: secondarySize.width,
                height: secondarySize.height
            )
        case .bottom:
            let offest = primaryInset.top + secondarySize.height + secondaryInset.bottom
            let baseline = max(primarySize.height, secondarySize.height) / 2
            primary = QRect(
                x: baseline - (primarySize.width / 2),
                y: offest,
                width: primarySize.width,
                height: primarySize.height
            )
            secondary = QRect(
                x: baseline - (secondarySize.width / 2),
                y: 0,
                width: secondarySize.width,
                height: secondarySize.height
            )
        }
        let union = primary.union(secondary)
        let center = bounds.center
        let offset = QPoint(
            x: center.x - (union.width / 2),
            y: center.y - (union.height / 2)
        )
        return (
            primary: QRect(center: primary.center + offset, size: primarySize),
            secondary: QRect(center: secondary.center + offset, size: secondarySize)
        )
    }
    
}
