import UIKit
import CoreData

final class EmojiMixStore {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    convenience init() {
        // Получаем контекст Core Data из AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
        self.init(context: context) // Вызываем первый инициализатор, передавая контекст
    }

    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {

        let emojiMixerCoreData = EmojiMixCoreData(context: context)

        emojiMixerCoreData.mix = emojiMix.emojis
        //emojiMixerCoreData.colorHue = emojiMix.backgroundColor

        try context.save()
    }

}
