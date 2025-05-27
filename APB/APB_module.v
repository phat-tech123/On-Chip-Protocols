module noWait_APB_slave#(
	parameter ADDRESS_WIDTH = 5,
	parameter DATA_WIDTH = 8
)(
	input PCLK,
	input PRESETn,
	input PSEL,
	input PENABLE,
	input [ADDRESS_WIDTH-1:0] PADDR,
	input PWRITE,
	input [DATA_WIDTH-1:0] PWDATA,
	output [DATA_WIDTH-1:0] PRDATA,
	output PREADY,
	output PSLVERR
);

// register file
reg [DATA_WIDTH-1:0] register_file [0:2**ADDRESS_WIDTH-1];
reg [DATA_WIDTH-1:0] register_out;
initial begin
       	$readmemb("PROG1.bin", register_file); 
end

assign PREADY = PSEL & PENABLE;
assign PSLVERR = PSEL & !PENABLE;

wire Write_en;
assign Write_en = PWRITE & PREADY;

wire Read_en;
assign Read_en = !PWRITE & PREADY;

always@(posedge PCLK or negedge PRESETn) begin
	if(!PRESETn) begin 
		register_out <= 0;
	end else if(Write_en) begin
		register_file[PADDR] <= PWDATA;
	end else begin
		register_out <= register_file[PADDR];
	end
end

assign PRDATA = (Read_en)? register_out : 8'bz;

endmodule
