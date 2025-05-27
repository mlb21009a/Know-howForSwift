//
//  CollectionView.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/25.
//

import SwiftUI

struct CollectionView: UIViewControllerRepresentable {

    private var didSelectItem:(()-> Void)?
    func tapCell(callback: @escaping ()->Void) -> Self {
        var ret = self
        ret.didSelectItem = callback
        return ret
    }

    /// 初回描画時
    func makeUIViewController(context: Context) -> UIViewController {
        print("makeUIView") //後で動作確認する用
        let vc = CollectionViewViewController()
        vc.collectionView.delegate = context.coordinator
        return vc
    }

    /// 初回描画前
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// 再描画時
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        print("updateUIView")
        context.coordinator.didSelectItem = didSelectItem
    }

    class Coordinator: NSObject, UICollectionViewDelegate {
        var parent: CollectionView
        var didSelectItem: (() -> Void)?


        init(_ parent: CollectionView) {
            self.parent = parent
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            didSelectItem?()
        }
    }
}

#Preview {
    CollectionView()
}

class CollectionViewViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case first
        case second
        case third
    }

    enum SectionItem: Hashable {
        case item1(Int)
    }

    private var layoutAttributes = [UICollectionViewLayoutAttributes]()

    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>! = nil
    private var snapshot: NSDiffableDataSourceSnapshot<Section, SectionItem>! = nil

    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: createLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .red
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        dataSource = UICollectionViewDiffableDataSource<Section, SectionItem>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            //            switch item {
            //            case let .item1(num):
            //                cell.hoge(count: num)
            //            }

            return cell
        }

        snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.item1(1), .item1(2), .item1(3), .item1(4)], toSection: .first)
        snapshot.appendItems([.item1(5), .item1(6), .item1(7), .item1(8)], toSection: .second)
        snapshot.appendItems([.item1(9), .item1(10), .item1(11), .item1(12)], toSection: .third)
        dataSource.apply(snapshot, animatingDifferences: false)


        //        dataSouce.supplementaryViewProvider = { collectionView, kind, indexPath in
        //            if kind == UICollectionView.elementKindSectionHeader {
        //                let view = UICollectionReusableView()
        //                view.backgroundColor = .red
        //                return view
        //            }
        //            return nil
        //        }

    }

    @IBAction func tapbutton(_ sender: UIButton) {
        collectionView.reloadData()
    }

    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            var itemSize: NSCollectionLayoutSize!
            var item: NSCollectionLayoutItem!
            var groupWidth: Double!
            var groupSize: NSCollectionLayoutSize!
            var group: NSCollectionLayoutGroup!
            switch Section(rawValue: sectionIndex) {
            case .first:
                // itemの定義
                itemSize = NSCollectionLayoutSize(widthDimension: .absolute(30.0),
                                                  heightDimension: .absolute(30.0))
                item = NSCollectionLayoutItem(layoutSize: itemSize)

                // groupの定義
                groupWidth = layoutEnvironment.container.effectiveContentSize.width - 15 * 2
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(30),
                                                   heightDimension: .absolute(30))
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1
                )
            case .second:
                // itemの定義
                itemSize = NSCollectionLayoutSize(widthDimension: .absolute(60.0),
                                                  heightDimension: .absolute(60.0))
                item = NSCollectionLayoutItem(layoutSize: itemSize)
                // groupの定義
                groupWidth = layoutEnvironment.container.effectiveContentSize.width - 15 * 2
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60),
                                                   heightDimension: .estimated(120))
                group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            case .third:
                // itemの定義
                itemSize = NSCollectionLayoutSize(widthDimension: .absolute(90.0),
                                                  heightDimension: .absolute(90.0))
                item = NSCollectionLayoutItem(layoutSize: itemSize)

                // groupの定義
                groupWidth = layoutEnvironment.container.effectiveContentSize.width - 15 * 2
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(90),
                                                   heightDimension: .estimated(180))
                group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            default:
                fatalError()
            }
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous

            //①
            section.interGroupSpacing = 10
            //②
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)

            // section headerの定義
            //            let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
            //                                                           heightDimension: .estimated(44))
            //            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: "header", alignment: .top)
            //            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        // sectionごとのスペース
        config.interSectionSpacing = 0

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }

}


class Cell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
