this project will show use of TextMetrics which returns us width of text (in pixels) for given font family and size.
this is useful because you can runtime decide size of element based on the text width. Sometime because of translation of label text for controls such as buttons, column names you can overlap controls on each other. To avoid this we can give width to controls using textmetrics and this will avoid controls getting overlapped on each other. 

In this project, there is row of 3 buttons and there is Menu in same row. 
you can edit label of buttons using text input. As more text is appended and button labels grow.
When row size increases more than parent window size then there is overflow. and when this overflow happens we hide buttons
and add corresponding menuitem in Menus. 

