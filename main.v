module main(input clk);
parameter PCSIZE = 64;
wire [31:0] inst;
reg [2:0] counter;
reg [(PCSIZE-1):0] pcin;
wire [(PCSIZE-1):0] pcnxt;

wire [6:0] opcode, funct7;
wire[2:0] funct3;
wire [4:0] rs1, rs2, rd;
wire [63:0] imm;
wire [63:0] bRead, aRead, dataRead;
reg [63:0] ALUoutReg, a, b, wrb;

wire branch, memRW, ALUsrc, ALUzero, regWrite, memToReg, jal, jalr;
wire [3:0] ALUop;
wire [63:0] ALUout;

IM fetch(.clk(clk), .inst(inst), .counter(counter), .pc(pcin));
decoder ID(.inst(inst), .opcode(opcode), .funct7(funct7), .funct3(funct3), .rs1(rs1), .rs2(rs2), .rd(rd));
control cont(.opcode(opcode), .funct7(funct7), .funct3(funct3),.branch(branch), .memRW(memRW), .ALUop(ALUop), .ALUsrc(ALUsrc), .regWrite(regWrite), .memToReg(memToReg), .jal(jal), .jalr(jalr));
reg_file rf(.rs1(rs1),.rs2(rs2), .rd(rd), .a(aRead), .b(bRead), .regWrite(regWrite), .clk(clk), .wval(wrb),.counter(counter));
immGen ig(inst, imm);
ALU alu(.a(a), .b(b), .out(ALUout), .op(ALUop), .ALUzero(ALUzero));
datamem dm(.addr(ALUout), .dataRead(dataRead), .rw(memRW), .dataWrite(bRead), .clk(clk), .counter(counter));

always @(posedge clk)
    if(counter == 2)
        ALUoutReg <= ALUout;

always @(posedge clk)
begin
    if(counter == 1)
    begin 
        a <= aRead;
        b <= (ALUsrc == 1)? bRead:imm;
    end
    if(counter == 3)
        wrb <= (jal == 1 || jalr == 1)? pcin+4:(memToReg == 1)? dataRead:ALUout;
end
assign pcnxt = (jalr == 1)? (ALUout & {{63{1'b1}}, 1'b0}):((branch == 1 && ALUzero == 1)||jal == 1)? (pcin + imm):(pcin + 4);


initial begin
    counter <= 0;
    pcin <= 0;
end

always @(posedge clk)
begin
    if(counter == 4)
        pcin <= pcnxt;
end

always @(posedge clk) //counter
    begin
          if(counter == 4)
            counter <= 0;
          else
     	  counter <= counter+1;
    end

endmodule
