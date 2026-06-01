import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 520
    title: "计算器"
    color: "#1a1a1a"

    property string display: "0"
    property string expression: ""
    property real lastNumber: 0
    property string lastOperator: ""
    property bool isNewInput: true
    property bool hasError: false

    function appendDigit(digit) {
        if (hasError) { clear(); return; }
        if (isNewInput) {
            display = digit;
            isNewInput = false;
        } else {
            if (display === "0" && digit !== ".") {
                display = digit;
            } else {
                display += digit;
            }
        }
    }

    function setOperator(op) {
        if (hasError) return;
        if (lastOperator !== "" && !isNewInput) calculate();
        lastNumber = display;
        lastOperator = op;
        expression = display + " " + op;
        isNewInput = true;
    }

    function calculate() {
        if (lastOperator === "" || hasError) return;
        var current = parseFloat(display);
        var result = 0;
        switch(lastOperator) {
            case "+": result = lastNumber + current; break;
            case "-": result = lastNumber - current; break;
            case "×": result = lastNumber * current; break;
            case "÷":
                if (current === 0) {
                    hasError = true;
                    display = "Error";
                    expression = "";
                    lastOperator = "";
                    isNewInput = true;
                    return;
                }
                result = lastNumber / current;
                break;
        }
        display = (Number.isInteger(result) ? result : result.toFixed(8).replace(/\.?0+$/, "")).toString();
        expression = lastNumber + " " + lastOperator + " " + current + " =";
        lastOperator = "";
        isNewInput = true;
    }

    function clear() {
        display = "0";
        expression = "";
        lastNumber = 0;
        lastOperator = "";
        isNewInput = true;
        hasError = false;
    }

    function toggleSign() {
        if (display !== "0") {
            display = display.startsWith("-") ? display.slice(1) : "-" + display;
        }
    }

    function percentage() {
        display = (parseFloat(display) / 100).toString();
        isNewInput = true;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8

        Item { Layout.preferredHeight: 10 }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#2a2a2a"
            radius: 12
            Column {
                anchors { right: parent.right; rightMargin: 20; verticalCenter: parent.verticalCenter }
                Text { text: expression; color: "#888888"; font.pixelSize: 16; anchors.right: parent.right }
                Text { text: display; color: "#ffffff"; font.pixelSize: 48; font.bold: true; anchors.right: parent.right }
            }
        }

        GridLayout {
            Layout.fillWidth: true; Layout.fillHeight: true
            rows: 5; columns: 4
            columnSpacing: 8; rowSpacing: 8

            // 第一行
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#a5a5a5"; radius: width / 2
                Text { anchors.centerIn: parent; text: "AC"; color: "#000000"; font.pixelSize: 24; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.clear() }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#a5a5a5"; radius: width / 2
                Text { anchors.centerIn: parent; text: "±"; color: "#000000"; font.pixelSize: 24; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.toggleSign() }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#a5a5a5"; radius: width / 2
                Text { anchors.centerIn: parent; text: "%"; color: "#000000"; font.pixelSize: 24; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.percentage() }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#ff9500"; radius: width / 2
                Text { anchors.centerIn: parent; text: "÷"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.setOperator("÷") }
            }

            // 第二行
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "7"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("7") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "8"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("8") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "9"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("9") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#ff9500"; radius: width / 2
                Text { anchors.centerIn: parent; text: "×"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.setOperator("×") }
            }

            // 第三行
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "4"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("4") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "5"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("5") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "6"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("6") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#ff9500"; radius: width / 2
                Text { anchors.centerIn: parent; text: "-"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.setOperator("-") }
            }

            // 第四行
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "1"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("1") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "2"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("2") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "3"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("3") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#ff9500"; radius: width / 2
                Text { anchors.centerIn: parent; text: "+"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.setOperator("+") }
            }

            // 第五行
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.columnSpan: 2
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "0"; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit("0") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#505050"; radius: width / 2
                Text { anchors.centerIn: parent; text: "."; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.appendDigit(".") }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true
                color: "#ff9500"; radius: width / 2
                Text { anchors.centerIn: parent; text: "="; color: "#ffffff"; font.pixelSize: 28; font.bold: true }
                MouseArea { anchors.fill: parent; onClicked: root.calculate() }
            }
        }

        Item { Layout.preferredHeight: 5 }
    }
}
