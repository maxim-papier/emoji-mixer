import UIKit

final class EmojiMixFactory {

    private let emojiSet = [
        "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎",
        "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥",
        "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬",
        "🥦", "🧄", "🧅", "🍄"
    ]

    func makeEmojiMix() -> EmojiMix {
        let mix = makeNewMix(emojiSet)
        let color = makeBackGroundColorHue(mix)
        let emojiMix = EmojiMix(emojis: mix, backgroundColorHue: color)
        return emojiMix
    }
    
    private func makeNewMix(_ emojis: [String]) -> String {
        let randomEmojis = (1...3).map { _ in emojis.randomElement()! }
        let joinedEmojis = randomEmojis.joined(separator: "")
        return joinedEmojis
    }

    private func makeBackGroundColorHue(_ emojis: String) -> Float {
        let hashValue = Float(abs(emojis.hashValue))
        let hashRounded = Float(Int(hashValue) % 1000) / 1000.0
        let hue = hashRounded
        return hue
    }
}

extension CGFloat {
    func rounded(toDecimalPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
