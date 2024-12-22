
#include <stdio.h>
#include <time.h>
#include <svdpi.h>

#define BAUD_RATE 10000
#define NBIT 8
#define STOPBIT 1
#define NOPARITY 0
#define EVENPARITY 1
#define ODDPARITY 2
#define PARITY NOPARITY // Set to NOPARITY to disable parity functionality

// Global variable for simulated input from UVM
static int simulated_input = 1;

// DPI function to set the input bit from UVM
void set_input_bit(svBit value) {
    simulated_input = value & 0x1; // Only accept the LSB
    printf("Data input: %d - %c\n", value, (char)value);
}

// Function to simulate reading a single bit (from simulated_input)
int read_bit() {
    return simulated_input;
}

// Initialize timestamp and calculate ticks per second
int init_timestamp() {
    return CLOCKS_PER_SEC; // Number of clock ticks per second
}

// Wait for a specified number of ticks
static void wait_ticks(int ticks) {
    clock_t start_time = clock();
    while ((clock() - start_time) < ticks);
}

// Function to receive a complete data word with start, data, and stop bits
int receive_data(int ticksPerSec) {
    int ticksPerBit = ticksPerSec / BAUD_RATE;
    int ticksPerHalf = ticksPerBit / 2;
    int data = 0;
    int bitval, val;
    int i;

    // Wait for the start bit
    do {
        val = read_bit();
    } while (val != 0);

    // Confirm the start bit
    wait_ticks(ticksPerHalf);
    val = read_bit();
    if (val == 1) {
        printf("Error receiving the start bit\n");
        return -1;
    }

    // Read the data bits
    for (i = 0; i < NBIT; i++) {
        wait_ticks(ticksPerBit);
        bitval = read_bit();
        bitval = bitval << i; // Shift to left
        data = bitval | data;
    }

    // Skip parity calculation and verification (disabled)

    // Read stop bit(s)
    for (i = 0; i < STOPBIT; i++) {
        wait_ticks(ticksPerBit);
        val = read_bit();
        if (val == 0) {
            printf("Stop bit error\n");
        }
    }

    printf("Data output: %d - %c\n", data, (char)data);
    return data;
}



