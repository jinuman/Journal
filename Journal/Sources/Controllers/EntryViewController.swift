//
//  ViewController.swift
//  Journal
//
//  Created by 김진우 on 2018. 8. 13..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
}

let longText = """
vase : 꽃병 / bundle : 다발, bouquet : 꽃다발, 부케
ex) a bundle of straw : 짚 한 다발
manifest : (유령, 징후)나타나다, 분명해지다
devour : 게걸스럽게 먹다, 뚫어지게 보다, (호기심 등)~의 이성을 빼앗다
I was devoured by fear : 나는 두려움에 질려 제정신이 아니었다.
She devoured every word I said : 그녀는 나의 말을 열심히 들었다.
compartment : 칸막이, 구획  /  compart : 구획하다, 칸을 막다
impudence : 뻔뻔스러움
ex) None of your impudence! 수작 부리지마!
dubious : 의심스러운, 수상한 == uncertain
allegory : 비유 == metaphor  /  figurative : 비유적인
manifestation : 표현, 명시, 표시
aesthetics, esthetics  : 미학, 미적 정서의 연구
From an aesthetic point of view : 미학적 관점에서 말하면
props : 소품
gut : 내장, 용기(courage), 배짱
patent : 특허권
fin : 지느러미
incessantly : 끊임없이
firecracker : 폭죽
neurologist : 신경과 의사
physical examination : 신체검사
blood test : 혈액 검사
adversary : (언쟁, 전투에서) 상대방, 적수
degradation : 저하, 수모, 비하, 전락
stale : 케케묵은, 진부한
pervert : 왜곡하다, 비뚤어지게 하다, 변태
distort : 왜곡하다, 일그러뜨리다
explosion : 폭발, 폭발적인 증가
ex) a population explosion : 폭발적인 인구 증가
persecution : (종교적) 박해, 학대, 괴롭힘
communist : 공산주의자 / communism : 공산주의
democrat : 민주주의자 / democracy : 민주주의
explicit : 분명한 / explicitly : 명쾌하게
implicit : 암시된 / implicitly : 함축적으로
expel : (from) 퇴학시키다
ex) She was expelled from school at 15 : 그녀는 15세에 퇴학당했다.
show trial : 공개 재판
patriot : 애국자 / patriotic : 애국적인
capital area : 수도권
suburb : 교외(도심지를 벗어난 주택지역), 변두리 == outskirt
respiratory : 호흡의
respiratory system : 호흡기
respiratory organs : 호흡기관
internal organs : 내장
bracket : 괄호
() == parenthesis
"""

class EntryViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIBarButtonItem!
    
    let journal: Journal = InMemoryJournal()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = longText
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardAppearance(_:)),
                name: NSNotification.Name.UIKeyboardWillShow,
                object: nil)
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardAppearance(_:)),
                name: NSNotification.Name.UIKeyboardWillHide,
                object: nil)
    }
    
    @objc func handleKeyboardAppearance(_ note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as?
                NSValue),
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as?
                TimeInterval),
            let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as?
                UInt)
            else { return }
        
        let isKeyboardWillShow: Bool = note.name ==
            Notification.Name.UIKeyboardWillShow
        let keyboardHeight = isKeyboardWillShow
            ? keyboardFrame.cgRectValue.height
            : 0
        let animationOption = UIViewAnimationOptions.init(rawValue: curve)
        
        UIView.animate(
            withDuration:  duration,
            delay: 0.0,
            options: animationOption,
            animations: {
                self.textViewBottomConstraint.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            },
            completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSubviews(for: true)
    }

    @objc func saveEntry(_ sender: Any) {
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
        } else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
        }
        updateSubviews(for: false)
    }
    
    @objc func editEntry(_ sender: Any) {
        updateSubviews(for: true)
    }
    
    fileprivate func updateSubviews(for isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            textView.becomeFirstResponder()
            
            button.title = "저장하기"
            button.target = self
            button.action = #selector(saveEntry(_:))
        } else {
            textView.isEditable = false
            textView.resignFirstResponder()
            
            button.title = "수정하기"
            button.target = self
            button.action = #selector(editEntry(_:))
        }
    }
}

