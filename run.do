#do {C:\questasim64_10.7c\examples\run.do}


quit -sim

# Create the working library
vlib work
vmap work work

# Compile Verilog and SystemVerilog files
vlog -work work "C:/questasim64_10.7c/examples/data_sampling.v"
vlog -work work "C:/questasim64_10.7c/examples/deserializer.v"
vlog -work work "C:/questasim64_10.7c/examples/edge_bit_counter.v"
vlog -work work "C:/questasim64_10.7c/examples/par_chk.v"
vlog -work work "C:/questasim64_10.7c/examples/stp_chk.v"
vlog -work work "C:/questasim64_10.7c/examples/strt_chk.v"
vlog -work work "C:/questasim64_10.7c/examples/UART_RX.v"
vlog -work work "C:/questasim64_10.7c/examples/uart_rx_fsm.v"
vlog -work work "C:/questasim64_10.7c/examples/mux.v"
vlog -work work "C:/questasim64_10.7c/examples/parity_calc.v"
vlog -work work "C:/questasim64_10.7c/examples/Serializer.v"
vlog -work work "C:/questasim64_10.7c/examples/UART_TX.v"
vlog -work work "C:/questasim64_10.7c/examples/uart_tx_fsm.v"
vlog -work work "C:/questasim64_10.7c/examples/Async_fifo.v"
vlog -work work "C:/questasim64_10.7c/examples/BIT_SYNC.v"
vlog -work work "C:/questasim64_10.7c/examples/fifo_mem.v"
vlog -work work "C:/questasim64_10.7c/examples/fifo_rd.v"
vlog -work work "C:/questasim64_10.7c/examples/fifo_wr.v"
vlog -work work "C:/questasim64_10.7c/examples/UART.v"
vlog -work work "C:/questasim64_10.7c/examples/UVM_UART_Interface.sv"
vlog -work work "C:/questasim64_10.7c/examples/UART_PKG.sv"
vlog -dpiheader dpiheader.h -work work "C:/questasim64_10.7c/examples/UART_Top_TestBench.sv"

# Run simulation, linking the precompiled DPI library
g++ -shared -o your_library.dll DPI_XX.c -I"C:\questasim64_10.7c\include" -L"C:\Program Files\Questa Sim-64 10.7c\lib" -lmtipli




vsim UART_TestBench

# Load waveform configuration
do wave.do
