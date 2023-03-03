import UIKit
import CoreData

final class EmojiMixStore {

    private let context: NSManagedObjectContext
    private let emojiMixerEntityName = "EmojiMixCoreData"

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
        emojiMixerCoreData.colorHue = emojiMix.backgroundColorHue

        try context.save()
    }

    func fetchEmojiMixes() throws -> [EmojiMix] {
        let request = NSFetchRequest<EmojiMixCoreData>(entityName: emojiMixerEntityName)
        let emojis = try context.fetch(request)
        var emojiMixes = [EmojiMix]()
        
        for emoji in emojis {
            guard let emojiMixString = emoji.mix else { return .init() }
            let emojiMix = EmojiMix(emojis: emojiMixString, backgroundColorHue: emoji.colorHue)
            emojiMixes.append(emojiMix)
        }

        return emojiMixes
    }

    func cleanDB(completion: @escaping () -> Void) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: emojiMixerEntityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(batchDeleteRequest)
        completion()
    }

}
