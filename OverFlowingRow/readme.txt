This project demonstrates how you can dynamically decide visibility of controls based on available width and so that 
controls don't overlap on each other or get trimmed. 
So there are 2 buttons which get hidden when window is resized to smaller width. Controls appear and disappear based on the width
of the window 

This also uses logic to stop flickering of window when resizing. 
It makes use of following call 
QGuiApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);