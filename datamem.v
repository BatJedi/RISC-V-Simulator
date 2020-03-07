module datamem(addr, dataRead, rw, dataWrite, clk, counter);
input [63:0] addr;
input clk, rw;
input [2:0] counter;
output reg [63:0] dataRead;
input [63:0] dataWrite;
reg [63:0] data [0:31];
integer outfile, i;
initial begin
    $readmemb("C://INS//DM.txt", data);
end
always @ (posedge clk)
begin
    if(rw == 0)
    begin
    dataRead <= data[addr/8];
    end
    else if(rw == 1 && counter == 3)
    begin
    data[addr/8] <= dataWrite;
    end
end
always @ (posedge clk)
if(counter == 4)
begin
    outfile = $fopen("C://INS//DM.txt","w");
    for(i = 0; i<32; i=i+1)
    begin
        $fdisplay(outfile,"%b",data[i]);
    end
    $fclose(outfile);
end
endmodule