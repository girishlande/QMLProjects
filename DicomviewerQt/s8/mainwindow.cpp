#include "mainwindow.h"
#include "dicominteractionstyle.h"
#include "modelinteractionstyle.h"

#include <qdebug.h>
#include <QTimer>
#include <QStringList>
#include <QGridLayout.h>
#include "QVTKWidget.h"
#include <QDir.h>
#include <QFileDialog.h>
#include <QComboBox.h>
#include <QSplitter.h>
#include <QPushButton>
#include <QBoxLayout.h>

#include <vtkPolyDataMapper.h>
#include <vtkRenderer.h>
#include <vtkRenderWindow.h>
#include <vtkSphereSource.h>
#include <vtkSmartPointer.h>
#include <vtkSTLReader.h>

#include <vtkSmartPointer.h>
#include <vtkObjectFactory.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkRenderer.h>
#include <vtkActor.h>
#include <vtkConeSource.h>
#include <vtkOBJReader.h>

// headers needed for this example
#include <vtkImageViewer2.h>
#include <vtkDICOMImageReader.h>
#include <vtkInteractorStyleImage.h>
#include <vtkActor2D.h>
#include <vtkTextProperty.h>
#include <vtkTextMapper.h>
#include <QStackedWidget.h>

// needed to easily convert int to std::string
#include <sstream>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    // Setup window and resize it
    ui->setupUi(this);
    this->resize(1002, 666);
    this->showMaximized();

    // Apply style sheet on it for Black theme appearance
    QFile file(":/stylesheets/style2.qss");
    file.open(QFile::ReadOnly);
    QString styleSheet = QLatin1String(file.readAll());
    this->setStyleSheet(styleSheet);

    // Create central widget
    centralwidget = new QWidget(this);
    centralwidget->setObjectName(QStringLiteral("centralwidget"));

    // Create layout for central widget
    vboxLayout = new QVBoxLayout(centralwidget);
    vboxLayout->setSpacing(1);
    vboxLayout->setObjectName(QStringLiteral("vboxLayout"));

    // ----------------------------------
    // Create VTK Widgets for each View
    // ----------------------------------
    view1 = new QVTKWidget(this);
    view2 = new QVTKWidget(this);
    view3 = new QVTKWidget(this);
    view4 = new QVTKWidget(this);

    // ---------------------------------
    // Create layout for main window
    // ---------------------------------
    //    _ _ _ _ _ _ _  _ _ _
    //                  |     |
    //    V1   |   v2   |     |
    //    _ _ _|_ _ _ _ |     |
    //         |        |     |
    //    V3   |   V4   |     |
    //    _ _ _ _ _ _ _ |_ _ _|
    //
    QVBoxLayout* tablayout = new QVBoxLayout();
    QPushButton* b1 = new QPushButton("Pelvic Plane",this);
    QPushButton* b2 = new QPushButton("Orientation",this);
    connect(b1,SIGNAL(clicked(bool)),this,SLOT(pelvic_plane()));
    connect(b2,SIGNAL(clicked(bool)),this,SLOT(orient_angle()));
    tablayout->addWidget(b1);
    tablayout->addWidget(b2);

    QWidget *firstPageWidget = new QWidget;
    QWidget *secondPageWidget = new QWidget;
    QWidget *thirdPageWidget = new QWidget;

    // Add different pages for each button
    QStackedWidget *stackedWidget = new QStackedWidget;
    stackedWidget->addWidget(firstPageWidget);
    stackedWidget->addWidget(secondPageWidget);
    stackedWidget->addWidget(thirdPageWidget);
    tablayout->addWidget(stackedWidget);

    QWidget *controls_widget = new QWidget;
    controls_widget->setLayout(tablayout);

    m_container_layout = new QGridLayout;
    m_container_layout->addWidget(view1,0,0,1,1);
    m_container_layout->addWidget(view2,0,1,1,1);
    m_container_layout->addWidget(view3,1,0,1,1);
    m_container_layout->addWidget(view4,1,1,1,1);
    QWidget *container = new QWidget;
    container->setLayout(m_container_layout);

    // -------------------------------------------------
    // Add splitter between VTK Views and field editor
    // -------------------------------------------------
    QSplitter *split2 = new QSplitter;
    split2->setOrientation(Qt::Horizontal);
    split2->addWidget(container);
    split2->addWidget(controls_widget);

    QList<int> sizes;
    sizes << 1600<<400;
    split2->setSizes(sizes);

    vboxLayout->addWidget(split2);

    this->setCentralWidget(centralwidget);

    // -----------------
    // VIEW 1, 2, 3, 4
    // -----------------
    DoView_1();
    DoView_2();
    DoView_3();
    DoView_4();
}

void MainWindow::DoView_1()
{
    vtkSmartPointer<vtkSphereSource> s1 =
            vtkSmartPointer<vtkSphereSource>::New();
    s1->Update();

    vtkSmartPointer<vtkPolyDataMapper> sm1 =
            vtkSmartPointer<vtkPolyDataMapper>::New();
    sm1->SetInputConnection(s1->GetOutputPort());
    vtkSmartPointer<vtkActor> sa1 =
            vtkSmartPointer<vtkActor>::New();
    sa1->SetMapper(sm1);
    vtkSmartPointer<vtkRenderer> r1 =
            vtkSmartPointer<vtkRenderer>::New();
    r1->AddActor(sa1);
    this->view1->GetRenderWindow()->AddRenderer(r1);
}

void MainWindow::DoView_2()
{
    vtkSmartPointer<vtkSphereSource> s1 =
            vtkSmartPointer<vtkSphereSource>::New();
    s1->Update();

    vtkSmartPointer<vtkPolyDataMapper> sm1 =
            vtkSmartPointer<vtkPolyDataMapper>::New();
    sm1->SetInputConnection(s1->GetOutputPort());
    vtkSmartPointer<vtkActor> sa1 =
            vtkSmartPointer<vtkActor>::New();
    sa1->SetMapper(sm1);
    vtkSmartPointer<vtkRenderer> r1 =
            vtkSmartPointer<vtkRenderer>::New();
    r1->AddActor(sa1);
    this->view2->GetRenderWindow()->AddRenderer(r1);

}

void MainWindow::DoView_3()
{
    vtkSmartPointer<vtkSphereSource> s2 =
            vtkSmartPointer<vtkSphereSource>::New();
    s2->Update();
    vtkSmartPointer<vtkPolyDataMapper> sm2 =
            vtkSmartPointer<vtkPolyDataMapper>::New();
    sm2->SetInputConnection(s2->GetOutputPort());
    vtkSmartPointer<vtkActor> sa2 =
            vtkSmartPointer<vtkActor>::New();
    sa2->SetMapper(sm2);
    vtkSmartPointer<vtkRenderer> r2 =
            vtkSmartPointer<vtkRenderer>::New();
    r2->AddActor(sa2);
    this->view3->GetRenderWindow()->AddRenderer(r2);
}

void MainWindow::DoView_4()
{
    std::string inputFilename = "D:\\Stryker\\Stldata\\pelvic_girdle_smooth.stl";
    vtkSmartPointer<vtkSTLReader> reader =
            vtkSmartPointer<vtkSTLReader>::New();
    reader->SetFileName(inputFilename.c_str());
    reader->Update();
    vtkSmartPointer<vtkPolyDataMapper> sm3 =
            vtkSmartPointer<vtkPolyDataMapper>::New();
    sm3->SetInputConnection(reader->GetOutputPort());
    vtkSmartPointer<vtkActor> sa3 =
            vtkSmartPointer<vtkActor>::New();
    sa3->SetMapper(sm3);
    vtkSmartPointer<vtkRenderer> r3 =
            vtkSmartPointer<vtkRenderer>::New();
    r3->AddActor(sa3);
    this->view4->GetRenderWindow()->AddRenderer(r3);

    vtkSmartPointer<vtkRenderWindowInteractor> renderWindowInteractor =
        vtkSmartPointer<vtkRenderWindowInteractor>::New();

    vtkSmartPointer<MouseInteractorStyle> style =
            vtkSmartPointer<MouseInteractorStyle>::New();
    renderWindowInteractor->SetInteractorStyle(style);
    style->initialise_counter();
    style->m_window = this;
    style->m_full_screen_mode = false;

    view4->GetRenderWindow()->SetInteractor(renderWindowInteractor);

    renderWindowInteractor->Start();

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_actionOpen_DICOM_file_triggered()
{
    // Browse for and open the file
    QDir dir;

    // Open the text data file
    QString fileName = QFileDialog::getOpenFileName(
                this,
                "Select DICOM file",
                "D:/brain1",
                "DICOM Files (*.dcm);;All Files (*.*)");

    if (fileName.isNull())
    {
        cerr << "Could not open file" << endl;
        return;
    }

    QFileInfo fileinfo(fileName);
    QDir dirname = fileinfo.absoluteDir();
    QString dirpath = dirname.absolutePath();
    dicom_dir_path = dirpath;

    QTimer::singleShot(100, this, SLOT(updateview_1()));
    QTimer::singleShot(200, this, SLOT(updateview_2()));
    QTimer::singleShot(300, this, SLOT(updateview_3()));
    QTimer::singleShot(400, this, SLOT(updateview_4()));
}

void MainWindow::updateview_1()
{
    current_view_index=1;
    UpdateViewForDICOM();
}

void MainWindow::updateview_2()
{
    current_view_index=2;
    UpdateViewForDICOM();
}

void MainWindow::updateview_3()
{
    current_view_index=3;
    UpdateViewForDICOM();
}

void MainWindow::updateview_4()
{
    check_and_import_stl();
    check_and_import_obj();
}

void MainWindow::check_and_import_stl()
{
    // Check if the current selected directory has .stl file in it
    // if yes then simply import it
    QStringList nameFilter("*.stl");
    QDir directory(dicom_dir_path);
    QStringList files = directory.entryList(nameFilter);
    int size = files.size();
    if (size>=1) {
        QString stl_path = files.at(0);
        QStringList mylist;
        mylist << dicom_dir_path << stl_path;
        QString filepath = mylist.join("/");
        qDebug() << "Import stl  : " << filepath;
        // Create STL reader
        vtkSmartPointer<vtkSTLReader> reader =
                vtkSmartPointer<vtkSTLReader>::New();
        reader->SetFileName(filepath.toLatin1());
        reader->Update();
        vtkSmartPointer<vtkPolyDataMapper> sm3 =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        sm3->SetInputConnection(reader->GetOutputPort());
        vtkSmartPointer<vtkActor> sa3 =
                vtkSmartPointer<vtkActor>::New();
        sa3->SetMapper(sm3);
        vtkSmartPointer<vtkRenderer> r3 =
                vtkSmartPointer<vtkRenderer>::New();
        r3->AddActor(sa3);
        view4->GetRenderWindow()->AddRenderer(r3);
    }

}


void MainWindow::check_and_import_obj()
{
    // Check if the current selected directory has .stl file in it
    // if yes then simply import it
    QStringList nameFilter("*.obj");
    QDir directory(dicom_dir_path);
    QStringList files = directory.entryList(nameFilter);
    int size = files.size();
    if (size>=1) {
        QString stl_path = files.at(0);
        QStringList mylist;
        mylist << dicom_dir_path << stl_path;
        QString filepath = mylist.join("/");
        // Create STL reader
        vtkSmartPointer<vtkOBJReader> reader =
            vtkSmartPointer<vtkOBJReader>::New();
        reader->SetFileName(filepath.toLatin1());
        reader->Update();
        vtkSmartPointer<vtkPolyDataMapper> sm3 =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        sm3->SetInputConnection(reader->GetOutputPort());
        vtkSmartPointer<vtkActor> sa3 =
                vtkSmartPointer<vtkActor>::New();
        sa3->SetMapper(sm3);
        vtkSmartPointer<vtkRenderer> r3 =
                vtkSmartPointer<vtkRenderer>::New();
        r3->AddActor(sa3);
        view4->GetRenderWindow()->AddRenderer(r3);
    }

}


void MainWindow::on_actionImport_STL_file_triggered()
{
    // Browse for and open the file
    QDir dir;

    // Open the text data file
    QString fileName = QFileDialog::getOpenFileName(
                this,
                "Select STL file",
                "D:/",
                "OBJ files(*.obj);;All Files (*.*)");  //"STL Files (*.stl);;

    if (fileName.isNull())
    {
        cerr << "Could not open file" << endl;
        return;
    }

     QFileInfo fileinfo(fileName);
     QString justname = fileinfo.fileName();
     QString ext=justname.split(".",QString::SkipEmptyParts).at(1);

     if (ext=="stl") {
         // Create STL reader
         vtkSmartPointer<vtkSTLReader> reader =
                 vtkSmartPointer<vtkSTLReader>::New();
         reader->SetFileName(fileName.toLatin1());
         reader->Update();


         vtkSmartPointer<vtkPolyDataMapper> sm3 =
                 vtkSmartPointer<vtkPolyDataMapper>::New();
         sm3->SetInputConnection(reader->GetOutputPort());
         vtkSmartPointer<vtkActor> sa3 =
                 vtkSmartPointer<vtkActor>::New();
         sa3->SetMapper(sm3);
         vtkSmartPointer<vtkRenderer> r3 =
                 vtkSmartPointer<vtkRenderer>::New();
         r3->AddActor(sa3);
         view4->GetRenderWindow()->AddRenderer(r3);
     } else if (ext=="obj") {
         // Create STL reader
         vtkSmartPointer<vtkOBJReader> reader =
                 vtkSmartPointer<vtkOBJReader>::New();
         reader->SetFileName(fileName.toLatin1());
         reader->Update();

         vtkSmartPointer<vtkPolyDataMapper> sm3 =
                 vtkSmartPointer<vtkPolyDataMapper>::New();
         sm3->SetInputConnection(reader->GetOutputPort());
         vtkSmartPointer<vtkActor> sa3 =
                 vtkSmartPointer<vtkActor>::New();
         sa3->SetMapper(sm3);
         vtkSmartPointer<vtkRenderer> r3 =
                 vtkSmartPointer<vtkRenderer>::New();
         r3->AddActor(sa3);
         view4->GetRenderWindow()->AddRenderer(r3);
     }

}

void MainWindow::on_actionExit_triggered()
{
    QApplication::quit();
}


void MainWindow::UpdateViewForDICOM()
{
    // Read all the DICOM files in the specified dir    ectory.
    vtkSmartPointer<vtkDICOMImageReader> reader =
        vtkSmartPointer<vtkDICOMImageReader>::New();
    reader->SetDirectoryName(dicom_dir_path.toLatin1());
    reader->Update();

    // Visualize
    vtkSmartPointer<vtkImageViewer2> imageViewer =
        vtkSmartPointer<vtkImageViewer2>::New();
    imageViewer->SetInputConnection(reader->GetOutputPort());
    if (current_view_index==1) {
        imageViewer->SetSliceOrientationToXY();
    } else if (current_view_index==2) {
        imageViewer->SetSliceOrientationToYZ();
    } else if (current_view_index==3) {
        imageViewer->SetSliceOrientationToXZ();
    }

    // slice status message
    vtkSmartPointer<vtkTextProperty> sliceTextProp = vtkSmartPointer<vtkTextProperty>::New();
    sliceTextProp->SetFontFamilyToCourier();
    sliceTextProp->SetFontSize(20);
    sliceTextProp->SetVerticalJustificationToBottom();
    sliceTextProp->SetJustificationToLeft();

    vtkSmartPointer<vtkTextMapper> sliceTextMapper = vtkSmartPointer<vtkTextMapper>::New();
    std::string msg = StatusMessage::Format(imageViewer->GetSliceMin(), imageViewer->GetSliceMax());
    sliceTextMapper->SetInput(msg.c_str());
    sliceTextMapper->SetTextProperty(sliceTextProp);

    vtkSmartPointer<vtkActor2D> sliceTextActor = vtkSmartPointer<vtkActor2D>::New();
    sliceTextActor->SetMapper(sliceTextMapper);
    sliceTextActor->SetPosition(15, 10);

    // usage hint message
    vtkSmartPointer<vtkTextProperty> usageTextProp = vtkSmartPointer<vtkTextProperty>::New();
    usageTextProp->SetFontFamilyToCourier();
    usageTextProp->SetFontSize(14);
    usageTextProp->SetVerticalJustificationToTop();
    usageTextProp->SetJustificationToLeft();

    vtkSmartPointer<vtkTextMapper> usageTextMapper = vtkSmartPointer<vtkTextMapper>::New();
    usageTextMapper->SetInput("- Slice with mouse wheel\n  \n- Zoom with pressed right\n  mouse button while dragging");
    usageTextMapper->SetTextProperty(usageTextProp);

    vtkSmartPointer<vtkActor2D> usageTextActor = vtkSmartPointer<vtkActor2D>::New();
    usageTextActor->SetMapper(usageTextMapper);
    usageTextActor->GetPositionCoordinate()->SetCoordinateSystemToNormalizedDisplay();
    usageTextActor->GetPositionCoordinate()->SetValue(0.05, 0.95);

    // create an interactor with our own style (inherit from vtkInteractorStyleImage)
    // in order to catch mousewheel and key events
    vtkSmartPointer<vtkRenderWindowInteractor> renderWindowInteractor =
        vtkSmartPointer<vtkRenderWindowInteractor>::New();

    vtkSmartPointer<myVtkInteractorStyleImage> myInteractorStyle =
        vtkSmartPointer<myVtkInteractorStyleImage>::New();

    // make imageviewer2 and sliceTextMapper visible to our interactorstyle
    // to enable slice status message updates when scrolling through the slices
    myInteractorStyle->SetImageViewer(imageViewer);
    myInteractorStyle->SetStatusMapper(sliceTextMapper);

    // make the interactor use our own interactorstyle
    // cause SetupInteractor() is defining it's own default interatorstyle
    // this must be called after SetupInteractor()
    renderWindowInteractor->SetInteractorStyle(myInteractorStyle);

    // add slice status message and usage hint message to the renderer
    imageViewer->GetRenderer()->AddActor2D(sliceTextActor);
    imageViewer->GetRenderer()->AddActor2D(usageTextActor);

    if (current_view_index==1) {
         imageViewer->SetRenderWindow(view1->GetRenderWindow());
         view1->GetRenderWindow()->SetInteractor(renderWindowInteractor);
    } else if (current_view_index==2) {
         imageViewer->SetRenderWindow(view2->GetRenderWindow());
         view2->GetRenderWindow()->SetInteractor(renderWindowInteractor);
    } else if (current_view_index==3) {
         imageViewer->SetRenderWindow(view3->GetRenderWindow());
         view3->GetRenderWindow()->SetInteractor(renderWindowInteractor);
    }

    // initialize rendering and interaction
    imageViewer->Render();
    imageViewer->GetRenderer()->ResetCamera();

    renderWindowInteractor->Start();
}

void MainWindow::FullScreen()
{
    m_container_layout->removeWidget(view1);
    m_container_layout->removeWidget(view2);
    m_container_layout->removeWidget(view3);
}

void MainWindow::QuadScreen()
{
    m_container_layout->addWidget(view1,0,0,1,1);
    m_container_layout->addWidget(view2,0,1,1,1);
    m_container_layout->addWidget(view3,1,0,1,1);
}


void MainWindow::pelvic_plane()
{
    m_container_layout->addWidget(view1,0,0,1,1);
    m_container_layout->addWidget(view2,0,1,1,1);
    m_container_layout->addWidget(view3,1,0,1,1);
}

void MainWindow::orient_angle()
{
    m_container_layout->removeWidget(view1);
    m_container_layout->removeWidget(view2);
    m_container_layout->removeWidget(view3);
}
