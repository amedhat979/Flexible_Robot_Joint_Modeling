# Flexible Robot Joint Modeling, Simulation, and Control
In this project, a two-mass, one-spring system is modeled and simulated in MATLAB/Simulink. In addition, the system is controlled via two methods:
1. PD Controller
2. State Feedback Control with LQR

Moreover, the detailed modeling steps, equations derivation, and results analysis are available in the pdf file: "Task Report".
## Required Toolboxes
1. Simulink 2018b or a newer version
2. Control System Toolbox
   
## Project Files
### 1. Model Simulation with no Control:
The project files in this folder model the plant response with no control as a response to an initial perturbation in the initial motor's position, where the response is naturally-damped due to both motor's and link's viscosities.
In the simulation file, the system is simulated for different values for the damping ratio (Zeta), and their response is analyzed and compared.

### 2. Model Simulation + PD Control:
In this folder, a PD controller is added to control the plant and drive it to a position of 7 m from its initial perturbation. The response is analyzed and a feedforward part is also added to improve the response.

### 3. Model Simulation + State Feedback LQR Control:
In this folder, another control method is used to achieve the same control goal.
## System Parameters
Within the SimulateModel.m file, all the model parameters could be adjusted, such as the motor mass m1, link mass m2, spring elasticity K, sytem initial conditions, and zeta, which value is then used to compute the damping coefficients b1 and b2. In addition, for the models with the control part, an additional parameter x_ref can be adjusted to set the goal position (setpoint) for the controller. Finally, also for the models with control, the control parameters could be tuned: Kp and Kd for PD controller, and values for Q and R to tune the LQR controller.

## Execution Guidelines
Each folder has 3 files: StatisticsFcn, SimulateModel, and the Simulink file: TaskSolution.

### 1. StatisticsFcn.m:
This is a function that gets called in the main SimulateModel.m to perform statistical analysis on the model response and compute: Final steady state value, %Overshoot/Undershoot, and Settling Time.

### 2. SimulateModel.m:
This is the main file that defines system parameters for Simulink model, simulates the Simulink model, and prints statistics and plots.

### 3. TaskSolution.slx:
This is the Simulink file containing the model. The system parameters are defines as variables so that it can be simulated using the SimulateModel.m file only. 

## How to Run the Program?
 1. Open the folder with the model of choice: model with no control, model with PD Controller, or model with State Feedback & LQR.
 2. Launch the corresponding Simulink model and the MATLAB script SimulateModel.m
 3. Adjust the model parameters in SimulateModel.m and run the script to view the results.
 4. The results are automoatically printed: response plots for x1 & x2 and statistics of response in MATLAB terminal.
