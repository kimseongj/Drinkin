//
//  ClickableInformationView.swift
//  TestLeftAlignment
//
//  Created by kimseongjun on 2023/05/08.
//

import UIKit
import SnapKit

class ClickableInformationView: UIView {
    private var title: String = ""
    
    private var toolDataSource: UICollectionViewDiffableDataSource<Section, CocktailTool>?
    private var skillDataSource: UICollectionViewDiffableDataSource<Section, CocktailSkill>?
    private var glassDataSource: UICollectionViewDiffableDataSource<Section, CocktailGlass>?
    
    var delegate: ProductDetailVCDelegate?
    
    private var skillLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var informationCollectionView: MutableSizeCollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = MutableSizeCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.register(InformationCell.self, forCellWithReuseIdentifier: InformationCell.identifier)
        collectionView.backgroundColor = .white
 
        return collectionView
    }()
    
    private let skillLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 15)
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        configureTitle()
        configureUI()
        configurelInformationCollectionView()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitle() {
        skillLabel.text = title
    }
    
    func configureUI() {
        self.backgroundColor = .white
        self.addSubview(skillLabelView)
        skillLabelView.addSubview(skillLabel)
        self.addSubview(informationCollectionView)
        
        skillLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(informationCollectionView)
            make.width.equalTo(62)
        }
        
        skillLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        informationCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(skillLabelView.snp.trailing)
        }
    }
    
    func configurelInformationCollectionView() {
        informationCollectionView.delegate = self
        if let flowLayout = informationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension ClickableInformationView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushSkillModalVC()
    }
}


extension ClickableInformationView {
    func configureDataSource() {
        switch title {
        case "도구":
            self.toolDataSource = UICollectionViewDiffableDataSource<Section, CocktailTool> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailTool) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil
                }
            
                cell.fill(with: cocktailTool)
                
                return cell
            }
        case "기법":
            self.skillDataSource = UICollectionViewDiffableDataSource<Section, CocktailSkill> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailSkill) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil
                }
                
                cell.fill(with: cocktailSkill)
                
                return cell
            }
        case "글라스":
            self.glassDataSource = UICollectionViewDiffableDataSource<Section, CocktailGlass> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailGlass) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil
                }
                
                
                cell.fill(with: cocktailGlass)
                
                return cell
            }
        default:
            return
        }
    }
    
    func applySnapshot(cocktailDescription: CocktailDescription) {
        switch title {
        case "도구":
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailTool>()
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.toolList)
            self.toolDataSource?.apply(snapshot, animatingDifferences: true)
        case "기법":
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailSkill>()
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.skillList)
            self.skillDataSource?.apply(snapshot, animatingDifferences: true)
        case "글라스":
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailGlass>()
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.glassList)
            self.glassDataSource?.apply(snapshot, animatingDifferences: true)
        default:
            return
        }
    }
}
