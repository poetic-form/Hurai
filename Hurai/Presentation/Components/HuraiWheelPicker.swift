//
//  HuraiWheelPicker.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/8/25.
//

import SwiftUI

struct HuraiWheelPicker: UIViewRepresentable {
    var items: [Int]
    @Binding var selection: Int
    var rowHeight: CGFloat = 40
    var font: UIFont = .systemFont(ofSize: 18)   // row 폰트와 크기
    var textColor: UIColor = .lightText            // row 글자 색상
    var accentColor: UIColor = .yellow          // 강조 색상
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setContentHuggingPriority(.defaultLow, for: .horizontal)
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        DispatchQueue.main.async {
            picker.subviews.forEach { $0.backgroundColor = .clear }
        }
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        if let index = items.firstIndex(of: selection) {
            uiView.selectRow(index, inComponent: 0, animated: true)
            uiView.reloadAllComponents()
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: HuraiWheelPicker
        
        init(_ parent: HuraiWheelPicker) {
            self.parent = parent
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            parent.items.count
        }
        
        func pickerView(_ pickerView: UIPickerView,
                        rowHeightForComponent component: Int) -> CGFloat {
            parent.rowHeight
        }
        
        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = "\(parent.items[row])"
            label.font = parent.font
            label.textAlignment = .center
            label.textColor = parent.items[row] == parent.selection ? .yellow : parent.textColor
            
            return label
        }
        
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            parent.selection = parent.items[row]
        }
    }
}

//#Preview {
//    HuraiWheelPicker()
//}
