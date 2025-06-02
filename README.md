# Flexible Robot Joint Modeling, Simulation, and Control
In this project, a two-mass, one-spring system is modeled and simulated in MATLAB/Simulink. In addition, the system is controlled via two methods:
1. PD Controller
2. State Feedback Control with LQR

Moreover, the detailed modeling steps, equations derivation, and results analysis are available in the pdf file: "Task Report".
## Project Files
### 1. Model Simulation with no Control:
The project files in this folder model the plant response with no control as a response to an initial perturbation in the initial motor's position, where the response is naturally-damped due to both motor's and link's viscosities.
In the simulation file, the system is simulated for different values for the damping ratio (Zeta), and their response is analyzed and compared.

### 2. Model Simulation + PD Control:
In this folder, a PD controller is added to control the plant and drive it to a position of 7 m from its initial perturbation. The response is analyzed and a feedforward part is also added to improve the response.

### 3. Model Simulation + State Feedback LQR Control:
In this folder, another control method is used to achieve the same control goal.

## Execution Guidelines
Each folder has 3 files: StatisticsFcn, SimulateModel, and the Simulink file: TaskSolution.

### 1. StatisticsFcn.m:
This is a function that gets called in the main SimulateModel.m to perform statistical analysis on the model response and compute: Final steady state value, %Overshoot/Undershoot, and Settling Time.

### 2. SimulateModel.m:
This is the main file that defines system parameters for Simulink model, simulates the Simulink model, and prints statistics and plots.

### 3. TaskSolution.slx:
This is the Simulink file containing the model. The system parameters are defines as variables so that it can be simulated using the SimulateModel.m file only. 
