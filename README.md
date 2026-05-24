## Verilog Modified Traffic Controller

A 6-state finite state machine designed in Verilog to control a T-junction traffic intersection.

### 1. Junction Layout
<img width="727" height="340" alt="image" src="https://github.com/user-attachments/assets/2aba1607-3e38-494e-9a92-66955312b3a9" />

The intersection manages four distinct traffic paths:
* **M1:** Main Flow (Top lane, straight)
* **MT:** Main Turn (Top lane, turning right)
* **M2:** Main Bottom (Bottom lane, straight)
* **S:** Side Road (Right turn onto main)

### 2. State Transition Table
The FSM cycles through 6 distinct cases based on the timing triggers for main flows, turns, and side roads. 

| State | Main 1 (M1) | Main Turn (MT) | Main 2 (M2) | Side (S) | Next State Trigger |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **S1 (Case 1)** | **G** | R | **G** | R | `TMG` (Top Main Green) |
| **S2 (Case 2)** | **G** | R | Y | R | `TY1` (Transition Yellow 1) |
| **S3 (Case 3)** | **G** | **G** | R | R | `TTG` (Top Turn Green) |
| **S4 (Case 4)** | Y | Y | R | R | `TY2` (Transition Yellow 2) |
| **S5 (Case 5)** | R | R | R | **G** | `TSG` (Top Side Green) |
| **S6 (Case 6)** | R | R | R | Y | `TY3` (Transition Yellow 3) |

*(Note: G = Green, Y = Yellow, R = Red)*

### 3. FSM State Diagram
The following diagram illustrates the state transitions and hold conditions (denoted by `~` for the active-low/hold state).

<img width="859" height="667" alt="image" src="https://github.com/user-attachments/assets/dc5ca2c9-8ce3-48c5-8bc0-09e9747b047f" />

    S6 --> S6 : ~TY3
    S6 --> S1 : TY3
