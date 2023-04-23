import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.OverlaySheet {
    id: addEditSheet

    property string mode: "add"

    property int index: -1
    property alias name: nameField.text
    property alias description: descriptionField.text
    property alias kdate: dateField.text

    signal added (string name, string description, var kdate)
    signal edited(int index, string name, string description, var kdate)
    signal removed(int index)

    header: Kirigami.Heading {
        text: mode === "add" 
            ? i18nc("@title:window", "Add kountdown") 
            : i18nc("@title:window", "Edit kountdown")
    }
    Kirigami.FormLayout {
        Controls.TextField {
            id: nameField
            Kirigami.FormData.label: i18nc("@label:textbox", "Name:")
            placeholderText: i18n("Event name (required)")
            onAccepted: descriptionField.forceActiveFocus()
        }
        Controls.TextField {
            id: descriptionField
            Kirigami.FormData.label: i18nc("@label:textbox", "Description:")
            placeholderText: i18n("Optional")
            onAccepted: dateField.forceActiveFocus()
        }
        Controls.TextField {
            id: dateField
            Kirigami.FormData.label: i18nc("@label:textbox", "Date:")
            inputMask: "0000-00-00"
            placeholderText: i18n("YYYY-MM-DD")
        }
        Controls.Button {
            id: deleteButton
            Layout.fillWidth: true
            text: i18nc("@action:button", "Delete")
            visible: mode === "edit"
            onClicked: {
                addEditSheet.removed(addEditSheet.index)
                close();
            }
        }
        Controls.Button {
            id: doneButton
            Layout.fillWidth: true
            text: i18nc("@action:button", "Done")
            enabled: nameField.text.length > 0
            onClicked: {
                if(mode === "add") {
                    addEditSheet.added(
                        nameField.text,
                        descriptionField.text,
                        dateField.text
                    );
                }
                else {
                    addEditSheet.edited(
                        index,
                        nameField.text,
                        descriptionField.text,
                        dateField.text
                    );
                }
                close();
            }
        }
    }
}
