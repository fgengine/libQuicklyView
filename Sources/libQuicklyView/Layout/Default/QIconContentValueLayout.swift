//
//  libQuicklyView
//

import Foundation
import libQuicklyCore

public class QIconContentValueLayout< IconView: IQView, ContentView: IQView, ValueView: IQView > : IQLayout {
    
    public unowned var delegate: IQLayoutDelegate?
    public unowned var view: IQView?
    public var iconInset: QInset {
        didSet { self.setNeedForceUpdate() }
    }
    public var iconView: IconView {
        didSet { self.iconItem = QLayoutItem(view: self.iconView) }
    }
    public private(set) var iconItem: QLayoutItem {
        didSet { self.setNeedForceUpdate(item: self.iconItem) }
    }
    public var contentInset: QInset {
        didSet { self.setNeedForceUpdate() }
    }
    public var contentView: ContentView {
        didSet { self.contentItem = QLayoutItem(view: self.contentView) }
    }
    public private(set) var contentItem: QLayoutItem {
        didSet { self.setNeedForceUpdate(item: self.contentItem) }
    }
    public var valueInset: QInset {
        didSet { self.setNeedForceUpdate() }
    }
    public var valueView: ValueView {
        didSet { self.valueItem = QLayoutItem(view: self.valueView) }
    }
    public private(set) var valueItem: QLayoutItem {
        didSet { self.setNeedForceUpdate(item: self.valueItem) }
    }
    
    public init(
        iconInset: QInset,
        iconView: IconView,
        contentInset: QInset,
        contentView: ContentView,
        valueInset: QInset,
        valueView: ValueView
    ) {
        self.iconInset = iconInset
        self.iconView = iconView
        self.iconItem = QLayoutItem(view: iconView)
        self.contentInset = contentInset
        self.contentView = contentView
        self.contentItem = QLayoutItem(view: contentView)
        self.valueInset = valueInset
        self.valueView = valueView
        self.valueItem = QLayoutItem(view: valueView)
    }
    
    public func layout(bounds: QRect) -> QSize {
        let iconSize = self.iconItem.size(available: bounds.size.apply(inset: self.iconInset))
        let valueSize = self.valueItem.size(available: bounds.size.apply(inset: self.valueInset))
        let iconContentValue = bounds.split(
            left: self.iconInset.left + iconSize.width + self.iconInset.right,
            right: self.valueInset.left + valueSize.width + self.valueInset.right
        )
        self.iconItem.frame = iconContentValue.left.apply(inset: self.iconInset)
        self.contentItem.frame = iconContentValue.middle.apply(inset: self.contentInset)
        self.valueItem.frame = iconContentValue.right.apply(inset: self.valueInset)
        return bounds.size
    }
    
    public func size(available: QSize) -> QSize {
        let iconSize = self.iconItem.size(available: available.apply(inset: self.iconInset))
        let iconBounds = iconSize.apply(inset: -self.iconInset)
        let valueSize = self.iconItem.size(available: available.apply(inset: self.valueInset))
        let valueBounds = valueSize.apply(inset: -self.valueInset)
        let contentAvailable = QSize(
            width: available.width - (iconBounds.width + valueBounds.width),
            height: available.height
        )
        let contentSize = self.contentItem.size(available: contentAvailable.apply(inset: self.contentInset))
        let contentBounds = contentSize.apply(inset: -self.contentInset)
        return QSize(
            width: iconBounds.width + contentBounds.width + valueBounds.width,
            height: max(iconBounds.height, contentBounds.height, valueBounds.height)
        )
    }
    
    public func items(bounds: QRect) -> [QLayoutItem] {
        return [ self.iconItem, self.contentItem, self.valueItem ]
    }
    
}
