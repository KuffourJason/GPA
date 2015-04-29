import bb.cascades 1.3
import bb.system 1.2


ScrollView {
    id: scroll
    property string credits: credit.text
    property string grades: grade.text
    property string courseNames: courseName.text    
    property string visGrade: grades
    property string visCredits: credits
    property int hold: 0
    property int key: 0
    property int done: 0
    
    scrollViewProperties.scrollMode: ScrollMode.Horizontal
    scrollViewProperties.maxContentScale: 1.0
    scrollViewProperties.minContentScale: -1.5
    scrollViewProperties.initialScalingMethod: ScalingMethod.AspectFit
    preferredWidth: 930
    
    
    signal courseRemoved()
    signal editT()
    
    
    onTouch: {
        ////////////////////////////////////////////
        //Swiping to end things event
        if( event.isDown() ){
            hold = event.localX
        }      
        if( event.isUp()){
            if( (hold - event.localX) > 300){
                visCredits = credits; visGrade = grades;
                scroll.setVisible(false)
            
            }
            else if( hold - event.localX < 10 && hold - event.localX > -10){
                event.timestamp
                edied.open()
            }
            else{
                scroll.scrollToPoint(0, scroll.translationY)
            }
        }
        ////////////////////////////////////////////
    }
    
    
    onVisibleChanged: { 
        courseRemoved()
        destroy()
        
    }
    
    
    onCreationCompleted: {
        scroll.done = 1
    }
    
    
    Container {      
        id: cON  
        background: Color.White    
        layout: DockLayout { }
        preferredWidth: 1000
        preferredHeight: 200
        
        Container {
            layout: DockLayout { }
            translationY: -10.0
            minWidth: 768
            minHeight: 220
            
            Label {
                id: courseName
                text: courseNames
                objectName: "courseName"
                minHeight: 200
                textFit.minFontSizeValue: 26.0
                textStyle.color: Color.Black
                translationY: 0.0
            
            }
            
            Label {
                id: grade_Label
                text: "Grade: "
                minWidth: 192
                translationY: 160.0
            }
            
            Label {
                id: grade
                objectName: "grade"
                text: grades
                minWidth: 192
                textFit.minFontSizeValue: 9.0
                translationY: 150.0
                translationX: 140.0
                
                onTextChanged: {
                    if( grade.text != ""){
                        scroll.grades =  grade.text
                        editT()
                    }
                }
                
            }
            
            Label {
                id: credits_Label
                text: "Credits: "
                translationY: 160.0
                translationX: 384.0
            
            }
            
            Label {
                id: credit
                text: credits
                objectName: "credit"
                translationY: 160.0
                translationX: 524.0
                
                onTextChanged: {
                    if( grade.text != ""){
                        scroll.credits =  credit.text
                    }
                }
            
            }
        }
        
        //Not sure exactly what it does, but it is needed
        // Label {
        ///    id: empty
        //    text: "you"
        //      minHeight: 300
        //     minWidth: 768
        //     translationX: 1210.0
        // }
        
        
        //This container is responsible for the Space at the top
        Container {
            layout: DockLayout {  }
            id: topSpaceDivider
            translationY: -30.0
            minWidth: 930
            background: Color.create("#6b726d6d")
            
            Label {
                id: space
                translationY: 30.0
                minWidth: 930
                opacity: 0.0
                translationX: -40.0
            }
        }
    
    
    }
    
    attachedObjects: [
        //REPLACE WITH CUSTOMIZED ADD DIALOG VIEW BOX
        EditDialogView {
            id: edied
            cn: courseName.text
            
            onOpened: {
                visCredits = credits
                visGrade = grades
                courseRemoved()
                credit.setText("0")
                grade.setText("")
            } 
        }
    ]
    scaleX: 1.0
    translationX: 0.0
}


