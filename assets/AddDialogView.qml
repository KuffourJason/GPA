import bb.cascades 1.3
import bb.system 1.0

Dialog {
    id: yo
    property string cn: cour.text
    property string gra: grade_value.selectedValue
    property string cre: credit_value.selectedOption.text
    
    property bool gradeChanged: false
    property bool creditChanged: false
    
    property string cour_select: cour.text
    property int cre_select: credit_value.selectedIndex
    property int gra_select: grade_value.selectedIndex
    
    Container {
        translationY: 220.0
        
        Container {
            id: conta
            layout: DockLayout {}
            background: Color.Red
            preferredHeight: 700
            preferredWidth: 728
            translationX: 40
            opacity: 0.9
            
            Button {
                id: add
                text: "Add"
                translationX: 160.0
                translationY: 530.0
                minWidth: 300
                
                
                onClicked: {
                    if( gradeChanged && creditChanged ){ 
                        courseName.setText(cour.text)
                        grade.setText(grade_value.selectedValue)
                        credit.setText(credit_value.selectedValue)
                        yo.close()
                        success.show()
                    }
                    else if( creditChanged && !gradeChanged) {
                        missing_grade.show()
                    }
                    else if( gradeChanged && !creditChanged){
                        missing_credit.show()
                    }
                    else{
                        missing_both.show()
                    }
                }
                
                attachedObjects: [
                    SystemToast {
                        id: success
                        body: "Course Add Successful"
                    }, 
                    SystemToast {
                        id: missing_grade
                        body: "Please select a value for the grade"
                    },
                    SystemToast {
                        id: missing_credit
                        body: "Please select a value for the credit"
                    },
                    SystemToast {
                        id: missing_both
                        body: "Please select values for both the grade and credit"
                    }
                ]
                focusAutoShow: FocusAutoShow.Default
                appearance: ControlAppearance.Default
                color: Color.White
                opacity: 1.0
            }
            
            Label {
                id: gRADES
                text: "GRADES"
                textFit.minFontSizeValue: 13.0
                textStyle.color: Color.White
                translationY: 250.0
                translationX: 60.0
            }
            
            DropDown {
                id: grade_value
                objectName: grade_value
                selectedIndex: gra_select
                preferredWidth: 150
                minWidth: 76
                maxWidth: 150
                translationX: 70.0
                translationY: 370.0
                
                
                Option {
                    value: "A+"
                    text: "A+"
                }
                Option {
                    value: "A"
                    text: "A"
                }
                Option {
                    value: "B+"
                    text: "B+"
                }
                Option {
                    value: "B"
                    text: "B"
                }
                Option {
                    value: "C+"
                    text: "C+"
                }
                Option {
                    value: "C"
                    text: "C"
                }
                Option {
                    value: "D+"
                    text: "D+"
                }
                Option {
                    value: "D"
                    text: "D"
                }
                Option {
                    value: "E"
                    text: "E"
                }
                Option {
                    value: "F"
                    text: "F"
                }
                
                onExpandedChanged: {
                    if (expanded) {
                        add.setVisible(false);
                        conta.setMinHeight(950)
                    } else {
                        add.setVisible(true);
                        conta.setMinHeight(700)
                    }
                }
                
                onSelectedValueChanged: {
                    yo.gradeChanged = true
                }
                accessibility.name: ""
                visible: true
                opacity: 1.0

            }
            
            Label {
                id: cREDITS
                text: "CREDITS"
                textFit.minFontSizeValue: 13.0
                textStyle.color: Color.White
                translationY: 250.0
                translationX: 410.0
            }
            
            DropDown {
                id: credit_value
                objectName: credit_value
                selectedIndex: cre_select
                preferredWidth: 150
                minWidth: 150
                maxWidth: 150
                translationX: 420.0
                translationY: 370.0
                
                Option {
                    text: "1"
                    value: "1"
                }
                Option {
                    text: "2"
                    value: "2"
                }
                Option {
                    text: "3"
                    value: "3"
                }
                Option {
                    text: "4"
                    value: "4"
                }
                Option {
                    text: "6"
                    value: "6"
                }
                Option {
                    text: "9"
                    value: "9"
                }
                
                onExpandedChanged: {
                    if (expanded) {
                        add.setVisible(false);
                        conta.setMinHeight(950)
                    } else {
                        add.setVisible(true);
                        conta.setMinHeight(700)
                    }
                }
                
                onSelectedValueChanged: {
                    yo.creditChanged = true
                }
            }
            
            Label {
                id: cOURSE
                text: "COURSE"
                textStyle.color: Color.White
                textFit.minFontSizeValue: 13.0
                translationY: 40.0
                translationX: 60.0
            
            }
            TextField {
                id: cour
                backgroundVisible: false
                hintText: "Enter course name"
                text: cn.toUpperCase()
                translationY: 140.0
                preferredWidth: 610
                translationX: 38.0
                textFit.minFontSizeValue: 10.0
                inputMode: TextFieldInputMode.Default
                textStyle.color: Color.White
            
            }
            
            Divider {
                translationY: 210.0
                preferredWidth: 580
                translationX: 58
            }
            Divider {
                translationY: 211.0
                preferredWidth: 580
                translationX: 58
            }
        
        }
    }
}
