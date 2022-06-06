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
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        searchBox.backgroundColor = .gray
        searchBox.layer.cornerRadius = 10
        searchBox.delegate = self
        searchBox.textColor = .darkGray
        
        searchIcon = UIImageView(image: UIImage(systemSymbol: .magnifyingglass))
        searchIcon.tintColor = .black
        let searchIconWrapper = UIView()
        searchIconWrapper.addSubview(searchIcon)
        
        searchBox.leftView = searchIconWrapper
        searchBox.leftViewMode = .always
        
        clearButton = UIButton.createIconButton(
            icon: .xmark,
            backgroundColor: UIColor(white: 1, alpha: 0),
            color: .black,
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
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
//        cancelButton.titleLabel?.font = (fontStyle: .subheadline)
        addSubview(searchBox)
        addSubview(cancelButton)
        
    }
    
    func setViewLayout() {
        searchBox.snp.makeConstraints{ make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(0)
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
                    make.right.equalToSuperview().inset(self.cancelButton.frame.width + 20)
                }
                self.layoutIfNeeded()
            }
            cancelButton.fadeIn(animationSpeed)
            
        } else {
            cancelButton.fadeOut(animationSpeed)
            UIView.animate(withDuration: animationSpeed) { [weak self] in
                guard let self = self else { return }
                self.searchBox.snp.updateConstraints{ make in
                    make.right.equalToSuperview().inset(0)
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
