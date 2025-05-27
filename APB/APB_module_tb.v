`timescale 1ns/1ps

module tb_noWait_APB_slave;

    // Parameters
    localparam ADDRESS_WIDTH = 5;
    localparam DATA_WIDTH = 8;

    // Inputs
    reg PCLK;
    reg PRESETn;
    reg PSEL;
    reg PENABLE;
    reg [ADDRESS_WIDTH-1:0] PADDR;
    reg PWRITE;
    reg [DATA_WIDTH-1:0] PWDATA;

    // Outputs
    wire [DATA_WIDTH-1:0] PRDATA;
    wire PREADY;
    wire PSLVERR;

    // Instantiate DUT
    noWait_APB_slave #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PADDR(PADDR),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR)
    );


    initial begin
	$dumpfile("APB.vcd");
	$dumpvars(0, tb_noWait_APB_slave);
    end

    // Clock generation
    always #5 PCLK = ~PCLK;

    // Test sequence
    initial begin
        // Initial state
        PCLK = 1;
        PRESETn = 1;
        PSEL = 0;
        PENABLE = 0;
        PADDR = 0;
        PWRITE = 0;
        PWDATA = 0;

        // Write phase: write 8'hAA to address 0
        #12;
        PADDR = 5'd0;
        PWRITE = 1;
        PSEL = 1;
        PENABLE = 0;  // Setup phase
        PWDATA = 8'hAA;

        #10;
        PENABLE = 1;  // Access phase

        #10;
        PSEL = 0;
        PENABLE = 0;
	PWDATA = 0;

        // Read phase: read from address 0
        #20;
        PADDR = 5'd0;
        PWRITE = 0;
        PSEL = 1;
        PENABLE = 0;

        #10;
        PENABLE = 1;

        #10;
        PSEL = 0;
        PENABLE = 0;

        // End of simulation
        #20;
        $finish;
    end

endmodule

