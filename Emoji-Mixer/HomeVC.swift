import UIKit

class HomeVC: UIViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reuseCellID = "Cell"
    private let emojiSet = [
        "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎",
        "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥",
        "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬",
        "🥦", "🧄", "🧅", "🍄"
    ]
    private var visibleEmojis: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navBar = navigationController?.navigationBar {

            let leftButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoLastEmoji))
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNextEmoji))
            navBar.topItem?.setLeftBarButton(leftButton, animated: true)
            navBar.topItem?.setRightBarButton(rightButton, animated: true)
        }
        setUp()
    }


    @objc
    private func undoLastEmoji() {

        guard visibleEmojis.count > 0 else { return }

        let lastEmojiIndex = visibleEmojis.count - 1
        visibleEmojis.removeLast()
        collectionView.performBatchUpdates {
            collectionView.performBatchUpdates {
                collectionView.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
            }
        }
    }

    @objc
    private func addNextEmoji() {

        guard visibleEmojis.count < emojiSet.count else { return }

        let nextEmojiIndex = visibleEmojis.count
        visibleEmojis.append(emojiSet[nextEmojiIndex])
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: nextEmojiIndex, section: 0)])
        }

    }


    func setUp() {
        registerClassesForReuse()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
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

        cell.emojiLabel.text = visibleEmojis[indexPath.row]
        return cell
    }
}

// MARK: - Layout

extension HomeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return .init(width: collectionView.bounds.width / 2, height: 50)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

}




extension HomeVC: UICollectionViewDelegate {

}
