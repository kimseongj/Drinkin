//
//  IntroductionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit

class IntroductionView: UIView {
    
    let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cocktailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "갓파더"
        
        return label
    }()
    
    let cocktailTDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
여러분은 평소에 맥주를 즐겨드시나요? 저도 맥주를 참 좋아하는데요. 가끔 기분 전환이 필요할 때, 바로 오늘 소개해드릴 세르바사 콘 리몬을 만들어 마시곤 해요.

세르바사 콘 리몬은 스페인의 바나 레스토랑에서 쉽게 찾아볼 수 있어요. 그래서 이름도 스페인어인데 우리말로는 간단해요. 바로, ‘레몬을 넣은 맥주'죠.

레몬 향의 상쾌함과 라거 맥주의 청량감이 함께 어우러진 이 칵테일은, 남녀노소 모두 부담 없이 즐길 수 있답니다.

저도 기회만 된다면, 스페인 현지에서 즐겨보고 싶네요.
"""
        label.numberOfLines = 0
        return label
    }()
    
    let ingredientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        //stackView.layer.borderColor =
        stackView.layer.borderWidth = 2
        return stackView
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "스카치 위스키"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let receipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        return label
    }()
    
    let receipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = """
여러분은 평소에 맥주를 즐겨드시나요? 저도 맥주를 참 좋아하는데요. 가끔 기분 전환이 필요할 때, 바로 오늘 소개해드릴 세르바사 콘 리몬을 만들어 마시곤 해요.

세르바사 콘 리몬은 스페인의 바나 레스토랑에서 쉽게 찾아볼 수 있어요. 그래서 이름도 스페인어인데 우리말로는 간단해요. 바로, ‘레몬을 넣은 맥주'죠.

레몬 향의 상쾌함과 라거 맥주의 청량감이 함께 어우러진 이 칵테일은, 남녀노소 모두 부담 없이 즐길 수 있답니다.

저도 기회만 된다면, 스페인 현지에서 즐겨보고 싶네요.
"""
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailTitleLabel)
        self.addSubview(cocktailTDescriptionLabel)
        self.addSubview(ingredientStackView)
        ingredientStackView.addArrangedSubview(ingredientLabel)
        self.addSubview(receipeTitleLabel)
        self.addSubview(receipeDescriptionLabel)
        
        cocktailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        cocktailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        cocktailTDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        ingredientStackView.snp.makeConstraints { make in
            make.top.equalTo(cocktailTDescriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        receipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientStackView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        receipeDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(receipeTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
