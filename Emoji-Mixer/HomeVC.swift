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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  func setUp() {
    registerClassesForReuse()
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    view.backgroundColor = .white
    setConstraints()
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
    collectionView.register(EmojiCollectionView.self, forCellWithReuseIdentifier: reuseCellID)
  }
}

// MARK: - DataSource

extension HomeVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return emojiSet.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseCellID,
      for: indexPath
    ) as? EmojiCollectionView else { return .init() }
    
    cell.emojiLabel.text = emojiSet[indexPath.row]
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
