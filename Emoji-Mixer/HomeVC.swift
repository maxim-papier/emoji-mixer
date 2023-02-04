import UIKit

class HomeVC: UIViewController {
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
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
    view.backgroundColor = .green
    setConstraints()
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
    collectionView.backgroundColor = .blue
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
    
    cell.backgroundColor = .black
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
    
    return .init(width: 50, height: 50)
  }
}


extension HomeVC: UICollectionViewDelegate {
  
}
