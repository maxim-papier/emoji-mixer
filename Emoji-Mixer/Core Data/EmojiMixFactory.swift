import UIKit

final class EmojiMixFactory {

    private let emojiSet = [
        "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎",
        "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥",
        "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬",
        "🥦", "🧄", "🧅", "🍄"
    ]

    func maketEmojiMix() -> EmojiMix {
        let mix = makeNewMix(emojiSet)
        let color = makeBackGroundColor(mix)
        let emojiMix = EmojiMix(emojis: mix, backgroundColor: color)
        return emojiMix
    }
    
    private func makeNewMix(_ emojis: [String]) -> String {
        let randomEmojis = (1...3).map { _ in emojis.randomElement()! }
        let joinedEmojis = randomEmojis.joined(separator: "")
        return joinedEmojis
    }

    private func makeBackGroundColor(_ emojis: String) -> UIColor {
        let hashValue = CGFloat(abs(emojis.hashValue))
        let hashRounded = CGFloat(Int(hashValue) % 1000) / 1000.0
        let color = UIColor(hue: hashRounded, saturation: 0.3, brightness: 1, alpha: 1)

        print("hashValue = \(hashValue)")
        print("hashRounded = \(hashRounded)")

        return color
    }
}


extension CGFloat {
    func rounded(toDecimalPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
