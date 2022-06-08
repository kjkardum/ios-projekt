import Foundation
import UIKit
import SnapKit

class SearchBarView: UIView, UITextFieldDelegate {
    var searchIcon: UIImageView!
    var searchBox: UITextField!
    var clearButton: UIButton!
    var cancelButton: UIButton!
    
    weak var delegate: SearchBoxDelegate?
    
    init() {
        super.init(frame: CGRect())
        
        buildView()
        setViewLayout()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        searchBox = UITextField()
        searchBox.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        searchBox.backgroundColor = .searchBoxBackgroundColor
        searchBox.layer.cornerRadius = 10
        searchBox.delegate = self
        searchBox.textColor = .white
        searchBox.layer.borderColor = UIColor.recommendedBackgroundColor.cgColor
        searchBox.layer.borderWidth = 1
        
        searchIcon = UIImageView(image: UIImage(systemSymbol: .magnifyingglass))
        searchIcon.tintColor = .white
        let searchIconWrapper = UIView()
        searchIconWrapper.addSubview(searchIcon)
        
        searchBox.leftView = searchIconWrapper
        searchBox.leftViewMode = .always
        
        clearButton = UIButton.createIconButton(
            icon: .xmark,
            backgroundColor: .clear,
            color: .white,
            iconSize: 10,
            target: self,
            action: #selector(clearSearchBox))
        let clearButtonWrapper = UIView()
        clearButtonWrapper.addSubview(clearButton)
        
        searchBox.rightView = clearButtonWrapper
        searchBox.rightViewMode = .whileEditing
        
        searchBox.addTarget(self, action: #selector(searchBoxDidChange), for: .editingChanged)
        
        cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelSearchBox), for: .touchUpInside)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)

        addSubview(searchBox)
        addSubview(cancelButton)
        
    }
    
    func setViewLayout() {
        searchBox.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        cancelButton.isHidden = true
        searchIcon.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        clearButton.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        cancelButton.snp.makeConstraints{ make in
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(searchBox)
        }
    }
    
    func changeCancelButtonVisibility(visible: Bool) {
        let animationSpeed = 0.2
        if visible {
            UIView.animate(withDuration: animationSpeed) { [weak self] in
                guard let self = self else { return }
                self.searchBox.snp.updateConstraints{ make in
                    make.trailing.equalToSuperview().inset(self.cancelButton.frame.width + 20)
                }
                self.layoutIfNeeded()
            }
            cancelButton.fadeIn(animationSpeed)
            
        } else {
            cancelButton.fadeOut(animationSpeed)
            UIView.animate(withDuration: animationSpeed) { [weak self] in
                guard let self = self else { return }
                self.searchBox.snp.updateConstraints{ make in
                    make.trailing.equalToSuperview()
                }
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func clearSearchBox() {
        searchBox.text = ""
        searchBoxDidChange(searchBox: searchBox)
    }
    
    @objc func cancelSearchBox() {
        clearSearchBox()
        changeCancelButtonVisibility(visible: false)
        searchBox.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeCancelButtonVisibility(visible: true)
        delegate?.onSearchBoxFocus()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeCancelButtonVisibility(visible: false)
        delegate?.onSearchBoxUnfocus()
    }
    
    @objc func searchBoxDidChange(searchBox: UITextField) {
        delegate?.onSearchBoxChange(input: searchBox.text ?? "")
    }
}
