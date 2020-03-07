module IM(clk, inst, counter, pc);
    input clk;
    reg [31:0] instructions [0:127];
    output reg [31:0] inst;
    input [2:0] counter;
    input[31:0] pc;
    integer i;
    initial begin //loading all instructions from text file into instruction memory
    	$readmemb("C://INS//testprog1.txt", instructions);
        for(i = 31; i>=0; i = i-1)
        begin
            instructions[4*i] = instructions[i];
            if(i != 0)
                instructions[i] = {32{1'bx}};
        end
    end
    
    always @(posedge clk)
    begin
    	if(counter == 0)
    	begin
    		inst = instructions[pc];
    	end
    end
endmodule