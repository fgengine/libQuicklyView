//
//  libQuicklyView
//

import Foundation
import libQuicklyCore

public protocol IQEmptyView : IQView, IQViewColorable, IQViewBorderable, IQViewCornerRadiusable, IQViewShadowable, IQViewAlphable {
    
    var width: QDimensionBehaviour? { set get }
    
    var height: QDimensionBehaviour? { set get }
    
    var aspectRatio: Float? { set get }
    
    @discardableResult
    func width(_ value: QDimensionBehaviour?) -> Self
    
    @discardableResult
    func height(_ value: QDimensionBehaviour?) -> Self
    
    @discardableResult
    func aspectRatio(_ value: Float?) -> Self
    
}
