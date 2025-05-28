module AHB_slave#(
	parameter ADDRESS_WIDTH = 5,
	parameter DATA_WIDTH = 8
)(
	input HCLK,
	input HRESETn,
	input HSEL,
	input [1:0] HTRANS,
	input [ADDRESS_WIDTH-1:0] HADDR,
	input HWRITE,
	input [DATA_WIDTH-1:0] HWDATA,
	output [DATA_WIDTH-1:0] HRDATA,
	output PREADY,
	output HRESP
);

localparam IDLE = 2'b0;
localparam BUSY = 2'b01;
localparam NONSEQ = 2'b10;
localparam SEQ = 2'b11;



endmodule
