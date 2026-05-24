## Verilog Modified Traffic Controller

A 6-state finite state machine designed in Verilog to control a T-junction traffic intersection.

### Design Specifications
* **Architecture:** 6-State Moore Finite State Machine (FSM).
* **State Encoding:** 3-bit sequential binary encoding to map states $S1$ through $S6$.
* **Reset Condition:** Asynchronous, active-high reset (`rst`). Forces the intersection into a safe default state ($S1$: Main Flow Green, all others Red) upon system initialization.
* **Clocking:** Fully synchronous state transitions triggered on the positive edge of the system clock.

### Junction Layout
<img width="627" height="340" alt="image" src="https://github.com/user-attachments/assets/2aba1607-3e38-494e-9a92-66955312b3a9" />

The intersection manages four distinct traffic paths:
* **M1:** Main Flow (Top lane, straight)
* **MT:** Main Turn (Top lane, turning right)
* **M2:** Main Bottom (Bottom lane, straight)
* **S:** Side Road (Right turn onto main)

### State Transition Table
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

### FSM State Diagram
The following diagram illustrates the state transitions and hold conditions (denoted by `~` for the active-low/hold state).

<img width="659" height="467" alt="image" src="https://github.com/user-attachments/assets/dc5ca2c9-8ce3-48c5-8bc0-09e9747b047f" />

### Testbench Console Output

The FSM logic was verified using Icarus Verilog. The `$monitor` output below tracks the binary state of each traffic light (where `001` = Green, `010` = Yellow, `100` = Red) across the simulated time steps.

```text
[2026-05-22 13:09:42 UTC] iverilog '-Wall' '-g2012' design.sv testbench.sv
Time=0 | rst=0 | M1=xxx | MT=xxx | M2=xxx | S=xxx
Time=500000000000 | rst=0 | M1=001 | MT=100 | M2=001 | S=100
Time=1000000000000 | rst=1 | M1=001 | MT=100 | M2=001 | S=100
Time=2000000000000 | rst=0 | M1=001 | MT=100 | M2=001 | S=100
Time=2250000000000 | rst=0 | M1=001 | MT=100 | M2=010 | S=100
Time=2850000000000 | rst=0 | M1=001 | MT=001 | M2=100 | S=100
Time=4950000000000 | rst=0 | M1=010 | MT=010 | M2=100 | S=100
Time=5550000000000 | rst=0 | M1=100 | MT=100 | M2=100 | S=001
Time=7650000000000 | rst=0 | M1=100 | MT=100 | M2=100 | S=010
Time=8250000000000 | rst=0 | M1=001 | MT=100 | M2=001 | S=100
testbench.sv:38: $finish called at 202000000000000 (1ps)
Done
```
