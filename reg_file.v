module reg_file(rs1, rs2, a, b, rd, clk, regWrite, wval, counter);
input [4:0] rs1, rs2, rd;
input regWrite, clk;
input [63:0] wval;
output reg [63:0] a, b;
reg [63:0] regfile [0:31];
input [2:0] counter;
integer i;
integer outfile;
initial begin 
    regfile[0] = 0; 
    for (i = 1; i< 32; i = i+1)
        regfile[i] = 64'bx;
end
always @ (*)
begin
    begin
        a <= regfile[rs1];
        b <= regfile[rs2]; 
    end
end
always @(posedge clk)
begin
    regfile[0] = 0;
    if(regWrite == 1 && counter == 4)
    begin
        regfile[rd] <= wval;
    end
end
always @ (posedge clk)
begin
    outfile = $fopen("C://INS//regfile.txt","w");
    for(i = 0; i<32; i=i+1)
    begin
        $fdisplay(outfile,"%b",regfile[i]);
    end
    $fclose(outfile);
end
endmodule