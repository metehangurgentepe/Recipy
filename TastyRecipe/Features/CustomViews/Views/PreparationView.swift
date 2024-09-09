//
//  PreparationView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class PreparationView: UIView {
    var timeStackView = UIStackView()
    let stepButton = UIButton()
    
    let preparationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline).withSize(18)
        label.text = "Preparation"
        return label
    }()
    
    let stepsStackView = UIStackView()
    
    var recipe: RecipeDetailModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configure()
        setupViews()
        setupInstructionViews()
    }
    
    convenience init(recipe: RecipeDetailModel) {
        self.init(frame: .zero)
        self.recipe = recipe
        setupInstructionViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentHeight = stepsStackView.frame.height + stepButton.frame.height + timeStackView.frame.height + preparationLabel.frame.height + 40
        self.frame.size.height = contentHeight
    }
    
    private func configure() {
        setupStepButton()
        setupTimeStackView()
    }
    
    private func setupViews() {
        addSubview(preparationLabel)
        addSubview(timeStackView)
        addSubview(stepButton)
        addSubview(stepsStackView)
        
        
        preparationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        timeStackView.snp.makeConstraints { make in
            make.top.equalTo(preparationLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.width.equalTo(ScreenSize.width - 20)
        }
        
        stepButton.snp.makeConstraints { make in
            make.top.equalTo(timeStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(35)
        }
        
        stepsStackView.snp.makeConstraints { make in
            make.top.equalTo(stepButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupInstructionViews() {
        stepsStackView.axis = .vertical
        stepsStackView.distribution = .equalSpacing
        stepsStackView.spacing = 6
        
        guard let recipeSteps = recipe?.analyzedInstructions else { return }
        
        for analyzedInstruction in recipeSteps {
            for oneStep in analyzedInstruction.steps! {
                let instructionView = InstructionView()
                instructionView.configure(step: oneStep)
                stepsStackView.addArrangedSubview(instructionView)
            }
        }
        
        stepsStackView.setNeedsLayout()
        stepsStackView.layoutIfNeeded()
        
        updateHeight()
    }

    
    func setupStepButton() {
        stepButton.setTitle("Step-by-step mode", for: .normal)
        stepButton.backgroundColor = ThemeColor.buttonBgColor
        stepButton.setTitleColor(.white, for: .normal)
    }
    
    func setupTimeStackView() {
        let spacing = ScreenSize.width - (120 * 3) - 20
        let prepTimeView = TimeView(title: "Prep Time", time: "15 min")
        let cookTimeView = TimeView(title: "Cook Time", time: "30 min")
        let totalTimeView = TimeView(title: "Total Time", time: "45 min")
        
        
        prepTimeView.frame.size = CGSize(width: 120, height: 60)
        cookTimeView.frame.size = CGSize(width: 120, height: 60)
        totalTimeView.frame.size = CGSize(width: 120, height: 60)
        
        let timeStackView = UIStackView(arrangedSubviews: [prepTimeView, cookTimeView, totalTimeView])
        timeStackView.axis = .horizontal
        timeStackView.distribution = .equalSpacing
        timeStackView.spacing = spacing
        
        self.timeStackView = timeStackView
    }
    
    private func updateHeight() {
        let contentHeight = stepsStackView.frame.height + stepButton.frame.height + timeStackView.frame.height + preparationLabel.frame.height + 40
        self.frame.size.height = contentHeight
        self.setNeedsLayout()
    }
}
