//
//  libQuicklyView
//

import Foundation
import libQuicklyCore

protocol ControlViewDelegate : AnyObject {
    
    func shouldHighlighting(view: QControlView.ControlView) -> Bool
    func set(view: QControlView.ControlView, highlighted: Bool)
    
    func shouldPressing(view: QControlView.ControlView) -> Bool
    func pressed(view: QControlView.ControlView)
    
}

public final class QControlView : IQControlView {
    
    public private(set) weak var parentLayout: IQLayout?
    public weak var item: IQLayoutItem?
    public var native: QNativeView {
        return self._view
    }
    public var isLoaded: Bool {
        return self._reuseView.isLoaded
    }
    public var isAppeared: Bool {
        guard self.isLoaded == true else { return false }
        return self._view.isAppeared
    }
    public private(set) var layout: IQLayout {
        willSet {
            self.layout.parentView = nil
        }
        didSet(oldValue) {
            self.layout.parentView = self
            guard self.isLoaded == true else { return }
            self._view.update(layout: self.layout)
        }
    }
    public var contentSize: QSize {
        get {
            guard self.isLoaded == true else { return QSize() }
            return self._view.contentSize
        }
    }
    public private(set) var shouldHighlighting: Bool {
        didSet {
            if self.shouldHighlighting == false {
                self.isHighlighted = false
            }
        }
    }
    public private(set) var isHighlighted: Bool {
        set(value) {
            if self._isHighlighted != value {
                self._isHighlighted = value
                self._onChangeStyle?(false)
            }
        }
        get { return self._isHighlighted }
    }
    public private(set) var shouldPressed: Bool
    public private(set) var color: QColor? {
        didSet {
            guard self.isLoaded == true else { return }
            self._view.update(color: self.color)
        }
    }
    public private(set) var cornerRadius: QViewCornerRadius {
        didSet {
            guard self.isLoaded == true else { return }
            self._view.update(cornerRadius: self.cornerRadius)
            self._view.updateShadowPath()
        }
    }
    public private(set) var border: QViewBorder {
        didSet {
            guard self.isLoaded == true else { return }
            self._view.update(border: self.border)
        }
    }
    public private(set) var shadow: QViewShadow? {
        didSet {
            guard self.isLoaded == true else { return }
            self._view.update(shadow: self.shadow)
            self._view.updateShadowPath()
        }
    }
    public private(set) var alpha: QFloat {
        didSet {
            guard self.isLoaded == true else { return }
            self._view.update(alpha: self.alpha)
        }
    }
    
    private var _reuseView: QReuseView< ControlView >
    private var _view: ControlView {
        if self.isLoaded == false { self._reuseView.load(view: self) }
        return self._reuseView.item!
    }
    private var _isHighlighted: Bool
    private var _onAppear: (() -> Void)?
    private var _onDisappear: (() -> Void)?
    private var _onChangeStyle: ((_ userIteraction: Bool) -> Void)?
    private var _onPressed: (() -> Void)?
    
    public init(
        layout: IQLayout,
        shouldHighlighting: Bool = false,
        isHighlighted: Bool = false,
        shouldPressed: Bool = false,
        color: QColor? = QColor(rgba: 0x00000000),
        border: QViewBorder = .none,
        cornerRadius: QViewCornerRadius = .none,
        shadow: QViewShadow? = nil,
        alpha: QFloat = 1
    ) {
        self.layout = layout
        self.shouldHighlighting = shouldHighlighting
        self._isHighlighted = shouldHighlighting == true && isHighlighted == true
        self.shouldPressed = shouldPressed
        self.color = color
        self.border = border
        self.cornerRadius = cornerRadius
        self.shadow = shadow
        self.alpha = alpha
        self._reuseView = QReuseView()
        self.layout.parentView = self
    }
    
    public func size(_ available: QSize) -> QSize {
        return self.layout.size(available)
    }
    
    public func appear(to layout: IQLayout) {
        self.parentLayout = layout
        self._onAppear?()
    }
    
    public func disappear() {
        self._reuseView.unload(view: self)
        self.parentLayout = nil
        self._onDisappear?()
    }
    
    @discardableResult
    public func layout(_ value: IQLayout) -> Self {
        self.layout = value
        return self
    }
    
    @discardableResult
    public func shouldHighlighting(_ value: Bool) -> Self {
        self.shouldHighlighting = value
        return self
    }
    
    @discardableResult
    public func highlighted(_ value: Bool) -> Self {
        self.isHighlighted = value
        return self
    }
    
    @discardableResult
    public func shouldPressed(_ value: Bool) -> Self {
        self.shouldPressed = value
        return self
    }
    
    @discardableResult
    public func color(_ value: QColor?) -> Self {
        self.color = value
        return self
    }
    
    @discardableResult
    public func border(_ value: QViewBorder) -> Self {
        self.border = value
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ value: QViewCornerRadius) -> Self {
        self.cornerRadius = value
        return self
    }
    
    @discardableResult
    public func shadow(_ value: QViewShadow?) -> Self {
        self.shadow = value
        return self
    }
    
    @discardableResult
    public func alpha(_ value: QFloat) -> Self {
        self.alpha = value
        return self
    }
    
    @discardableResult
    public func onAppear(_ value: (() -> Void)?) -> Self {
        self._onAppear = value
        return self
    }
    
    @discardableResult
    public func onDisappear(_ value: (() -> Void)?) -> Self {
        self._onDisappear = value
        return self
    }
    
    @discardableResult
    public func onChangeStyle(_ value: ((_ userIteraction: Bool) -> Void)?) -> Self {
        self._onChangeStyle = value
        return self
    }
    
    @discardableResult
    public func onPressed(_ value: (() -> Void)?) -> Self {
        self._onPressed = value
        return self
    }
    
}

extension QControlView : ControlViewDelegate {
    
    func shouldHighlighting(view: QControlView.ControlView) -> Bool {
        return self.shouldHighlighting
    }
    
    func set(view: QControlView.ControlView, highlighted: Bool) {
        if self._isHighlighted != highlighted {
            self._isHighlighted = highlighted
            self._onChangeStyle?(true)
        }
    }
    
    func shouldPressing(view: QControlView.ControlView) -> Bool {
        return self.shouldPressed
    }
    
    func pressed(view: QControlView.ControlView) {
        self._onPressed?()
    }
    
}
