module programCounter (
    input  logic        clk,
    input  logic        reset,
    input  logic        pcFlush,
    input  logic [31:0] programCounterInput,
    output logic [31:0] programCounterOutput
    );

    always_ff @(negedge clk) begin
        if (reset) begin
            programCounterOutput <= 0;
        end

        else if (pcFlush) begin
            programCounterOutput <= programCounterOutput;
        end

        else begin
            programCounterOutput <= programCounterInput;
		end
    end

endmodule