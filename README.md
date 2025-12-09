# DIGITAL-FILTER-DESIGN

*COMPANY*: CODTECH IT SOLUTIONS

*NAME*: HUSNA FIRDOS

*INTERN ID*: CT04DR1337

*DOMAIN*: VLSI

*DURATION*: 4 WEEKS

*MENTOR*:  NEELA SANTHOSH KUMAR

## Description:-
### Software used for Implementation:
Design and simulation were complete written in Visual studio code with Icarus Verilog (iverilog) as compiler and simulator. This was compiled with the FIR filter Verilog module and testbench using:

         code: iverilog -o digital_fir_flt_tb.vvp digital_fir_flt_tb.v digital_fir_flt.v
         
This command will compile the design file and the testbench into one executable simulation. The following was then used to launch the simulation:

         code: vvp digital_fir_flt_tb.vvp
         
The terminal had sample-by-sample filtering results that were able to clearly indicate the difference in the Low-Pass filtering response and the High-Pass filtering response.

### GTKWAVE - Waveform Simulator:
The transitions of the signal in the filter were analyzed using GTKWave by simply opening the VCD file created during the simulation. Using the command:

          code: gtkwave digital_fir_flt_tb.vcd
          
the waveform viewer gave an in-depth representation of the progression of the input samples through the shift-register stages, the multiplication of the input samples with the FIR coefficients, and the development of the accumulated result on the individual clock cycle. The waveform indicated the variation in the output response on changing the filter mode between the low-pass and high-pass operation and also the gradual smoothing character in the low-pass mode and the sharp transient character in the high-pass mode. The behavior of the waveforms was found to be close to the available numerical values in the terminal, indicating that the digital FIR filter design was functioning correctly, using the right coefficient, and was functional.

### Behavioural & Testbench :
The FIR filter is also realized by a behavioral Verilog implementation, based on a clock-based sample shift register:
 
    code: always @(posedge clk or posedge reset)
 
The input sample is picked up, and multiplied with prestanding FIR coefficients, followed by an 8 stage delay register.
The coefficients vectors of Low-Pass and High-Pass filters are internally stored and only one signal mode is used to control the filter mode. The use of a coefficient set is determined by a conditional operator:
 
    code: mult[i] = x_reg[i] * (mode ? hp[i] : lp[i]);
 
The testbench will be fed the clock, reset, and input sample sequence and mode change, and will display filtered output in real-time with:

    code: $display("t=%0t mode=%0d x_in=%d y_out=%d", $time, mode, x_in, y_out);

It is then not hard to visualize the behavior of output as new samples pass the filter and the effect of switching between LPF and HPF on the waveform. The following was used to print a blank line between LPF and HPF results: 

    code: $display("");

## Conclusion:

Digital FIR Filter was developed successfully, simulated and proved. The functionality of the Low-Pass and High-Pass responses was well substantiated by the terminal results and the output ofGTKWave. The operations of sample shift, multiplication of coefficients, accumulation and scaling logic worked as anticipated. The numerical and waveform results were found to be as expected of a FIR, thereby showing a valid implementation with no timing or arithmetic problems.
The implementation of programmable FIR filtering in Verilog and a structured testbench that can check the behavior of signal processing cycles cycle-by-cycle are both cleanly implemented in the work.

# OUTPUT 

#### GTKWAVE:

<img width="1496" height="946" alt="Image" src="https://github.com/user-attachments/assets/3d31eddb-f5e2-445e-801d-5c3697fb07ec" />

#### VS TERMINAL:

<img width="1282" height="831" alt="Image" src="https://github.com/user-attachments/assets/d9ab2dec-53cd-4417-ad33-35ce8f9265f4" />
