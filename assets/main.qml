/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades.multimedia 1.0
import bb.cascades 1.3
import bb.system 1.0

Page {
    id: topLevel
    objectName: "topLevel"



    Menu.definition: MenuDefinition {
        id: swipeDown
        helpAction: HelpActionItem {}

        actions: [
            ActionItem {
                title: "Exit"
                onTriggered: {  Application.quit() }
                imageSource: "asset:///images/exit.jpg"
            },    
            ActionItem {
                title: "Save"
                objectName: "save"
                imageSource: "asset:///images/save.png"
            },
            ActionItem {
                title: "Load"
                objectName: "load"
                imageSource: "asset:///images/load.png"
            }
        ]
    }

    Container {
        id: top
        objectName: "top"
        property int count
        property string old_cour: propertyMap.cou 
        property string old_let: propertyMap.gra
        property int old_cre: propertyMap.cre
     
          
       onOld_letChanged: {
            oldStuff.mySignal.connect( top.oldState(top.old_cre, top.old_let, top.old_cour) )
        }
        
                    
        function oldState(cREDITS, lETTER, nAME){
            old_stuff.dits =  cREDITS
            old_stuff.me = nAME
            old_stuff.ter = lETTER
            var oldcr = old_stuff.createObject()
            main.add(oldcr)           
        }
        
         signal start()
         signal leave()
         
         onStart: {
             top.start()
         }
         
     
        Container {
            layout: DockLayout {
            }
            preferredHeight: 380

            //This container contains the logo and the dividers
            Container {
                id: top_Label
                layout: DockLayout {
                }
                background: Color.Red
                preferredHeight: 230
                translationY: 0.0

                //Sets the appdroid logo and the effects
                ImageView {
                    id: logo
                    imageSource: "asset:///images/logo.jpg"
                    preferredWidth: 768
                    preferredHeight: 230
                    translationX: 0.0
                    opacity: 0.8



                    onTouch: {
                        if (event.isDown()) {
                            setOpacity(1)
                        }
                        if (event.isUp()) {
                            setOpacity(0.8)
                        }
                    }
                }

                Divider {
                    translationY: 225.0
                }
                Divider {
                    translationY: 226.0
                }
                Divider {
                    translationY: 227.0
                }
                Divider {
                    translationY: 228.0
                }
                Divider {
                    translationY: 229.0
                }
            }

            //This container holds the add and clear buttons. Along with the Yorku word and dividers
            Container {
                minHeight: 90
                background: Color.Red
                layout: DockLayout {
                }
                translationY: 230.0

                Divider {
                    translationY: 0.0
                }
                Divider {
                    translationY: 1.0
                }
                Divider {
                    translationY: 2.0
                }
                Divider {
                    translationY: 3.0
                }
                Divider {
                    translationY: 4.0
                }

                //This label holds the word Yorku
                Label {
                    id: yorku
                    text: " York U"
                    translationY: 0.0
                    translationX: 290.0
                    textFit.minFontSizeValue: 14.0
                    textStyle.color: Color.White
                }

                //This label holds the add button along with the touchablePane component defintion
                Label {
                    id: add
                    text: "Add"
                    objectName: "add"
                    property string removeGrade
                    property string removeCredit
                    property string cREDIT
                    property string gRADE
                    property string cour_name
                    property int kEY

                    signal courRemoved()
                    signal cREDChange()
                    signal gRADChange()

                    translationX: 640.0
                    translationY: 20.0
                    textStyle.color: Color.White
                    textFit.minFontSizeValue: 3.0
                    opacity: 0.8

                    onTouch: {
                        if (event.isDown()) {
                            setOpacity(1)
                        }

                        if (event.isUp()) {
                            setOpacity(0.8)
                            var newTab = courseTab.createObject()
                            main.add(newTab)
                            top.count = top.count + 1
                        }
                    }
                    attachedObjects: [
                        ComponentDefinition {
                            id: courseTab
                            property string testing

                            TouchablePane {
                                id: current
                                objectName: "current"
                                key: top.count

                                onGradesChanged: {
                                    add.gRADE = grades
                                    add.cREDIT = credits
                                    add.kEY = key
                                    add.cour_name = courseNames
                                    add.gRADChange()
                                }

                                onCreditsChanged: {
                                    add.cREDIT = credits
                                    add.gRADE = grades
                                    add.cREDChange()
                                }

                                onCourseRemoved: {
                                    add.removeCredit = visCredits;
                                    add.removeGrade = visGrade;
                                    add.kEY = key
                                    add.courRemoved()
                                }
                            }
                        }
                    ]
                    pivotX: -10.0
                }

                //This label holds the clear button and its associated system toast
                Label {
                    id: clear
                    objectName: "clear_Button"
                    text: "Clear"
                    translationY: 20
                    translationX: 10.0
                    textStyle.color: Color.White
                    textFit.minFontSizeValue: 3.0
                    opacity: 0.8

                    onTouch: {
                        if (event.isDown()) {
                            setOpacity(1)
                        }

                        if (event.isUp()) {
                            setOpacity(0.8)
                            cl.show()
                        }
                    }

                    attachedObjects: [
                        SystemToast {
                            id: cl
                            body: "Cleared All"
                        }
                    ]
                }

                Divider {
                    translationY: 85.0
                }
                Divider {
                    translationY: 86.0
                }
                Divider {
                    translationY: 87.0
                }
                Divider {
                    translationY: 89.0
                }
                Divider {
                    translationY: 90.0
                }
            }

            //This container holds the Credits and GPA related items and dividers
            Container {
                id: gpa_credits
                minWidth: 768
                minHeight: 90
                layout: DockLayout {
                }
                translationY: 310.0
                translationX: 0.0

                Divider {
                    translationY: 306
                }
                Divider {
                    translationY: 307
                }
                Divider {
                    translationY: 308
                }
                Divider {
                    translationY: 309
                }
                Divider {
                    translationY: 310
                }
                Divider {
                    translationY: 311
                }
                Divider {
                    translationY: 312
                }
                Divider {
                    translationY: 313
                }
                Divider {
                    translationY: 314
                }

                //This label holds the word GPA word
                Label {
                    text: "GPA: "
                    translationY: 10.0
                    translationX: 120.0
                    textFit.minFontSizeValue: 5.0
                }

                //This label holds the word Credits
                Label {
                    text: "Credits: "
                    translationY: 10
                    translationX: 450.0
                }

                Divider {
                    translationY: 65.0
                }
                Divider {
                    translationY: 66.0
                }
                Divider {
                    translationY: 67.0
                }
                Divider {
                    translationY: 68.0
                }
                Divider {
                    translationY: 69.0
                }

                //This sub-container holds the calculated GPA value
                Container {
                    id: gPPa
                    //background: Color.Red
                    layout: DockLayout {
                    }
                    translationY: 10.0
                    minHeight: 40
                    minWidth: 100
                    translationX: 230.0

                    //This label displays the calculated GPA value
                    Label {
                        id: gPa
                        objectName: "gPa"
                        textStyle.color: Color.Red
                        textStyle.fontWeight: FontWeight.W400
                        text: "0"
                    }
                }

                //The sub container holds the calculated number of credits
                Container {
                    id: cRRedits
                    //background: Color.Red
                    layout: DockLayout {
                    }
                    translationY: 10.0
                    minHeight: 40
                    minWidth: 100
                    translationX: 600.0

                    //This label displays the calculated number of credits
                    Label {
                        id: cRedits
                        objectName: "cRedits"
                        textStyle.color: Color.Red
                        textStyle.fontWeight: FontWeight.W400
                        text: "0"
                    }
                }
            }

        }

        //This container holds the scrollview that displays the added courses
        Container {
            translationY: 0

            //This scrollview holds the container that displays the added courses
            ScrollView {
                id: yep
                minWidth: 768
                scrollViewProperties.scrollMode: ScrollMode.Vertical

                //This container holds the added courses
                Container {
                    id: main
                    objectName: "mai"
                    layout: StackLayout {
                        orientation: LayoutOrientation.BottomToTop
                    }
                    background: Color.White
                }
            }
        }

        attachedObjects: [
            ComponentDefinition {
                id: old_stuff
                property int dits
                property string me
                property string ter
                
                Load {
                    id: old
                    credits : old_stuff.dits.toFixed(0)
                    courseNames : old_stuff.me.toString()
                    grades : old_stuff.ter.toString()
                    
                    onCreationCompleted: {
                        credits = old_stuff.dits.toFixed(0)
                        courseNames = old_stuff.me.toString()
                        grades = old_stuff.ter.toString()
                    }
                    
                    onCourseRemoved: {
                        add.removeCredit = visCredits;
                        add.removeGrade = visGrade;
                        add.kEY = key
                        add.courRemoved()
                    }

                }
            }
        ]

    }
}