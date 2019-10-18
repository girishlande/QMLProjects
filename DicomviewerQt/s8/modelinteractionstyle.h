#ifndef MODELINTERACTIONSTYLE_H
#define MODELINTERACTIONSTYLE_H
#include <vtkSmartPointer.h>
#include <vtkRendererCollection.h>
#include <vtkWorldPointPicker.h>
#include <vtkSphereSource.h>
#include <vtkPolyDataMapper.h>
#include <vtkRenderer.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkActor.h>
#include <vtkInteractorStyleTrackballCamera.h>
#include <vtkObjectFactory.h>
#include <vtkProperty.h>
#include <vtkSTLReader.h>
#include <vtkPlaneSource.h>
#include <vtkMath.h>
#include <vtkRegularPolygonSource.h>

#include "mainwindow.h"

#define SIDES 50
#define PLANE_RADIUS 150

class MainWindow;

// Define interaction style
class MouseInteractorStyle : public vtkInteractorStyleTrackballCamera
{
public:
    static MouseInteractorStyle* New();
    vtkTypeMacro(MouseInteractorStyle, vtkInteractorStyleTrackballCamera)

    virtual void OnLeftButtonDown()
    {
        // Girish : Check for double click
        bool is_double_click = check_and_process_double_click();
        if (is_double_click) return;

        if (this->Interactor->GetControlKey()) {
            if (counter >= 4) {
                // Create a plane
                vtkInteractorStyleTrackballCamera::OnLeftButtonDown();
                return;
            }
            std::cout << "Picking pixel: " << this->Interactor->GetEventPosition()[0] << " " << this->Interactor->GetEventPosition()[1] << std::endl;
            this->Interactor->GetPicker()->Pick(this->Interactor->GetEventPosition()[0],
                    this->Interactor->GetEventPosition()[1],
                    0,  // always zero.
                    this->Interactor->GetRenderWindow()->GetRenderers()->GetFirstRenderer());
            double picked[3];
            this->Interactor->GetPicker()->GetPickPosition(picked);
            std::cout << "Picked value: " << picked[0] << " " << picked[1] << " " << picked[2] << std::endl;

            // Forward events
            pick_position[0] = picked[0];
            pick_position[1] = picked[1];
            pick_position[2] = picked[2];

            AddMarker();

            counter++;
            if (counter == 4) {
                // Create a plane
                CreateLargePlane();
                CreatePlaneX();
                CreatePlaneY();
            }
        }

        vtkInteractorStyleTrackballCamera::OnLeftButtonDown();
    }

    void AddMarker()
    {
        vtkSmartPointer<vtkSphereSource> sphereSource =
                vtkSmartPointer<vtkSphereSource>::New();
        sphereSource->SetRadius(3);
        sphereSource->SetPhiResolution(50);
        sphereSource->SetThetaResolution(50);

        points->InsertNextPoint(pick_position);
        sphereSource->SetCenter(pick_position[0], pick_position[1], pick_position[2]);
        sphereSource->Update();

        // Create a mapper and actor
        vtkSmartPointer<vtkPolyDataMapper> mapper =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        mapper->SetInputConnection(sphereSource->GetOutputPort());
        vtkSmartPointer<vtkActor> actor =
                vtkSmartPointer<vtkActor>::New();
        actor->GetProperty()->SetColor(1, 0, 0);
        actor->SetMapper(mapper);

        // Add the actor to the scene
        this->Interactor->GetRenderWindow()->GetRenderers()->GetFirstRenderer()->AddActor(actor);
    }

    void CreateLargePlane()
    {
        // Read points from array
        double A[3], B[3], C[3], D[4];
        double AB[3], BC[3];
        points->GetPoint(0, A);
        points->GetPoint(1, B);
        points->GetPoint(2, C);
        points->GetPoint(3, D);
        vtkMath::Subtract(A, B, AB);
        vtkMath::Subtract(B, C, BC);
        vtkMath::Cross(AB, BC, N1);

        // Calculate center of plane
        M[0] = (A[0] + B[0] + C[0] + D[0]) / 4;
        M[1] = (A[1] + B[1] + C[1] + D[1]) / 4;
        M[2] = (A[2] + B[2] + C[2] + D[2]) / 4;

        vtkSmartPointer<vtkRegularPolygonSource> polygonSource =
                vtkSmartPointer<vtkRegularPolygonSource>::New();

        //polygonSource->GeneratePolygonOff();
        polygonSource->SetNumberOfSides(SIDES);
        polygonSource->SetRadius(PLANE_RADIUS);
        polygonSource->SetCenter(M);
        polygonSource->SetNormal(N1);
        polygonSource->Update();

        vtkSmartPointer<vtkPolyDataMapper> mapper =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        mapper->SetInputConnection(polygonSource->GetOutputPort());
        vtkSmartPointer<vtkActor> actor =
                vtkSmartPointer<vtkActor>::New();
        actor->SetMapper(mapper);
        actor->GetProperty()->SetColor(70.0 / 255, 130.0 / 255, 180.0 / 255);

        actor->GetProperty()->SetOpacity(0.5);
        // Add the actor to the scene
        this->Interactor->GetRenderWindow()->GetRenderers()->GetFirstRenderer()->AddActor(actor);
    }

    void CreatePlaneX()
    {
        vtkMath::Perpendiculars(N1, N2, NULL, 0);

        vtkSmartPointer<vtkRegularPolygonSource> polygonSource =
                vtkSmartPointer<vtkRegularPolygonSource>::New();

        //polygonSource->GeneratePolygonOff();
        polygonSource->SetNumberOfSides(SIDES);
        polygonSource->SetRadius(PLANE_RADIUS);
        polygonSource->SetCenter(M);
        polygonSource->SetNormal(N2);
        polygonSource->Update();

        vtkSmartPointer<vtkPolyDataMapper> mapper =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        mapper->SetInputConnection(polygonSource->GetOutputPort());
        vtkSmartPointer<vtkActor> actor =
                vtkSmartPointer<vtkActor>::New();
        actor->SetMapper(mapper);
        actor->GetProperty()->SetColor(70.0 / 255, 130.0 / 255, 180.0 / 255);

        actor->GetProperty()->SetOpacity(0.5);
        // Add the actor to the scene
        this->Interactor->GetRenderWindow()->GetRenderers()->GetFirstRenderer()->AddActor(actor);
    }

    void CreatePlaneY()
    {
        vtkMath::Cross(N1, N2, N3);

        vtkSmartPointer<vtkRegularPolygonSource> polygonSource =
                vtkSmartPointer<vtkRegularPolygonSource>::New();

        //polygonSource->GeneratePolygonOff();
        polygonSource->SetNumberOfSides(SIDES);
        polygonSource->SetRadius(PLANE_RADIUS);
        polygonSource->SetCenter(M);
        polygonSource->SetNormal(N3);
        polygonSource->Update();

        vtkSmartPointer<vtkPolyDataMapper> mapper =
                vtkSmartPointer<vtkPolyDataMapper>::New();
        mapper->SetInputConnection(polygonSource->GetOutputPort());
        vtkSmartPointer<vtkActor> actor =
                vtkSmartPointer<vtkActor>::New();
        actor->SetMapper(mapper);
        actor->GetProperty()->SetColor(70.0 / 255, 130.0 / 255, 180.0 / 255);

        actor->GetProperty()->SetOpacity(0.5);
        // Add the actor to the scene
        this->Interactor->GetRenderWindow()->GetRenderers()->GetFirstRenderer()->AddActor(actor);
    }

    void initialise_counter() {
        counter = 0;
        points = vtkSmartPointer<vtkPoints>::New();
    }

    // ------------------------------------------------------------------
    // Function to check if user has done double click in model window
    // If Yes then Do full screen or vice versa.
    // ------------------------------------------------------------------
    bool check_and_process_double_click()
    {
        bool found = false;
        // Record current time
        std::clock_t start;
        start = std::clock();
        timestamp1[time_counter1] = start;
        time_counter1 = (time_counter1 + 1) % 2;
        if (timer_flag1 == 1) {
            // Get previous time stamp and compare with current
            double prev = timestamp1[time_counter1];
            /* Your algorithm here */
            double duration = (start - prev) / (double)CLOCKS_PER_SEC;
            if (duration <= 0.20) {
                //HWND child_handle = hwndChild[3];
                //CResizeControl::ZOOMWindow(child_handle);
                found = true;

                // Call actual resize of window after timer event. This is done to
                // prevent system from twiddling the model
                if (m_full_screen_mode) {
                    m_window->QuadScreen();
                    m_full_screen_mode=false;
                } else {
                    m_full_screen_mode = true;
                    m_window->FullScreen();
                }
            }
        }
        else {
            timer_flag1 = 1;
        }
        return found;
    }

    double pick_position[3];
    int counter;
    vtkSmartPointer<vtkPoints> points;

    // Define center point of plane
    double M[3];

    // Define Normal vectors of planes
    double N1[3];
    double N2[3];
    double N3[3];


    int time_counter1 = 0;
    int timer_flag1 = false;
    double timestamp1[2];

    MainWindow* m_window;
    bool m_full_screen_mode;
};
vtkStandardNewMacro(MouseInteractorStyle)

#endif // MODELINTERACTIONSTYLE_H
