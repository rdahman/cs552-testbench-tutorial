# CS 552 Verilog Testbench Tutorial
This document will detail all of the steps of writing and simulating a testbench in Modelsim. This assumes that you have already completed the Modelsim setup tutorial, [which can be found here](https://github.com/kyle-p-may/cs552-modelsim-tutorial).

## Creating a testbench
We have provided a 2-to-4 line binary decoder (decoder24.v), but we are not sure if it works correctly. To test the module, we'll create a testbench that lets us drive all combinations of the inputs to the module, and see what it outputs.

Create a new file in this directory, called `decoder24_bench.v`. As with all other Verilog designs, we will start by creating a new module and giving it a name.

    module decoder24_bench();

Because we will be driving values into the decoder, and reading values out of the decoder, we'll want to create some wires to do so.

    reg  [1:0] in_stim;    // two bit vector
    wire [3:0] out_stim;   // four bit vector

Note that we are using the type `reg` for the `in_stim` signals. This is because we will be driving values directly to these signals, which we cannot do with the `wire` type. In most other cases with structural and RTL Verilog, you will not be using the `reg` type.

Next, we'll want to instantiate the decoder. Similar to C and Java, we can create an instance of our module by typing the name of the module, and then giving it a name of our own.

    decoder24 dut( .in(in_stim), .out(out_stim) );

The dot-name syntax here means that the decoder's port `in` is assigned to the local signal `in_stim`.

Now, we want to assign some values to the `in_stim` signal. We can do this with an `initial` block.

    initial begin
        in_stim = 2'b00;    // in_stim = 00
        #10;                // wait 10 time units
        in_stim = 2'b01;    // in_stim = 01
        #10;                // wait 10 time units
        in_stim = 2'b10;    // repeat for all combinations
        #10;
        in_stim = 2'b11;
        #10;
    end

Now that we have assigned all of the input values that we want to test, we should read the outputs and compare them to their expected values. We can do this with another `initial` block.

    initial begin
        #5;         // wait half of input period before reading output

        if(out_stim !== 4'b0001) $display("error, check in = 2'b00");    // if mismatch, report to user
        #10;
        if(out_stim !== 4'b0010) $display("error, check in = 2'b01");    // repeat for all inputs
        #10;
        if(out_stim !== 4'b0100) $display("error, check in = 2'b10");
        #10;
        if(out_stim !== 4'b1000) $display("error, check in = 2'b11");
        #10;

        $finish;    // this tells the simulator to stop
    end

Finally, close the module.

    endmodule

Now, open Modelsim, compile both files `decoder24.v` and `decoder24_bench.v`, and simulate the testbench. When the simulator opens, highlight both of the `in_stim` and `out_stim` signals, right click, and select Add Wave:

![Add Wave Figure](https://github.com/dahmanrb/cs552-testbench-tutorial/blob/master/figures/add_wave.png)

Now the waveform viewer will appear. Run the testbench by selecting Run All near the top of the simulator (you can also type `run -all` into the command line):

![Run All Figure](https://github.com/dahmanrb/cs552-testbench-tutorial/blob/master/figures/run_all.png)

Vsim will ask you if you want to close the simulator, because it reached a `$finish` command. However, we want to continue to view the console output and the waveform, so you should select No:

![Finish Vsim Figure](https://github.com/dahmanrb/cs552-testbench-tutorial/blob/master/figures/finish_vsim.png)

Now take a look at the console. You'll notice there are a few errors being asserted, and you can verify this by looking at the waveform viewer to see which outputs are wrong. Try to find the cause of the issue in the `decoder24` module, then re-simulate.

## Further Practice Writing Testbenches

Now that you know how to write a testbench from the provided example for the decoder, write a testbench for the module defined in `foo.v`. In the source file, there is a truth table that is supposed to  describe the operation of the module. The goal is to determine which inputs cause the module to fail.
