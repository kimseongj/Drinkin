//
//  ClickableInformationView.swift
//  TestLeftAlignment
//
//  Created by kimseongjun on 2023/05/08.
//

import UIKit
import SnapKit

final class ClickableInformationView: UIView {
    weak var flowDelegate: ProductDetailVCFlow?
    private var cocktailDescription: CocktailDescription?
    private var toolDataSource: UICollectionViewDiffableDataSource<Section, CocktailTool>!
    private var skillDataSource: UICollectionViewDiffableDataSource<Section, CocktailSkill>!
    private var glassDataSource: UICollectionViewDiffableDataSource<Section, CocktailGlass>!
    private var title: String = ""
    private var idList: [Int] = []
    
    private var titleLabelView: UIView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    //MARK: - Init
    
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
    
    
    
    //MARK: - ConfigureUI
    
    private func configureTitle() {
        titleLabel.text = title
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(titleLabelView)
        titleLabelView.addSubview(titleLabel)
        self.addSubview(informationCollectionView)
        
        titleLabelView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.height.equalTo(33)
            $0.width.equalTo(65)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(7)
        }
        
        informationCollectionView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalTo(titleLabelView.snp.trailing)
            $0.height.greaterThanOrEqualTo(33)
        }
    }
    
    //MARK: - Fill View
    
    func fill(with cocktailDescription: CocktailDescription) {
        fetchIDList(cocktailDescription: cocktailDescription)
        applySnapshot(cocktailDescription: cocktailDescription)
    }
    
    func receive(cocktailDescription: CocktailDescription?) {
        self.cocktailDescription = cocktailDescription
    }
    
    func fetchIDList(cocktailDescription: CocktailDescription) {
        switch title {
        case InformationStrings.tool:
            self.idList = cocktailDescription.toolList.map { $0.id }
        case InformationStrings.skill:
            self.idList = cocktailDescription.skillList.map { $0.id }
        case InformationStrings.glass:
            self.idList = cocktailDescription.glassList.map { $0.id }
        default:
            return
        }
    }
}

//MARK: - ConfigureCollectionView

extension ClickableInformationView {
    private func configurelInformationCollectionView() {
        informationCollectionView.delegate = self
        if let flowLayout = informationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

//MARK: - InformationCollectionView DiffableDataSource

extension ClickableInformationView {
    private func configureDataSource() {
        switch title {
        case InformationStrings.tool:
            self.toolDataSource = UICollectionViewDiffableDataSource<Section, CocktailTool> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailTool) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil }
                
                cell.fill(with: cocktailTool)
                
                return cell
            }
        case InformationStrings.skill:
            self.skillDataSource = UICollectionViewDiffableDataSource<Section, CocktailSkill> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailSkill) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil }
                
                cell.fill(with: cocktailSkill)
                
                return cell
            }
        case InformationStrings.glass:
            self.glassDataSource = UICollectionViewDiffableDataSource<Section, CocktailGlass> (collectionView: informationCollectionView) { (collectionView, indexPath, cocktailGlass) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCell.identifier, for: indexPath) as? InformationCell else { return nil }
                
                cell.fill(with: cocktailGlass)
                
                return cell
            }
        default:
            return
        }
    }
    
    private func applySnapshot(cocktailDescription: CocktailDescription) {
        switch title {
        case InformationStrings.tool:
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailTool>()
            if cocktailDescription.toolList.count == 0 {
                snapshot.appendSections([.main])
                snapshot.appendItems([CocktailTool(id: 0, toolNameKo: "-")])
                self.toolDataSource?.apply(snapshot, animatingDifferences: true)
                break
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.toolList)
            self.toolDataSource?.apply(snapshot, animatingDifferences: true)
            
        case InformationStrings.skill:
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailSkill>()
            if cocktailDescription.skillList.count == 0 {
                snapshot.appendSections([.main])
                snapshot.appendItems([CocktailSkill(id: 0, skillNameKo: "-")])
                self.skillDataSource?.apply(snapshot, animatingDifferences: true)
                break
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.skillList)
            self.skillDataSource?.apply(snapshot, animatingDifferences: true)
            
        case InformationStrings.glass:
            var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailGlass>()
            if cocktailDescription.glassList.count == 0 {
                snapshot.appendSections([.main])
                snapshot.appendItems([CocktailGlass(id: 0, glassNameKo: "-")])
                self.glassDataSource?.apply(snapshot, animatingDifferences: true)
                break
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(cocktailDescription.glassList)
            self.glassDataSource?.apply(snapshot, animatingDifferences: true)
        default:
            return
        }
    }
}

//MARK: - InformationCollectionView Delegate

extension ClickableInformationView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let validCocktailDescription = cocktailDescription else { return }
        
        switch title {
        case InformationStrings.tool:
            flowDelegate?.pushToolModalVC(toolID: validCocktailDescription.toolList[indexPath.row].id)
        case InformationStrings.skill:
            flowDelegate?.pushSkillModalVC(skillID: validCocktailDescription.skillList[indexPath.row].id)
        case InformationStrings.glass:
            flowDelegate?.pushGlassModalVC(glassID: validCocktailDescription.glassList[indexPath.row].id)
        default:
            return
        }
    }
}
