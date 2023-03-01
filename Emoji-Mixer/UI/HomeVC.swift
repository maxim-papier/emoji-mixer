import UIKit

class HomeVC: UIViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reuseCellID = "Cell"
    private var visibleEmojis: [EmojiMix] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navBar = navigationController?.navigationBar {
            //            let leftButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoLastEmoji))
            //            navBar.topItem?.setLeftBarButton(leftButton, animated: true)
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNextEmoji))
            navBar.topItem?.setRightBarButton(rightButton, animated: true)
        }
        setUp()
    }


    //    @objc
    //    private func undoLastEmoji() {
    //
    //        guard visibleEmojis.count > 0 else { return }
    //
    //        let lastEmojiIndex = visibleEmojis.count - 1
    //        visibleEmojis.removeLast()
    //        collectionView.performBatchUpdates {
    //            collectionView.performBatchUpdates {
    //                collectionView.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
    //            }
    //        }
    //    }

    @objc
    private func addNextEmoji() {


        let newEmojiMix = EmojiMixFactory().maketEmojiMix()
        visibleEmojis.append(newEmojiMix)
        let newIndex = visibleEmojis.count - 1

        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
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
