import UIKit

class HomeVC: UIViewController {

    private let emojiMixFactory = EmojiMixFactory()
    private let emojiMixStore = EmojiMixStore()

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reuseCellID = "Cell"
    private var visibleEmojis: [EmojiMix] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            visibleEmojis = try emojiMixStore.fetchEmojiMixes()
        } catch {
            print("Error fetching emoji mixes: \(error.localizedDescription)")
        }

        if let navBar = navigationController?.navigationBar {
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNextEmoji))
            let leftButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanDB))
            navBar.topItem?.setRightBarButton(rightButton, animated: true)
            navBar.topItem?.setLeftBarButton(leftButton, animated: true)

        }
        setUp()
    }

    @objc
    private func addNextEmoji() {

        let newEmojiMix = emojiMixFactory.makeEmojiMix()
        let newEmojiMixIndex = visibleEmojis.count
        let newItemIndexPath = IndexPath(item: visibleEmojis.count - 1, section: 0)
        collectionView.scrollToItem(at: newItemIndexPath, at: .top, animated: true)

        try! emojiMixStore.addNewEmojiMix(newEmojiMix)
        visibleEmojis = try! emojiMixStore.fetchEmojiMixes()

        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: newEmojiMixIndex, section: 0)])
        }
    }

    @objc
    private func cleanDB() {

        try! emojiMixStore.cleanDB {
            DispatchQueue.main.async { [self] in
                visibleEmojis = []
                collectionView.reloadData()
            }
        }
    }

    func setUp() {
        registerClassesForReuse()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        setConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func registerClassesForReuse() {
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: reuseCellID)
    }
}

// MARK: - DataSource

extension HomeVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleEmojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseCellID,
            for: indexPath
        ) as? EmojiCell else { return .init() }

        cell.titleLabel.text = visibleEmojis[indexPath.row].emojis
        cell.backgroundColor = visibleEmojis[indexPath.row].backgroundColor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - Layout

extension HomeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return .init(width: (collectionView.bounds.width - 10) / 2,
                     height: (collectionView.bounds.width - 10) / 2)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

}
