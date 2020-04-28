import QtQuick 2.0
import QtCharts 2.0

LineSeries {
    function addPoint(x,y) {
        append(x,y);
    }
}
