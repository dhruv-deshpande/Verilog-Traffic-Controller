## Verilog Modified Traffic Controller

A 6-state finite state machine designed in Verilog to control a T-junction traffic intersection.

### 1. Junction Layout
<img width="627" height="340" alt="image" src="https://github.com/user-attachments/assets/2aba1607-3e38-494e-9a92-66955312b3a9" />

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
The following diagram illustrates the state transitions and hold conditions (denoted by `-` for the active-low/hold state).

<svg viewBox="0 0 780 580" xmlns="http://www.w3.org/2000/svg" width="780" height="580">
  <style>
    .state-green circle { fill: #1D9E75; stroke: #5DCAA5; stroke-width: 1.5; }
    .state-amber circle { fill: #BA7517; stroke: #EF9F27; stroke-width: 1.5; }
    .lm { fill: #fff; font-size: 15px; font-weight: 700; font-family: sans-serif; }
    .ln { fill: rgba(255,255,255,0.85); font-size: 11px; font-family: sans-serif; }
    .ls { fill: rgba(255,255,255,0.65); font-size: 10.5px; font-family: monospace; letter-spacing: 0.05em; }
    .tl { fill: #94a3b8; font-size: 11px; font-family: sans-serif; }
    .lg { fill: #5DCAA5; font-size: 11px; font-weight: 600; font-family: sans-serif; }
    .la { fill: #EF9F27; font-size: 11px; font-weight: 600; font-family: sans-serif; }
    .loop-green { stroke: #5DCAA5; stroke-width: 1.2; fill: none; }
    .loop-amber { stroke: #EF9F27; stroke-width: 1.2; fill: none; }
    .trans { stroke: #64748b; stroke-width: 1.2; fill: none; }
  </style>
  <defs>
    <marker id="ag" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#5DCAA5" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
    <marker id="aa" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#EF9F27" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
    <marker id="at" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#64748b" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
  </defs>

  <!-- background -->
  <rect width="780" height="580" fill="#0f1117" rx="12"/>

  <!-- title -->
  <text x="390" y="22" text-anchor="middle" font-size="12" fill="#475569" font-family="sans-serif" letter-spacing="0.1em">TRAFFIC LIGHT CONTROLLER — FSM</text>

  <!-- ── S1 self-loop + circle ── -->
  <path class="loop-green" d="M108 87 C96 50 164 50 152 87" marker-end="url(#ag)"/>
  <text class="lg" x="130" y="40" text-anchor="middle">~TMG</text>
  <g class="state-green">
    <circle cx="130" cy="150" r="65"/>
    <text class="lm" x="130" y="132" text-anchor="middle" dominant-baseline="central">S1</text>
    <text class="ln" x="130" y="152" text-anchor="middle" dominant-baseline="central">Top Main Green</text>
    <text class="ls" x="130" y="170" text-anchor="middle" dominant-baseline="central">G  R  G  R</text>
  </g>

  <!-- ── S2 self-loop + circle ── -->
  <path class="loop-amber" d="M368 87 C356 50 424 50 412 87" marker-end="url(#aa)"/>
  <text class="la" x="390" y="40" text-anchor="middle">~TY1</text>
  <g class="state-amber">
    <circle cx="390" cy="150" r="65"/>
    <text class="lm" x="390" y="132" text-anchor="middle" dominant-baseline="central">S2</text>
    <text class="ln" x="390" y="152" text-anchor="middle" dominant-baseline="central">Transition Y1</text>
    <text class="ls" x="390" y="170" text-anchor="middle" dominant-baseline="central">G  R  Y  R</text>
  </g>

  <!-- ── S3 self-loop + circle ── -->
  <path class="loop-green" d="M628 87 C616 50 684 50 672 87" marker-end="url(#ag)"/>
  <text class="lg" x="650" y="40" text-anchor="middle">~TTG</text>
  <g class="state-green">
    <circle cx="650" cy="150" r="65"/>
    <text class="lm" x="650" y="132" text-anchor="middle" dominant-baseline="central">S3</text>
    <text class="ln" x="650" y="152" text-anchor="middle" dominant-baseline="central">Top Turn Green</text>
    <text class="ls" x="650" y="170" text-anchor="middle" dominant-baseline="central">G  G  R  R</text>
  </g>

  <!-- ── S4 self-loop (right) + circle ── -->
  <path class="loop-amber" d="M713 422 C748 410 748 470 713 458" marker-end="url(#aa)"/>
  <text class="la" x="756" y="442" text-anchor="start">~TY2</text>
  <g class="state-amber">
    <circle cx="650" cy="440" r="65"/>
    <text class="lm" x="650" y="422" text-anchor="middle" dominant-baseline="central">S4</text>
    <text class="ln" x="650" y="442" text-anchor="middle" dominant-baseline="central">Transition Y2</text>
    <text class="ls" x="650" y="460" text-anchor="middle" dominant-baseline="central">Y  Y  R  R</text>
  </g>

  <!-- ── S5 self-loop (below) + circle ── -->
  <path class="loop-green" d="M368 503 C356 540 424 540 412 503" marker-end="url(#ag)"/>
  <text class="lg" x="390" y="554" text-anchor="middle">~TSG</text>
  <g class="state-green">
    <circle cx="390" cy="440" r="65"/>
    <text class="lm" x="390" y="422" text-anchor="middle" dominant-baseline="central">S5</text>
    <text class="ln" x="390" y="442" text-anchor="middle" dominant-baseline="central">Top Side Green</text>
    <text class="ls" x="390" y="460" text-anchor="middle" dominant-baseline="central">R  R  R  G</text>
  </g>

  <!-- ── S6 self-loop (below) + circle ── -->
  <path class="loop-amber" d="M108 503 C96 540 164 540 152 503" marker-end="url(#aa)"/>
  <text class="la" x="130" y="554" text-anchor="middle">~TY3</text>
  <g class="state-amber">
    <circle cx="130" cy="440" r="65"/>
    <text class="lm" x="130" y="422" text-anchor="middle" dominant-baseline="central">S6</text>
    <text class="ln" x="130" y="442" text-anchor="middle" dominant-baseline="central">Transition Y3</text>
    <text class="ls" x="130" y="460" text-anchor="middle" dominant-baseline="central">R  R  R  Y</text>
  </g>

  <!-- ── Transition arrows ── -->
  <line class="trans" x1="195" y1="150" x2="325" y2="150" marker-end="url(#at)"/>
  <text class="tl" x="260" y="140" text-anchor="middle">TMG</text>

  <line class="trans" x1="455" y1="150" x2="585" y2="150" marker-end="url(#at)"/>
  <text class="tl" x="520" y="140" text-anchor="middle">TY1</text>

  <line class="trans" x1="650" y1="215" x2="650" y2="375" marker-end="url(#at)"/>
  <text class="tl" x="662" y="295" text-anchor="start">TTG</text>

  <line class="trans" x1="585" y1="440" x2="455" y2="440" marker-end="url(#at)"/>
  <text class="tl" x="520" y="430" text-anchor="middle">TY2</text>

  <line class="trans" x1="325" y1="440" x2="195" y2="440" marker-end="url(#at)"/>
  <text class="tl" x="260" y="430" text-anchor="middle">TSG</text>

  <line class="trans" x1="130" y1="375" x2="130" y2="215" marker-end="url(#at)"/>
  <text class="tl" x="118" y="295" text-anchor="end">TY3</text>

  <!-- signal order hint -->
  <text font-size="10" fill="#334155" x="390" y="300" text-anchor="middle" font-family="sans-serif">Signal order: M1  MT  M2  S</text>
</svg>

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
