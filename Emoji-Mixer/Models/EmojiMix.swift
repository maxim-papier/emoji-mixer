import UIKit

struct EmojiMix {
    let emojis: String
    let backgroundColorHue: Float

    var backgroundColor: UIColor {
        return UIColor(hue: CGFloat(backgroundColorHue), saturation: 0.3, brightness: 1, alpha: 1)
    }
}
