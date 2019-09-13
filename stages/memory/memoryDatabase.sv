module memoryDatabase(
    input logic clk,
    input logic reset,
    input logic memWrite,
    input logic [31:0] address,
    input logic [31:0] writeData,
    output logic [31:0] readData,
    output wire [31:0] ioMemory [1023:0]
);


logic [31:0] memory [1023:0];
assign readData = memory[address[11:2]];
assign ioMemory = memory;

always_ff @(negedge clk) begin
    if (reset) begin
        $readmemb("stages/memory/memory.txt",memory);
    end

    else begin
        if (memWrite) begin
            memory[address[31:2]] <= writeData;
        end
    end
end

endmodule