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

    onCreationCompleted: {
        Application.autoExit = false;
        Application.manualExit.connect(onManualExit);
    }

    function onManualExit() {
        // This must exit the application.
        top.done()
        Application.quit()
    }

    Menu.definition: MenuDefinition {
        id: swipeDown
        helpAction: HelpActionItem {
        }

        actions: [
            ActionItem {
                title: "Exit"
                onTriggered: {
                    Application.quit()
                }
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

}